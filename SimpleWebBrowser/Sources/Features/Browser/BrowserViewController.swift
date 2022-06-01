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
