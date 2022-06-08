//
//  BrowserView.swift
//  SimpleWebBrowser
//
//  Created by Maurício Sayão on 30/05/22.
//

import UIKit
import WebKit

protocol BrowserViewDelegate: AnyObject {
    func sendProgress(value: Float)
}

protocol BrowserViewProtocol: AnyObject {
    var delegate: BrowserViewDelegate? { get set }
    func openPage(site: String)
    func reloadPage()
}

final class BrowserView: View, WKNavigationDelegate {
    // MARK: - Delegate
    
    weak var delegate: BrowserViewDelegate?
    
    // MARK: - Subview
    
    private let webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - View codable
    
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
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
    }
    
    // MARK: - WKNavigationDelegate
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            delegate?.sendProgress(value: Float(webView.estimatedProgress))
        }
    }
}

// MARK: - BrowserViewProtocol

extension BrowserView: BrowserViewProtocol {
    func openPage(site: String) {
        guard let url = URL(string: site) else { return }
        webView.load(URLRequest(url: url))
    }
    
    func reloadPage() {
        webView.reload()
    }
}
