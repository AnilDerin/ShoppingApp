//
//  ProfileViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModel
    
    var myData: Data?
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        view = profileView
        
        
        viewModel.getCollectionData()
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchUser:
                guard let userDict = self.viewModel.userDict else {
                    fatalError("User not found")
                }
                
                self.profileView.email = userDict["email"] as? String
                if userDict["pp"] as? String == "" {
                    self.profileView.image = UIImage(named: "profile")
                }else {
                    
                    guard let url = URL(string: userDict["pp"] as! String) else { return }
                    
                    UIImage.loadFrom(url: url, completion: { image in
                        self.profileView.image = image
                    })
                }
                
                self.profileView.usernameTextField.text = userDict["username"] as? String
            case .didErrorOccurred(let error):
                print(String(describing: error))
            }
        }
        
    }
}

extension ProfileViewController: ProfileViewDelegate, AlertPresentable {
    func didImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        showImagePickerController()
    }
    
    func didTapChangeButton(sender: UIButton) {
        self.profileView.usernameTextField.isUserInteractionEnabled = !self.profileView.usernameTextField.isUserInteractionEnabled
    }
    
    func didTapChangeUserCredentials(sender: UIButton) {
        
        let db = Firestore.firestore()
        
        let userDefaults = UserDefaults.standard
        
        guard let uid = userDefaults.object(forKey: "uid") as? String else {return}
        
        if self.profileView.usernameTextField.text?.count ?? 0 > 3 {
            db.collection("users").document(uid).updateData(["username" : self.profileView.usernameTextField.text ?? ""]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    self.showAlert(title: "Success", message: "Username successfully changed.")
                    self.profileView.usernameTextField.isUserInteractionEnabled = false
                }
            }
            
        }else {
            showAlert(title: "Warning", message: "Username must be at least 3 characters.")
        }
        
    }
    
    func didTapLogOutButton(sender: UIButton) {
        let defaults = UserDefaults.standard
        
        showAlert(title: "Warning",
                  message: "Are you sure to sign out ?",
                  cancelButtonTitle: "Cancel") { _ in
            do {
                try Auth.auth().signOut()
                defaults.set(false, forKey: "isUserLoggedIn")
                let loginVC = LoginViewController(viewModel: LoginViewModel())
                self.navigationController?.pushViewController(loginVC, animated: true)
                loginVC.navigationItem.hidesBackButton = true
            }catch {
                self.showError(error)
            }
        }
    }
}

// MARK: UIImagePickerController
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePickerController(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let storage = Storage.storage()
        
        let userDefaults = UserDefaults.standard
        
        guard let uid = userDefaults.object(forKey: "uid") as? String else {return}
        
        let storageRef = storage.reference().child("user/\(uid)")
        
        let db = Firestore.firestore()
        
        guard let uid = userDefaults.object(forKey: "uid") as? String else {return}
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileView.image = originalImage
            
            dismiss(animated: true, completion: nil)
            
            guard let imageData = originalImage.jpegData(compressionQuality: 0.75) else {return}
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            storageRef.putData(imageData, metadata: metaData){ metaData, error in
                if error == nil, metaData != nil {
                    storageRef.downloadURL { url, error in
                        db.collection("users").document(uid).updateData(["pp" : url?.absoluteString]) { err in
                            if let err = err {
                                print("Error updating document: \(err)")
                            } else {
                                self.showAlert(title: "Success", message: "Profile picture successfully changed.")
                            }
                        }
                    }
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
}




