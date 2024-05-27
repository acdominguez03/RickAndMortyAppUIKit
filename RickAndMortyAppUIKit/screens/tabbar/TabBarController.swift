//
//  TabBarController.swift
//  RickAndMortyAppUIKit
//
//  Created by Andres Cordón on 27/5/24.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    private var characterListViewController: CharacterListViewController
    private var locationsListViewController: LocationsListViewController
    private var episodesListViewController: EpisodesListViewController
    
    init(characterListViewController: CharacterListViewController, locationsListViewController: LocationsListViewController, episodesListViewController: EpisodesListViewController) {
        self.characterListViewController = characterListViewController
        self.locationsListViewController = locationsListViewController
        self.episodesListViewController = episodesListViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(code: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = false
        viewControllers = loadControllers()
    }
    
    private func loadControllers() -> [UIViewController] {
        var controllers: [UIViewController] = .init()
        
        //characters view controller
        characterListViewController.tabBarItem = UITabBarItem(title: "Characters", image:  UIImage(named: "character"), tag: 0)
       
        let charactersNav = UINavigationController(rootViewController: characterListViewController)
        
        controllers.append(charactersNav)
        
        //episodes view controller
        episodesListViewController.tabBarItem = UITabBarItem(title: "Episodes", image:  UIImage(named: "episode"), tag: 1)
        controllers.append(episodesListViewController)
        
        //locations view controller
        locationsListViewController.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(named: "location"), tag: 2)
        controllers.append(locationsListViewController)
        
        return controllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
