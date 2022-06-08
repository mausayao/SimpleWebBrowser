//
//  BrowserViewController.swift
//  SimpleWebBrowser
//
//  Created by Maurício Sayão on 30/05/22.
//

import UIKit

protocol BrowserViewControllerLogic: AnyObject {
    func displayView()
    func displaySheet()
}

final class BrowserViewController: ViewController {
    
    // MARK: - Subviews
    
    let progressView = UIProgressView(progressViewStyle: .default)
    
    // MARK: - Properties
    
    private let interactor: BrowserInteractorProtocol
    private let browserView: BrowserView
    
    // MARK: - Init
    
    init(
        browserView: BrowserView,
        interactor: BrowserInteractorProtocol
    ) {
        self.browserView = browserView
        self.interactor = interactor
        super.init()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Open",
            style: .plain,
            target: self,
            action: #selector(displaySheet)
        )
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)

        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
    }
}

// MARK: - Lifecycle

extension BrowserViewController {    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        interactor.requestView()
    }
    
    override func loadView() {
        super.loadView()
        self.view = browserView
        browserView.delegate = self
    }
}

// MARK: - BrowserViewControllerLogic

extension BrowserViewController: BrowserViewControllerLogic {
    func displayView() {
        browserView.openPage(site: "https://google.com")
        title = "google"
    }
    
    @objc func displaySheet() {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        ac.addAction(
            UIAlertAction(title: "apple.com", style: .default) {_ in
                self.browserView.openPage(site: "https://apple.com")
                self.title = "apple"
            }
        )
        
        ac.addAction(
            UIAlertAction(title: "hackingwithswift.com", style: .default) {_ in
                self.browserView.openPage(site: "https://hackingwithswift.com")
                self.title = "hackingwithswift"
            }
        )
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
}

extension BrowserViewController: BrowserViewDelegate {
    func sendProgress(value: Float) {
        progressView.progress = value
    }
}
