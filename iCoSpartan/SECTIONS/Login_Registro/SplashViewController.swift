//
//  SplashViewController.swift
//  iCoSpartan
//
//  Created by Andres Felipe Ocampo Eljaiesk on 4/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import Parse

class SplashViewController: UIViewController {

    
    //MARK: - Variables locales
    var viewAnimator : UIViewPropertyAnimator!
    var desbloqueoGesto = Timer()
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageLogoSaldos: UIImageView!
    @IBOutlet weak var myComprobacionInternet: UIImageView!
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentReachabilityStatus != .notReachable) //true connected
        if(currentReachabilityStatus == .notReachable){
            UIView.animate(withDuration: 3,
                           animations: {
                            self.myComprobacionInternet.isHidden = false
            })
        }else{
            self.showData()
        }
    }
    
    
    func showData(){
        viewAnimator = UIViewPropertyAnimator(duration: 1.0,
                                              curve: .easeInOut,
                                              animations: {
                                                self.myImageLogoSaldos.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                                self.desbloqueoGesto = Timer.scheduledTimer(timeInterval: 1.5,
                                                                                            target: self,
                                                                                            selector: #selector(self.manejadorAutomatico),
                                                                                            userInfo: nil,
                                                                                            repeats: false)
        })
        viewAnimator.startAnimation()
    }
    
    
    //MARK: - Utils
    @objc func manejadorAutomatico(){
        let logoAnimacion = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .easeInOut) {
                                                    self.myImageLogoSaldos.transform = CGAffineTransform(scaleX: 25,
                                                                                                         y: 25)
                                                    self.myImageLogoSaldos.alpha = 0.0
        }
        logoAnimacion.startAnimation()
        logoAnimacion.addCompletion { _ in
            self.beginApp()
        }
    }
    
    func beginApp(){
        if PFUser.current() == nil{
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginVC.modalTransitionStyle = .crossDissolve
            present(loginVC, animated: true, completion: nil)
        }else{
            let revealVC = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            revealVC.modalTransitionStyle = .crossDissolve
            present(revealVC, animated: true, completion: nil)
        }
    }

}
