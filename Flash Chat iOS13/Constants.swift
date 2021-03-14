//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Toshiyana on 2021/03/11.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

// 定数を扱うConstants fileの構造体名は，慣習で"K"とする．

struct K {
    static let appName = "⚡️ToshiChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
