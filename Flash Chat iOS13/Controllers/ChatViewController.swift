//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tableView.delegate = self//今回はcellとuserがやりとりをしないので必要ない
        tableView.dataSource = self//UITableViewDataSourceプロトコルに従わせる場合に記述
        title = K.appName
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)//自作xibファイルのuiを登録(nibName: xibファイル名)
        
        loadMessages()
    }
    
    // databaseからmessageを読み取る
    func loadMessages() {
        // messageアプリのようにメッセージを送るたびにdatabaseをrealtimeで読み取る場合，.getDocuments()でなく，.addSnapshotListenerを使用
        //.order()で送信時刻順に上から表示
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from Firebase. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()//.data(): [key: value]のペアを取り出す
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            //UserInterfaceを更新するとき，closure内にいる場合は，main threadで処理する（深く理解できてないので後で調べる）
                            DispatchQueue.main.async {
                                self.tableView.reloadData()//tableViewのreload
                                
                                //スクロール処理(データを表示するとき，新たにmessageが送信されたときに自動で一番下にスクロール)
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)//rowは配列番号で一番最後の要素番号を指定, sectionはtableViewの区切りのようなもので今回は0
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
        
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageSender = Auth.auth().currentUser?.email, let messageBody = messageTextfield.text {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970//1970年からの時間(second)
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    //closure内でuser interfaceをupdateする場合，その処理をDispatchQueue.main.async {}内で書き, background threadでなく，main threadで処理させる．
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
        //tryの処理を実行してエラーでないときに実行
        navigationController?.popToRootViewController(animated: true)
        
    } catch let signOutError as NSError {//tryの処理を実行してエラーだったら，catchの処理を実行
      print ("Error signing out: %@", signOutError)
    }
      
    }
    
}

extension ChatViewController: UITableViewDataSource {
    //表示するcellの数をreturnする
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //.xibファイルの自作cellを利用した場合
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell//as!によりUITableViewCellからMessageCellに強制的DownCast
        cell.label.text = message.body
        
        //This is a message from the current user
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        //This is a message from another user
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        //appleの標準cellを利用した場合
//        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row)"//セルの番号を画面に表示
//        cell.textLabel?.text = messages[indexPath.row].body
        
        return cell
    }
}

// 今回は以下のDelegateは必要ない
//cellとuserがやりとりする場合はUITableViewDelegateを従わせる（userがcellにタップして何かさせる場合 ex:ToDoList Appなど）
//extension ChatViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)//cellをタップすると，cell番号をdebug consoleに出力
//    }
//}
