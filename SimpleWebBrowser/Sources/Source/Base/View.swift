//
//  View.swift
//  SimpleWebBrowser
//
//  Created by Maurício Sayão on 29/05/22.
//

import UIKit

class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension View: ViewCodable {
    func viewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func viewConfiguration() {
        backgroundColor = .white
    }
}
