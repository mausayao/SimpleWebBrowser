//
//  BrowserViewController.swift
//  SimpleWebBrowser
//
//  Created by Maurício Sayão on 30/05/22.
//

import UIKit

protocol BrowserViewControllerLogic: AnyObject {
    func displayView()
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
}

// MARK: - Lifecycle

extension BrowserViewController {    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        browserView.configureView()
    }
}
