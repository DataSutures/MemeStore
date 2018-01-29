/*   Created by Kimberly Smith on 11/2/17.
//   CMPS 359
//   Project 5
//   Due: 11-6-2017
//
//   I certify that the unattributed code in this this assignment is entirely my own work.
//
//   Descrrption: This application allows the user to store details about their favorite memes and rate them.
//   Saved memes and their rating are visible in first view in a table. CLicking on a cell allows the user
//   to make changes to their meme. Users can delete and rearrange memes entries from the table and add new memes.
//
//   Currently the app requires that all fields be filled and an image uploaded to AddMeme and save back to the
//   tableview. Was trying to implement an alert about this, but may not get to in before due date. */


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let memeCollection = MemeCollection()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let imageCollector = ImageCollector()
        let navController = window!.rootViewController as!
        UINavigationController
        let memeController = navController.topViewController as!
            MemeViewController
        memeController.memesCollection = memeCollection
        memeController.imageCollector = imageCollector
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let success = memeCollection.saveChanges()
        if (success) {
            print("Saved all memes.")
        }else{
            print("Could not save any of your memes.")
        }
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

