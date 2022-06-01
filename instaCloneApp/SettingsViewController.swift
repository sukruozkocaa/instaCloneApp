//
//  SettingsViewController.swift
//  instaCloneApp
//
//  Created by Şükrü Özkoca on 26.05.2022.
//

import UIKit
import Firebase
import SwiftUI
class SettingsViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.round(cornerRadius: self.imageView.frame.size.width/2, borderWidth: 3.0, borderColor: UIColor.orange)
    }
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }
        catch{
            print("error")
        }
       
    }
    
}
