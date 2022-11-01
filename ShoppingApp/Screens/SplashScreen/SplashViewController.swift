//
//  SplashViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 24.10.2022.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    private var animationView: LottieAnimationView?


    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        
            animationView = .init(name: "36605-shopping-cart")
          
          animationView!.frame = view.bounds
          
          // 3. Set animation content mode
          
          animationView!.contentMode = .scaleAspectFit
          
          // 4. Set animation loop mode
          
          animationView!.loopMode = .loop
          
          // 5. Adjust animation speed
          
          animationView!.animationSpeed = 0.5
          
          view.addSubview(animationView!)
          
          // 6. Play animation
          
          animationView!.play()
        
        
        // Waits 2 seconds and goes to home screen
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5){
           let onboardVC = OnboardContainerViewController()
           self.navigationController?.setViewControllers([onboardVC], animated: true)

           self.animationView?.stop()
        }
    }
    

}
