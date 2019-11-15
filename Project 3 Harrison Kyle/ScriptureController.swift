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
    
    @IBOutlet weak var scriptureView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scriptureView.navigationDelegate = self
        ScriptureRenderer.shared.injectGeoPlaceCollector(accessPoint.shared)
        let html = ScriptureRenderer.shared.htmlForBookId(SelectedRows.selectedBook!.id, chapter: SelectedRows.selectedChapter ?? 0)
        scriptureView.loadHTMLString(html, baseURL: nil)
        print(html)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(mapIt))

    }
    
    @objc func mapIt() {
        performSegue(withIdentifier: "ShowMap", sender: self)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(navigationAction.request.url)
        if true {
            print("This worked")
            decisionHandler(.allow)
        }
        else {
            decisionHandler(.cancel)
        }
    }
}
