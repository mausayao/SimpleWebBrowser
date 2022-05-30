//
//  BrowserPresenter.swift
//  SimpleWebBrowser
//
//  Created by Maurício Sayão on 30/05/22.
//

import Foundation

protocol BrowserPresentationLogic: AnyObject {
    func presentView()
}

final class BrowserPresenter: BrowserPresentationLogic {
    
    // MARK: - Properties
    
    weak var viewController: BrowserViewControllerLogic?
    
    // MARK: - BrowserPresentationLogic
    
    func presentView() {
        viewController?.displayView()
    }
}
