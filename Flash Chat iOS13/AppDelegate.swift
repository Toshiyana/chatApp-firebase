//
//  AppDelegate.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Firebaseに関する記述（cocoapods）
        FirebaseApp.configure()
        let db = Firestore.firestore()
        print(db)//cloud firestoreがちゃんと使えるかのテスト(<FIRFirestore: 0x6000019e0b40>みたいなのが出力されてればok)
        
        //IQKeyboardManagerに関する記述（cocoapods）
        IQKeyboardManager.shared.enable = true//導入
        //各プロパティの設定（https://github.com/hackiftekhar/IQKeyboardManager/wiki/Properties-&-Functions）
        IQKeyboardManager.shared.enableAutoToolbar = false//Toolbarの非表示
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true//キーボード外をtapしたらキーボードを閉じる
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

