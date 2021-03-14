////
////  WelcomeViewController.swift
////  Flash Chat iOS13
////
////  Created by Angela Yu on 21/10/2019.
////  Copyright © 2019 Angela Yu. All rights reserved.
////
//
//import UIKit
//import CLTypingLabel
//
//class WelcomeViewController: UIViewController {
//
//    @IBOutlet weak var titleLabel: CLTypingLabel!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        titleLabel.text = "⚡️ToshiChat"//podのCLTypingLabelを利用した場合，この一行で文字のアニメーション表示が可能
//
//    // podのCLTypingLabelを使わずに文字をアニメーション表示した場合（UILabel!）
////        titleLabel.text = ""
////        var charIndex = 0.0 //TimeIntervalと積を取るのでDoubleにする
////        let titleText = "⚡️ToshiChat"
////
////        for letter in titleText {
////            // withTimeInterval: 0.1だと全文字が同時刻でタイマーがスタートしてしまい，一度に表示されてしまう
////            // charIndexとすることで，表示をずらすことができ，アニメーション表示される．
////            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
////                self.titleLabel.text?.append(letter)
////            }
////            charIndex += 1
////        }
//    }
//}
//
