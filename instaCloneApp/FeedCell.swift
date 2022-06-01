//
//  FeedCell.swift
//  instaCloneApp
//
//  Created by Şükrü Özkoca on 28.05.2022.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    
    
    @IBOutlet weak var imageCellView: UIImageView!
    @IBOutlet weak var useremailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet var documentIDLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCellView.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func likeSelected(_ sender: Any) {
        let fireStoreDatabase = Firestore.firestore()
        
        if let  likeCount = Int(likeLabel.text!) {
            
            let likeStore = ["likes" : likeCount + 1 ] as [String : Any]
            fireStoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(likeStore, merge: true )
        }
        
        
        
    }
    
}
