//
//  AppDelegate.swift
//  CleanArch
//
//  Created by Rza Ismayilov on 30.07.22.
//

import data
import domain
import presenter
import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: UISceneSession Lifecycle
    
    var window: UIWindow?

    public let assembler: Assembler = .init([
        DataDI(baseURL: "http://0.0.0.0:3001"),
        PresenterDI(),
        DomainDI()
    ])

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = self.assembler.resolver.resolve(HomeViewController.self)!
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        self.window?.makeKeyAndVisible()

        return true
    }





}

