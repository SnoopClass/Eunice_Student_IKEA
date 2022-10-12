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

    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var recentHorizontalStackView: UIStackView!
    private var searchController: UISearchController = {
        return UISearchController(searchResultsController: SearchResultViewController())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        readFile()
        configSearchController()
        configRecentSection()
    }
}

extension SearchViewController {
    private func configSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self

        searchController.searchBar.placeholder = "무엇을 찾고 있나요?"
        searchController.searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: UISearchBar.Icon.search, state: .normal)
        searchController.searchBar.backgroundColor = .systemBackground
        searchController.searchBar.searchTextField.layer.cornerRadius = 16
        searchController.searchBar.searchTextField.clipsToBounds = true
        searchStackView.addArrangedSubview(searchController.searchBar)
    }
    private func configRecentSection() {
        recentHorizontalStackView.backgroundColor = .systemBlue
        let sourceImage = UIImage(named: "temp-item")!
        print(sourceImage.size)

        for _ in 0...2 {
            let atest = UIImageView(image: sourceImage)
            atest.layer.borderColor = UIColor.systemYellow.cgColor
            atest.layer.borderWidth = 3
            atest.contentMode = .scaleAspectFit
            
            // atest.layer.cornerRadius = atest.frame.size.height/2
            atest.clipsToBounds = true
            recentHorizontalStackView.addArrangedSubview(atest)
        }
    }
}

// 참고 코드: https://alep.medium.com/swiftui-tutorial-how-to-read-a-json-file-73fd960ec954
extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate {
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
