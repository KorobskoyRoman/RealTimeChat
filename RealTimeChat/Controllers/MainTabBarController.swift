//
//  MainTabBarController.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 25.01.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let currentUser: MUser
    
    init(currentUser: MUser = MUser(username: "qwe",
                                    email: "qwe",
                                    userImageString: "wqe",
                                    description: "qwe",
                                    sex: "qwe",
                                    id: "qwe")) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listVC = ListViewController(currentUser: currentUser)
        let peopleVC = PeopleViewController(currentUser: currentUser)
        
        tabBar.tintColor = #colorLiteral(red: 0.3272271752, green: 0.6110113263, blue: 1, alpha: 1)
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)!
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig)!
        
        viewControllers = [
            generateNavigationController(rootViewController: peopleVC, title: "People", image: peopleImage),
            generateNavigationController(rootViewController: listVC, title: "Conversation", image: convImage)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        return navigationVC
    }
}
