//
//  BrowserView.swift
//  SimpleWebBrowser
//
//  Created by Maurício Sayão on 30/05/22.
//

import UIKit
import WebKit

protocol BrowserViewProtocol: AnyObject {
    func configureView()
}

final class BrowserView: View, WKNavigationDelegate {
    
    // MARK: - Subview
    
    private let webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewHierarchy() {
        super.viewHierarchy()
        addSubview(webView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewConfiguration() {
        super.viewConfiguration()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
}

// MARK: - BrowserViewProtocol

extension BrowserView: BrowserViewProtocol {
    func configureView() {
        let url = URL(string: "https://www.apple.com")!
        webView.load(URLRequest(url: url))
    }
}
