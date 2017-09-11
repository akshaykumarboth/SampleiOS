//
//  AppDelegate.swift
//  ViksitIOS
//
//  Created by Istar Feroz on 24/07/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var isUserLoggedIn: Bool?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //for temporary testing
        /*
        let file = "DummyData.txt" //this is the file. we will read from it
        */
        
        DataCache.sharedInstance.cache["complexObject"] = Helper.readFromFile(fileName: "DummyData", extnsion: "txt")

        /*
        //for solid testing
        if DataCache.sharedInstance.cache["complexObject"] == nil {
            var response: String = Helper.makeHttpCall (url : "http://elt.talentify.in/t2c/user/4972/complex", method: "GET", param: [:])
            DataCache.sharedInstance.cache["complexObject"] = response
        }

 */
        //http://elt.talentify.in/t2c/get_lesson_details?taskId=277274&userId=4972 // for assessment response
        
        return true
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

