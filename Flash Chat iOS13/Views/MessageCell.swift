//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Toshiyana on 2021/03/12.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    // viewDidLoad()みたいなもの
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 3//メッセージcellの角を丸くする（高さで割ることで文字数・高さによらず同じように丸くなる）,leftImageを後から追加したのでcellのサイズが変わり丸み具合が変わっているのでその場合は割る数を変える
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //UILabelを文字数に合わせて複数行にする処理
}
