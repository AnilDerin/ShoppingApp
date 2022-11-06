//
//  OnboardContainerViewController.swift
//  ShoppingApp
//
//  Created by Bartu Gençcan on 24.10.2022.
//

import UIKit

class OnboardContainerViewController: UIViewController {
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let skipButton = UIButton(type: .system)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardViewController(heroImageName: "bags", titleText: "Welcome", descriptonText: "Swift Shop is an app that lets users to buy the items they want.")
        let page2 = OnboardViewController(heroImageName: "eCommerce", titleText: "E-Commerce", descriptonText: "Swift Shop aims to be the best E-Commerce experience on the market.")
        let page3 = OnboardViewController(heroImageName: "cart", titleText: "Cart", descriptonText: "Swift Shop has a cart that users can add items and delete them.")
        
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemOrange
        
        UserDefaults.standard.bool(forKey: "hasOnboarded")
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        
        pageViewControllerLayout()
        configureSkipButton()
        skipButtonLayout()
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
        
    }
    
    // MARK: - Methods
    private func pageViewControllerLayout(){
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    private func configureSkipButton(){
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .primaryActionTriggered)
        
        view.addSubview(skipButton)
    }
    
    private func skipButtonLayout(){
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(view.snp.trailing).offset(-18.0)
        }
    }
}
    
// MARK: - UIPageViewControllerDataSource
extension OnboardContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: - Actions
extension OnboardContainerViewController {
    @objc
    private func skipTapped(_ sender: UIButton){
        UserDefaults.standard.set(true, forKey: "hasOnboarded")
        let loginVC = LoginViewController(viewModel: LoginViewModel())
        self.navigationController?.setViewControllers([loginVC], animated: true)
    }
}
