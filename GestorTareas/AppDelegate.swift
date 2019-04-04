//
//  AppDelegate.swift
//  GestorTareas
//
//  Created by winston majano on 3/10/19.
//  Copyright © 2019 whack. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //cargar las tareas
        TaskManager.sharedInstance.load()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        //guardar nuestras tareas
        TaskManager.sharedInstance.save()
               
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       TaskManager.sharedInstance.save()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        TaskManager.sharedInstance.load()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        TaskManager.sharedInstance.load()
    }

    func applicationWillTerminate(_ application: UIApplication) {
       TaskManager.sharedInstance.save()
    }


}

