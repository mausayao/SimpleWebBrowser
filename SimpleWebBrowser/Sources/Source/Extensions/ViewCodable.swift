//
//  ViewCodable.swift
//  SimpleWebBrowser
//
//  Created by Maurício Sayão on 29/05/22.
//

import Foundation

protocol ViewCodable: AnyObject {
    func viewHierarchy()
    func setupConstraints()
    func viewConfiguration()
}

extension ViewCodable {
    func setup() {
        viewHierarchy()
        setupConstraints()
        viewConfiguration()
    }
}
