//
//  ViewController.swift
//  instaCloneApp
//
//  Created by Şükrü Özkoca on 26.05.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailText.backgroundColor = UIColor(red: 0.95 , green: 0.95 , blue: 0.95 , alpha: 1)
        passwordText.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        var lineView = UIView(frame: CGRect(x: 0, y: 650, width: self.view.frame.size.width, height: 0.7))
        lineView.backgroundColor = UIColor.gray
        self.view.addSubview(lineView)
        // Do any additional setup after loading the view.
    }
    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != nil && passwordText.text != nil {
            Auth.auth().signIn(withEmail: emailText.text!, password:passwordText.text!) { authdata, error in
                if error != nil {
                    self.alert(title: "Error", message:error?.localizedDescription ?? "Error")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else {
            alert(title: "HATA", message: "E mail passsword nil")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailText.text != ""  && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    self.alert(title: "HATA", message: error?.localizedDescription ?? "Error")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }
        else {
            alert(title: "Hata!", message: "Email şifre hatalı veya boş!")
           
            
        }
        
       
        
    }
    
    func alert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

