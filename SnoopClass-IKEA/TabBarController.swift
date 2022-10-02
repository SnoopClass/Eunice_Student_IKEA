//
//  TabBarController.swift
//  SnoopClass-IKEA
//
//  Created by Hyorim Nam on 2022/10/02.
//

import UIKit

// 아이콘의 SF symbol 이름 스트링
enum TabIcon: String {
    case home = "house"
    case search = "rectangle.and.text.magnifyingglass"
    case user = "person"
    case wish = "heart"
    case cart = "bag"
}

class TabBarController: UITabBarController {
    // 탭바의 각 탭
    private lazy var homeViewController: UIViewController = {
        $0.view.backgroundColor = .systemBrown
        $0.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabIcon.home.rawValue), tag: 0)
        return $0
    }(UIViewController())
    // 상품 상세페이지로 이동시 네비게이션컨트롤러를 사용하므로 미리 넣음
    private lazy var searchViewController: UINavigationController = {
        let viewController = SearchViewController()
        viewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabIcon.search.rawValue), tag: 1)
        return UINavigationController(rootViewController: viewController)
    }()
    private lazy var userViewController: UIViewController = {
        $0.view.backgroundColor = .systemMint
        $0.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabIcon.user.rawValue), tag: 2)
        return $0
    }(UIViewController())
    private lazy var wishViewController: UIViewController = {
        $0.view.backgroundColor = .systemPink
        $0.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabIcon.wish.rawValue), tag: 3)
        return $0
    }(UIViewController())
    private lazy var cartViewController: UIViewController = {
        $0.view.backgroundColor = .systemGreen
        $0.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: TabIcon.cart.rawValue), tag: 4)
        return $0
    }(UIViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            homeViewController,
            searchViewController,
            userViewController,
            wishViewController,
            cartViewController
        ]
        // 탭바 모양 세팅
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        tabBar.layer.borderColor = UIColor.label.cgColor
        tabBar.layer.borderWidth = 0.3
        // 스크롤 끝에서 보더만 사라지는 것은 스크롤뷰 구현 후 tabBar.scrollEdgeAppearance 와 https://madilyn.tistory.com/23 를 참고해 해볼 예정

        // 시작 탭뷰 설정
        self.selectedIndex = 1
    }
}
