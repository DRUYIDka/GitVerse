//
//  CustomTabBarViewController.swift
//  wordcoin3
//
//  Created by admin on 17.02.2024.
//  Copyright © 2024 admin. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UIViewController, UIViewControllerTransitioningDelegate {


    @IBOutlet weak var PlayButton: UIButton!
    let transition = CircularTransition()
    //tabbar
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomTabView: UIView?
    @IBOutlet var selectedStateView: [UIView]!
    var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showRulesAlert()
        PlayButton.layer.cornerRadius = PlayButton.frame.size.width / 2
        bottomTabView?.layer.cornerRadius = (bottomTabView?.frame.size.height ?? 0.0) / 2.0
        handleSelectedViews(current: 0)
        
    }
    func showRulesAlert(){
        let alert = UIAlertController(title: "Игра окончена", message: "Вы проиграли! Хотите сыграть еще?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { action in
            if let myViewController = self.storyboard?.instantiateViewController(withIdentifier: "CustomTabBarViewController") {
                self.present(myViewController, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action) in
            if let myViewController = self.storyboard?.instantiateViewController(withIdentifier: "ZnakViewController") {
                self.present(myViewController, animated: true, completion: nil)
            }
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuVC = segue.destination as! MenuViewController
        menuVC.transitioningDelegate = self
        menuVC.modalPresentationStyle = .custom
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingpoint = PlayButton.center
        transition.circleColor = PlayButton.backgroundColor!
        
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingpoint = PlayButton.center
        transition.circleColor = PlayButton.backgroundColor!
        
        return transition
    }
    
    @IBAction func Button(_ sender: UIButton) {
        let tag = sender.tag
        handleSelectedViews(current: tag)
        
        if tag == 0 {
            let controller = main.instantiateViewController(withIdentifier: String(describing: ZnakViewController.self))
            addChild(controller)
            containerView.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        } else if tag == 1{
            let controller = main.instantiateViewController(withIdentifier: String(describing: ShopViewController.self))
            addChild(controller)
            containerView.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            
        } else if tag == 2{
            let controller = main.instantiateViewController(withIdentifier: String(describing: SettingsViewController.self))
            addChild(controller)
            containerView.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        } else if tag == 3{
            let controller = main.instantiateViewController(withIdentifier: String(describing: ProfileViewController.self))
            addChild(controller)
            containerView.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            controller.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            controller.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            controller.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            controller.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        }
    }
    
    func handleSelectedViews(current state: Int){
        selectedStateView.forEach{selectedView in
            print(selectedView.tag)
           selectedView.isHidden = (selectedView.tag != state)
        }
    }
}
