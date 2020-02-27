//
//  DetailViewController.swift
//  Project16
//
//  Created by Mohammed Hamdi on 9/4/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var link: String = ""
    var viewTitle: String = ""
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewTitle

        let url = URL(string: link)!
        webView.load(URLRequest(url: url))
    }
    


}
