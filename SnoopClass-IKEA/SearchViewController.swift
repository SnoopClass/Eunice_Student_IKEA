//
//  ViewController.swift
//  SnoopClass-IKEA
//
//  Created by Hyorim Nam on 2022/10/01.
//

import UIKit

class SearchViewController: UIViewController {
    fileprivate var recent, category: CompactCard?
    fileprivate var campaign, popular: DetailCard?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        readFile()
    }
}

// 참고 코드: https://alep.medium.com/swiftui-tutorial-how-to-read-a-json-file-73fd960ec954
extension SearchViewController {
    fileprivate func readFile() {
        if let url = Bundle.main.url(forResource: "ikeaSearchViewMockData", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            guard (try? decoder.decode(Ikea.self, from: data)) != nil else {
                print("Ikea decoder failed")
                return
            }
            if let ikeaData = try? decoder.decode(Ikea.self, from: data) {
                self.recent = ikeaData.recent
                self.category = ikeaData.category
                self.campaign = ikeaData.campaign
                self.popular = ikeaData.popular
            }
        } else {
            print("url failed")
        }
    }
}
