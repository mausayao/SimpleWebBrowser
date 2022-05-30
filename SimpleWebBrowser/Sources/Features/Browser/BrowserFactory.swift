//
//  BrowserFactory.swift
//  SimpleWebBrowser
//
//  Created by Maurício Sayão on 30/05/22.
//

final class BrowserFactory {
    func setup() -> BrowserViewController {
        let presenter = BrowserPresenter()
        let interactor = BrowserInteractor(presenter: presenter)
        let view = BrowserView()
        let viewController = BrowserViewController(browserView: view, interactor: interactor)
        presenter.viewController = viewController
        
        return viewController
    }
}
