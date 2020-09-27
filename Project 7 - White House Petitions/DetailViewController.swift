//
//  DetailViewController.swift
//  Project 7 - White House Petitions
//
//  Created by Shana Pougatsch on 9/9/20.
//  Copyright © 2020 Shana Pougatsch. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
//MARK:- Properties
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
//MARK:- View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <h2>\(detailItem.title)</h2>
        <p>\(detailItem.body)</p>
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }

}
