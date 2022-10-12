//
//  SmallClasses.swift
//  SnoopClass-IKEA
//
//  Created by Hyorim Nam on 2022/10/11.
//

import UIKit

class SearchResultViewController: UIViewController {
//    private var searchText = "asdf"
//    private let text = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
//        text.text = searchText
//        text.font = .preferredFont(forTextStyle: .largeTitle)
//        text.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(text)
//
//        NSLayoutConstraint.activate([
//            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            text.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
    }
}

// 출처: https://nsios.tistory.com/154 // wwdc18일지도
extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale

        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        
        print("화면 배율: \(UIScreen.main.scale)")// 배수
        print("origin: \(self), resize: \(renderImage)")
        return renderImage
    }
}
