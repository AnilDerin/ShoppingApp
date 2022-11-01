//
//  ProfileViewModel.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 1.11.2022.
//

import Foundation
import FirebaseFirestore



enum ProfileChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchUser
}

class ProfileViewModel {
    
    let db = Firestore.firestore()
    
    let userDefaults = UserDefaults.standard
    
    var changeHandler: ((ProfileChanges) -> Void)?
    
    private(set) var userDict: [String : Any]? {
        didSet {
            self.changeHandler?(.didFetchUser)
        }
    }
    
    
    func getCollectionData() {
        guard let uid = userDefaults.object(forKey: "uid") else {return}
        
        let docRef = db.collection("users").document(uid as! String)
        
        docRef.getDocument { (document, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    self.userDict = data
                    print(self.userDict?["email"] ?? "")
                }
            }
        }
    }

}
