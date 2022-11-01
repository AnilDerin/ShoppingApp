//
//  ProfileViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import UIKit
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        
        getCollectionData { error in
            if let error = error {
                print(error.localizedDescription)
            }else {
                print("complete")
            }
        }
        
    }
    
    func getCollectionData(_ completion: @escaping (Error?) -> Void) {
        guard let uid = userDefaults.object(forKey: "uid") else {return}
        
        db.collection("users").document(uid as! String).getDocument { querySnapshot, error in
            guard let data = querySnapshot?.data() else {return}
            print(data)
        }
    }
            
    
}
