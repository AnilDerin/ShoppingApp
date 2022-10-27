//
//  LoginViewModel.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 26.10.2022.
//

import Foundation
import FirebaseAuth
import FirebaseRemoteConfig
import FirebaseFirestore

enum LoginViewModelChange {
    case didErrorOccured(_ error: Error)
    case didSignUpSuccessful
}



class LoginViewModel {
    
    private let defaults = UserDefaults.standard
    
    var changeHandler: ((LoginViewModelChange) -> Void)?
    
    private let db = Firestore.firestore()
    
    func signUp(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.changeHandler?(.didErrorOccured(error))
                return
            }
            
            let user = User(username: authResult?.user.displayName, email: authResult?.user.email, pp: "", basket: [])
            
            do {
                let data = user.dictionary
                guard let id = authResult?.user.uid else {return}
                
                self.defaults.set(id, forKey: "uid")
                
                try self.db.collection("users").document(id).setData(data) { error in
                    if let error = error {
                        self.changeHandler?(.didErrorOccured(error))
                    } else {
                        self.changeHandler?(.didSignUpSuccessful)
                    }
                }
            } catch {
                self.changeHandler?(.didErrorOccured(error))
            }
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping () -> Void){
        Auth.auth().signIn(withEmail: email, password: password){ [weak self]
            authResult, error in
            if let error = error {
                self?.changeHandler?(.didErrorOccured(error))
                return
            }
            guard let id = authResult?.user.uid else {return}
            
            self?.defaults.set(id, forKey: "uid")
            self?.defaults.set(true, forKey: "isUserLoggedIn")
            
            completion()
        }
    }
    
    func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        
        remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                remoteConfig.activate { _, error in
                    
                    if let error = error {
                        self.changeHandler?(.didErrorOccured(error))
                        return
                    }
                    
                    let isSignUpDisabled = remoteConfig.configValue(forKey: "isSignUpDisabled").boolValue
                    DispatchQueue.main.async {
                        completion(isSignUpDisabled)
                    }
                }
            } else {
                guard let error = error else {
                    return
                }
                self.changeHandler?(.didErrorOccured(error))
            }
        }
    }
}
