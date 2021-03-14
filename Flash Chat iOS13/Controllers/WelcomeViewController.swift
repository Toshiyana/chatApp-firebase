//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    // Don't show a navigation bar on this view
    //viewWillAppear(): viewが表示される前に行う処理を記述
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true//非表示
    }
    //viewWillDisappear(): viewが消えて，次のviewを表示するまでに行う処理を記述
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false//次の画面では表示
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        var charIndex = 0.0 //TimeIntervalと積を取るのでDoubleにする
        let titleText = K.appName

        for letter in titleText {
            // withTimeInterval: 0.1だと全文字が同時刻でタイマーがスタートしてしまい，一度に表示されてしまう
            // charIndexとすることで，表示をずらすことができ，アニメーション表示される．
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
}
