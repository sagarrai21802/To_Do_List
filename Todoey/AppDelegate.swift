//
//  AppDelegate.swift
//
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

//
//  AppDelegate.swift
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Updated by Sagar Rai on 03/08/2025.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // App launch setup
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Pause tasks, disable timers, etc.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Save state/data here
        self.saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Undo changes made when entering background
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart paused tasks, refresh UI if needed
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called before app terminates
        self.saveContext()
    }

    // MARK: - Core Data Stack

    lazy var persistentContainer: NSPersistentContainer = {
        // Use your actual .xcdatamodeld filename below
        let container = NSPersistentContainer(name: "CoreDataModelForUs")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Handle error appropriately in production apps
                fatalError("Unresolved Core Data error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving Support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Error handling
                let nserror = error as NSError
                fatalError("Unresolved saveContext() error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
