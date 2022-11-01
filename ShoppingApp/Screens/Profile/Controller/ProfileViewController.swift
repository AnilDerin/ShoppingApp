//
//  ProfileViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 30.10.2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModel
    
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
                }
            case .didErrorOccurred(let error):
                print(String(describing: error))
            }
        }

    }
}

extension ProfileViewController: ProfileViewDelegate, AlertPresentable {
    func didTapLogOutButton(sender: UIButton) {
        showAlert(title: "Warning",
        message: "Are you sure to sign out ?",
                  cancelButtonTitle: "Cancel") { _ in
            do {
                try Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
            }catch {
                self.showError(error)
            }
        }
    }
}



