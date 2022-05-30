//
//  BrowserInteractor.swift
//  SimpleWebBrowser
//
//  Created by Maurício Sayão on 30/05/22.
//

import Foundation

protocol BrowserInteractorProtocol: AnyObject {
    func requestView()
}

final class BrowserInteractor: BrowserInteractorProtocol {
    
    // MARK: - Properties
    
    private let presenter: BrowserPresentationLogic
    
    // MARK: - Init
    
    init(presenter: BrowserPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - BrowserInteractorProtocol
    func requestView() {
        presenter.presentView()
    }
}
