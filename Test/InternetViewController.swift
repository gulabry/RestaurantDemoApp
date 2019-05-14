//
//  InternetViewController.swift
//  Test
//
//  Created by Bryan Gula on 5/13/19.
//  Copyright © 2019 Bryan Gula. All rights reserved.
//

import UIKit
import WebKit

class InternetViewController: UIViewController {
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return webView
    }()
    
    let baseUrl = URL(string: Constants.bottleRocketUrlString)!
    
    //  Navigation Buttons for Top Bar
    
    lazy var backBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: Constants.backButton, style: .plain, target: self, action: #selector(InternetViewController.backPage(sender:)))
        item.tintColor = .white
        return item
    }()
    
    lazy var forwardBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: Constants.forwardButton, style: .plain, target: self, action: #selector(InternetViewController.forwardPage(sender:)))
        item.tintColor = .white
        return item
    }()
    
    lazy var refreshBarButton: UIBarButtonItem = {
        let item = UIBarButtonItem(image: Constants.refreshButton, style: .plain, target: self, action: #selector(InternetViewController.refreshPage(sender:)))
        item.tintColor = .white
        return item
    }()
    
    //  MARK: View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSafariView()
        setupNavigationButtons()
    }
    
    func setupSafariView() {
        webView.load(URLRequest(url: baseUrl))
    }
    
    func setupNavigationButtons() {
        navigationItem.leftBarButtonItems = [backBarButton, refreshBarButton, forwardBarButton]
    }
    
    //  MARK: Web Page Navigation
    
    @objc func backPage(sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @objc func forwardPage(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @objc func refreshPage(sender: UIBarButtonItem) {
        guard let currentUrl = webView.url else { return }
        webView.load(URLRequest(url: currentUrl))
    }
}

extension InternetViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}

extension InternetViewController: WKUIDelegate {
    
}
