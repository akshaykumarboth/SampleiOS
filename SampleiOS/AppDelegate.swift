//
//  AppDelegate.swift
//  ViksitIOS
//
//  Created by Istar Feroz on 24/07/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var isUserLoggedIn: Bool?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //for temporary testing
        //DataCache.sharedInstance.cache["complexObject"] = Helper.readFromFile(fileName: "DummyData", extnsion: "txt")
        //DataCache.sharedInstance.cache["assessment"] = Helper.readFromFile(fileName: "assessment", extnsion: "txt")

        /*
        //for solid testing
        if DataCache.sharedInstance.cache["complexObject"] == nil {
            var response: String = Helper.makeHttpCall (url : "http://elt.talentify.in/t2c/user/450/complex", method: "GET", param: [:])
            DataCache.sharedInstance.cache["complexObject"] = response
            //var response: String = Helper.makeHttpCall (url : "http://192.168.1.4:8080/t2c/user/6062/complex", method: "GET", param: [:])
        } */

        //http://elt.talentify.in/t2c/get_lesson_details?taskId=277274&userId=4972 // for assessment response
        
        FirebaseApp.configure()
        //Actions
        var firstAction: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "FIRST_ACTION"
        firstAction.title = "First Action"
        firstAction.activationMode = UIUserNotificationActivationMode.background //
        firstAction.isDestructive = true
        firstAction.isAuthenticationRequired = false
        
        var secondAction: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        secondAction.identifier = "SECOND_ACTION"
        secondAction.title = "Second Action"
        secondAction.activationMode = UIUserNotificationActivationMode.foreground///
        secondAction.isDestructive = false
        secondAction.isAuthenticationRequired = false

        var thirdAction: UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        thirdAction.identifier = "THIRD_ACTION"
        thirdAction.title = "Third Action"
        thirdAction.activationMode = UIUserNotificationActivationMode.background
        thirdAction.isDestructive = false
        thirdAction.isAuthenticationRequired = false

        // Category
        var firstCategory: UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "FIRST_CATEGORY"
        
        let defaultActions: NSArray = [firstAction, secondAction, thirdAction]
        let minimalActions: NSArray = [firstAction, secondAction]
        
        firstCategory.setActions(defaultActions as! [UIUserNotificationAction], for: UIUserNotificationActionContext.default)
        firstCategory.setActions(minimalActions as! [UIUserNotificationAction], for: UIUserNotificationActionContext.minimal)
        
        //NSSet of all our categories
        let categories: NSSet = NSSet(objects: firstCategory)
        
        let mysettings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge], categories: categories as! Set<UIUserNotificationCategory>)
        UIApplication.shared.registerUserNotificationSettings(mysettings)
        
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
        x()
    }
    
    func x() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        
        
        
        //ref.child("istar-notification-ios").child("Feroz").setValue(someDictionary)
        ref.child("istar-notification").child("8").observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            for (key, value) in postDict {
                print("my key -> \(key as String)")
                if key  is Dictionary<AnyHashable,Any> {
                    print("Yes, it's a Dictionary")
                    let myref = value as! NSDictionary
                    
                    for(key1, value1) in myref {
                        print("child key -> \(key1 as! String) child values -> \(value1 as Any)")
                    }
                }else{
                    print("No , it's not a Dictionary")
                }
            }
            print("dddd \(postDict)")
            
        })
    }


}

