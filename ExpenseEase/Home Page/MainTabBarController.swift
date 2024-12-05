//
//  MainTabBarController.swift
//  ExpenseEaseMainPage
//
//  Created by Muqing Cao on 27/10/24.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true

        let viewController = HomePageViewController()
        viewController.tabBarItem = UITabBarItem(title: "ExpenseEase", image: UIImage(systemName: "house"), tag: 0)
        
        let trendingViewController = TrendingScreenController()
        trendingViewController.tabBarItem = UITabBarItem(title: "Overview", image: UIImage(systemName: "chart.xyaxis.line"), tag: 2)
        
        let profileViewController = ProfilePageViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), tag: 1)
        
        viewControllers = [
            UINavigationController(rootViewController: viewController),
            UINavigationController(rootViewController: trendingViewController),
            UINavigationController(rootViewController: profileViewController)
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
}
