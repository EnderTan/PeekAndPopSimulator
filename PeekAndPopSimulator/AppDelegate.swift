//
//  AppDelegate.swift
//  PeekAndPopSimulator
//
//  Created by Bing on 15/10/16.
//  Copyright © 2015年 tanyunbing. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    // MARK: Properties
    
    var window: UIWindow?
    
    // MARK: App Delegate
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        splitViewController.delegate = self
        
        return true
    }
    
    // MARK: Split View Delegate
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        
        // Return true if the `detailItemTitle` has not been set, collapsing the secondary controller.
        return topAsDetailController.detailItemTitle == nil
    }
    
}

