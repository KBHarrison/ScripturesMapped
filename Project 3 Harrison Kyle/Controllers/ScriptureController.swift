//
//  ScriptureController.swift
//  Project 3 Harrison Kyle
//
//  Created by IS 543 on 11/11/19.
//  Copyright © 2019 IS 543. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ScriptureController : UIViewController, WKNavigationDelegate {
    
    var geoPlaceId: Int = 0
    private weak var mapViewController: MapController?
    
    
    
    @IBOutlet weak var scriptureView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scriptureView.navigationDelegate = self
        ScriptureRenderer.shared.injectGeoPlaceCollector(accessPoint.shared)
        let html = ScriptureRenderer.shared.htmlForBookId(RowSelector.shared.selectedBook!.id, chapter: RowSelector.shared.selectedChapter ?? 0)
        scriptureView.loadHTMLString(html, baseURL: nil)
        configureDetailViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController {
            if let nextViewController = navController.topViewController as? MapController {
                if let ownTitle = self.title {
                    if geoPlaceId != 0 {
                        nextViewController.pinId = geoPlaceId
                        nextViewController.title = GeoDatabase.shared.geoPlaceForId(geoPlaceId)?.placename
                        nextViewController.lastTitle = ownTitle
                    }
                    else {
                        nextViewController.title = ownTitle
                        nextViewController.lastTitle = ownTitle
                        
                    }
                }
            }
            geoPlaceId = 0
        }
    }
    
    
    private func configureDetailViewController() {
        mapViewController = nil
        if let splitVC = splitViewController {
            if let navVC = splitVC.viewControllers.last as? UINavigationController {
                mapViewController = navVC.topViewController as? MapController
                mapViewController?.showPoints()
                mapViewController?.title = self.title
            }
            else {
                navigationItem.rightBarButtonItem = nil
            }
        }
        configureRightButton()
    }
    
     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         super.viewWillTransition(to: size, with: coordinator)
         if UIDevice.current.orientation.isLandscape {
            navigationItem.rightBarButtonItem = nil
             print("Landscape")
         } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(ScriptureController.showMap))
             print("Portrait")
         }
     }
    
    private func configureRightButton() {
        if mapViewController == nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(ScriptureController.showMap))
        }
    }
    
    @objc func showMap() {
        ScriptureRenderer.shared.injectGeoPlaceCollector(accessPoint.shared)
        let _ = ScriptureRenderer.shared.htmlForBookId(RowSelector.shared.selectedBook!.id, chapter: RowSelector.shared.selectedChapter ?? 0)
        
        performSegue(withIdentifier: "ShowMap", sender: self)
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let URLArray = String(navigationAction.request.mainDocumentURL!.absoluteString).split(separator: "/",maxSplits: 50, omittingEmptySubsequences: true)
        
        if (URLArray.count > 1 && URLArray[1] == "scriptures.byu.edu") {
            decisionHandler(.cancel)
            if let Id = Int(String(URLArray[URLArray.count - 1])) {
                geoPlaceId = Id
                performSegue(withIdentifier: "ShowMap", sender: self)
            }
        }
        else {
            decisionHandler(.allow)
        }
    }
}
