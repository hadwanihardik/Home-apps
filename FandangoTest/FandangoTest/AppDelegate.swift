//
//  AppDelegate.swift
//  FandangoTest
//
//  Created by Hardik on 12/14/17.
//  Copyright © 2017 Hardik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var boxOffice = BoxOfficeViewController();
    var  tabController : UITabBarController = UITabBarController();

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.setUpToolBar()
//        boxOffice = BoxOfficeViewController(nibName: "BoxOfficeViewController", bundle: nil)
//        self.window?.rootViewController = boxOffice
        // Override point for customization after application launch.
        return true
    }
    
    func setUpToolBar()
    {
       let boxOffice = BoxOfficeViewController(nibName: "BoxOfficeViewController", bundle: nil)
       let theaters = TheatersViewController(nibName: "TheatersViewController", bundle: nil)
       let theaters1 = TheatersViewController(nibName: "TheatersViewController", bundle: nil)
       let theaters2 = TheatersViewController(nibName: "TheatersViewController", bundle: nil)
       let theaters3 = TheatersViewController(nibName: "TheatersViewController", bundle: nil)

        
        let tab1 = UINavigationController.init(rootViewController: boxOffice);
        tab1.isNavigationBarHidden =  true
        tab1.tabBarItem = UITabBarItem(title: "Box Office", image: #imageLiteral(resourceName: "boxoffice"), selectedImage: #imageLiteral(resourceName: "boxoffice"))
        
        let tab2 = UINavigationController.init(rootViewController: theaters);
        tab2.isNavigationBarHidden =  true
        tab2.tabBarItem = UITabBarItem(title: "Theaters", image: #imageLiteral(resourceName: "theaters"), selectedImage: #imageLiteral(resourceName: "theaters"))
        
        let tab3 = UINavigationController.init(rootViewController:theaters1 );
        tab3.isNavigationBarHidden =  true
        tab3.tabBarItem = UITabBarItem(title: "At Home", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "home"))
        
        let tab4 = UINavigationController.init(rootViewController: theaters2);
        tab4.isNavigationBarHidden =  true
        tab4.tabBarItem = UITabBarItem(title: "News", image: #imageLiteral(resourceName: "news"), selectedImage: #imageLiteral(resourceName: "news"))
        
        let tab5 = UINavigationController.init(rootViewController: theaters3);
        tab5.isNavigationBarHidden =  true
        tab5.tabBarItem = UITabBarItem(title: "My Movies", image: #imageLiteral(resourceName: "mymovies"), selectedImage: #imageLiteral(resourceName: "mymovies"))
        
        var arra = [UINavigationController]()
        arra = [tab1,tab2,tab3,tab4,tab5];
        tabController.viewControllers = arra
        self.window?.makeKeyAndVisible()
        UITabBar.appearance().tintColor = UIColor.lightGray
        tabController.tabBar.barTintColor = Utils.appBaseColor
        tabController.tabBar.unselectedItemTintColor = UIColor.white

        tabController.tabBar.isTranslucent = false
        tabController.tabBar.layer.borderWidth = 0.50
        tabController.tabBar.layer.borderColor = UIColor.clear.cgColor
        tabController.tabBar.clipsToBounds = true
        self.window?.rootViewController = tabController;

    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

