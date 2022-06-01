//
//  UploadViewController.swift
//  instaCloneApp
//
//  Created by Şükrü Özkoca on 26.05.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var commentText: UITextField!
    @IBOutlet var uploadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        // Do any additional setup after loading the view.
    }
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadClicked(_ sender: Any) {
        
        let uuid = UUID().uuidString
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { metadata, error in
                if error != nil {
                    print(error?.localizedDescription)
                }
                else{
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            // DATABASEE DATABASEE DATABASEE
                            
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReferance : DocumentReference?
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email! , "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp() , "likes" : 0 ] as [String : Any]
                            
                            firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    let alert = UIAlertController(title: "HATA!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                                    alert.addAction(okButton)
                                    self.present(alert, animated: true)
                                }
                                else{
                                    self.imageView.image = UIImage(named: "photo.artframe")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                            
                            
                        }
                    }
                }
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
