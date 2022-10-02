//
//  ViewController.swift
//  SnoopClass-IKEA
//
//  Created by Hyorim Nam on 2022/10/01.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var recent, category: CompactCard?
    fileprivate var campaign, popular: DetailCard?

    override func viewDidLoad() {
        super.viewDidLoad()
        readFile()
        // Do any additional setup after loading the view.
    }


}

// 참고 코드: https://alep.medium.com/swiftui-tutorial-how-to-read-a-json-file-73fd960ec954
extension ViewController {
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
                 print("category.items.count: \(category!.items.count)")
            }
        } else {
            print("url failed")
        }
    }
}
