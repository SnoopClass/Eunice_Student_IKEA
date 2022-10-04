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
        // 이게 여긴지 이전 뷰인지 헷갈림
        navigationController?.setNavigationBarHidden(true, animated: true)
        // setSearchBar()
        configHierarchy()
        // configureDataSource()
        // applyInitialSnapshots()
    }

    // 컬렉션뷰
    enum SearchSection: Int, CaseIterable, CustomStringConvertible {
        case recent, category, campaign, popular
        
        // json 사용하는 방법은 나중에..
        var description: String {
            switch self {
            case .recent: return "최근 본 제품"
            case .category: return "제품 찾아보기"
            case .campaign: return "캠페인"
            case .popular: return "인기 제품"
            // case .default: return ""
            }
        }
    }
    enum Item: Hashable {
        case detailCard(DetailCard)
        case compactCard(CompactCard)
    }
    typealias DataSource = UICollectionViewDiffableDataSource<SearchSection, Item>
    typealias SnapShot = NSDiffableDataSourceSnapshot<SearchSection, Item>

    private var collectionView: UICollectionView!
    private var dataSource: DataSource!
}

extension SearchViewController: UICollectionViewDelegate {
    private func configHierarchy() {
        collectionView = UICollectionView(frame: view.bounds/*.frame?*/, collectionViewLayout: createLayout())
        // collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemCyan
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    // 리아 건데 모르겠음
//    private func configHeaderFooterLayout() -> [NSCollectionLayoutBoundarySupplementaryItem] {
//        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
//        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: "sectionheaderelementkind", alignment: .topLeading)
//    }
    func createLayout() -> UICollectionViewLayout {
        // 컴포지셔널 레이아웃 실체
        let sectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = SearchSection(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            // let margin = 10.0
            // let defaultMargin = NSDirectionalEdgeInsets(top: margin, leading: margin, bottom: margin, trailing: margin)
            
            // orthogonal scrolling section of images
            if sectionKind == .recent {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalWidth(0.2)) // 바꿀 것
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            } else if sectionKind == .category {
                // orthogonal sections // nested groups
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalWidth(0.6)) // 바꿀 것
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            } else if sectionKind == .campaign {
                // conference app videos
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.6))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.9)) // 바꿀 것
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            } else if sectionKind == .popular {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalWidth(0.7)) // 바꿀 것
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            } else {
                fatalError("Unknown section!")
            }
            
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
/*
    func createRoundGridCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewCell, CompactCard> {
        return UICollectionView.CellRegistration<UICollectionViewCell, CompactCard> { (cell, indexPath, item) in
            var content = UIListContentConfiguration.cell()
            content.name = item.name
            content.textProperties.font = .boldSystemFont(ofSize: 38)
            content.textProperties.alignment = .center
            content.directionalLayoutMargins = .zero
            cell.contentConfiguration = content
            var background = UIBackgroundConfiguration.listPlainCell()
            background.cornerRadius = 8
            background.strokeColor = .systemGray3
            background.strokeWidth = 1.0 / cell.traitCollection.displayScale
            cell.backgroundConfiguration = background
        }
    }

    func configureDataSource() {
        // create registrations up front, then choose the appropriate one to use in the cell provider
        let gridRoundCellRegistration = createGridCellRegistration()
        
        // data source
        dataSource = UICollectionViewDiffableDataSource<SearchSection, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            switch section {
            case .recent:
                return collectionView.dequeueConfiguredReusableCell(using: gridCellRegistration, for: indexPath, item: item.emoji)
            case .category:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: item)
            case .campaign:
            case .popular:
                if item.hasChildren {
                    return collectionView.dequeueConfiguredReusableCell(using: outlineHeaderCellRegistration, for: indexPath, item: item.title!)
                } else {
                    return collectionView.dequeueConfiguredReusableCell(using: outlineCellRegistration, for: indexPath, item: item.emoji)
                }
            }
        }
    }
    
    /// - Tag: SectionSnapshot
    func applyInitialSnapshots() {

        // set the order for our sections

        let sections = SearchSection.allCases
        var snapshot = NSDiffableDataSourceSnapshot<SearchSection, Item>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        // recents (orthogonal scroller)
        
        let recentItems = recent.items.map { Item(emoji: $0) }
        var recentsSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        recentsSnapshot.append(recentItems)
        dataSource.apply(recentsSnapshot, to: .recents, animatingDifferences: false)

        // list of all + outlines
        
        var allSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        var outlineSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        
        for category in Emoji.Category.allCases where category != .recents {
            // append to the "all items" snapshot
            let allSnapshotItems = category.emojis.map { Item(emoji: $0) }
            allSnapshot.append(allSnapshotItems)
            
            // setup our parent/child relations
            let rootItem = Item(title: String(describing: category), hasChildren: true)
            outlineSnapshot.append([rootItem])
            let outlineItems = category.emojis.map { Item(emoji: $0) }
            outlineSnapshot.append(outlineItems, to: rootItem)
        }
        
        dataSource.apply(recentsSnapshot, to: .recents, animatingDifferences: false)
        dataSource.apply(allSnapshot, to: .list, animatingDifferences: false)
        dataSource.apply(outlineSnapshot, to: .outline, animatingDifferences: false)
        
        // prepopulate starred emojis
        
        for _ in 0..<5 {
            if let item = allSnapshot.items.randomElement() {
                self.starredEmojis.insert(item)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let emoji = self.dataSource.itemIdentifier(for: indexPath)?.emoji else {
            collectionView.deselectItem(at: indexPath, animated: true)
            return
        }
        let detailViewController = EmojiDetailViewController(with: emoji)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
 */
}
// data
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
