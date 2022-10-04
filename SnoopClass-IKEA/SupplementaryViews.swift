//
//  SupplementaryViews.swift
//  SnoopClass-IKEA
//
//  Created by Hyorim Nam on 2022/10/05.
//

import UIKit

let lpadding = 16.0
let spadding = 8.0

class HeaderReusableView: UICollectionReusableView {
    lazy var sectionTitle = UILabel()
    lazy var button: UIButton = {
        $0.titleLabel?.text = "asdf"
        let buttonAction = UIAction { _ in

        }
        $0.addAction(buttonAction, for: .touchUpInside)
        return $0
    }(UIButton())

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBrown
        addSubview(sectionTitle)
        addSubview(button)
        configLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configFont() {
        sectionTitle.font = UIFont.preferredFont(forTextStyle: .headline)
        sectionTitle.textAlignment = .left
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        button.titleLabel?.textColor = .systemGray
        button.titleLabel?.textAlignment = .right
    }

    private func configLayout() {
        [sectionTitle, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            sectionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: lpadding),
            sectionTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            sectionTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            sectionTitle.widthAnchor.constraint(greaterThanOrEqualToConstant: 10),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: lpadding),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 10)
        ])
    }
}

class SearchView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InfoView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemMint
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
