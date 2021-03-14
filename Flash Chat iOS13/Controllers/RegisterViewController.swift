//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {//エラーがあった場合
                    //今回は出力しているだけだが，実際ではUserに対してPopUpなどを表示してあげる
                    print(e.localizedDescription)//.localizedDescriptionでiphoneに設定された言語でエラーを表示
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)//画面遷移
                }
            }
        }
        
        
    }
    
}
