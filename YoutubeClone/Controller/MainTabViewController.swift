//
//  HomeViewController.swift
//  YoutubeClone
//
//  Created by mert can çifter on 14.02.2023.
//

import UIKit
import SDWebImage

class MainTabViewController: UITabBarController {

    // MARK: - Properties
    
    private let userImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        return iv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewControllers()
        configureImageView()
        
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        tabBar.standardAppearance = appearance
    }
    
    func configureViewControllers(){
        let vc1 = ContentViewController()
        let vc2 = ShortsViewController()
        let vc3 = BookCaseViewController()
                
        tabBar.tintColor = .label
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.title = "home".localized()
        vc2.tabBarItem.image = UIImage(systemName: "play.rectangle")
        vc2.tabBarItem.title = "shorts".localized()
        vc3.tabBarItem.image = UIImage(systemName: "list.bullet")
        vc3.tabBarItem.title = "bookcase".localized()
  
        setViewControllers([vc1,vc2,vc3], animated: true)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: userImageView),
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil),
        ]
        
        navigationItem.rightBarButtonItems?.forEach({ item in
            item.tintColor = .label
        })
    }
    
    func configureImageView(){
        userImageView.sd_setImage(with: URL(string: "https://picsum.photos/200/300"))
        userImageView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(40)
        }
        userImageView.layer.cornerRadius = 40 / 2
    }
}



