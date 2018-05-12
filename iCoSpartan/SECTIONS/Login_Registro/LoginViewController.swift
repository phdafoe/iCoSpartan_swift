//
//  LoginViewController.swift
//  iCoSpartan
//
//  Created by Andres Felipe Ocampo Eljaiesk on 4/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class LoginViewController: UIViewController {
    
    //MARK: - Local variables
    var player: AVPlayer!
    
    //MARK: - IBOutlets
    @IBOutlet weak var myEmailTextField: FormTextView!
    @IBOutlet weak var myPasswordTextField: FormTextView!
    @IBOutlet weak var myAccederBTN: UIButton!
    @IBOutlet weak var myRegistrarseBTN: UIButton!
    
    
    //MARK: - IBActions
    @IBAction func accessApp(_ sender: Any) {
        let sigIn = APISignIn(pUsername: myEmailTextField.textField.text!,
                              pPassword: myPasswordTextField.textField.text!)
        do{
            try sigIn.signInUser()
            self.performSegue(withIdentifier: "jumpToViewContollerFromLogin", sender: self)
            self.myEmailTextField.textField.text = ""
            self.myPasswordTextField.textField.text = ""
        }catch let error{
            present(muestraAlertVC("Lo sentimos",
                                   messageData: "\(error.localizedDescription)"),
                    animated: true,
                    completion: nil)
        }catch{
            present(muestraAlertVC("Lo sentimos",
                                   messageData: "Algo salio mal"),
                    animated: true,
                    completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showVideo()
        myAccederBTN.layer.cornerRadius = 5
        myRegistrarseBTN.layer.cornerRadius = 5
        
        myEmailTextField.textField.delegate = self
        myPasswordTextField.textField.delegate = self
        
        customUI()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if PFUser.current() != nil{
            //OJO EL TIPO DE SEGUE TIENE QUE SER MODAL Y NO PUSH GENERA UN PROBLEMA DE SOPORTE
            self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
        }
    }
    
    //TODO: - SHOWVIDEO
    func showVideo(){
        let path = Bundle.main.path(forResource: "video_Dos", ofType: "mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player!.actionAtItemEnd = AVPlayerActionAtItemEnd.none;
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: kCMTimeZero)
        player!.play()
    }
    
    func customUI(){
        myEmailTextField.assignPlaceholder(placeholder: "Usuario", password: false, showPassword: false, upPlaceHolder: true, color: "000000")
        myPasswordTextField.assignPlaceholder(placeholder: "Contraseña", password: true, showPassword: true, upPlaceHolder: true, color: "000000")
    }
    
    @objc func playerItemDidReachEnd() {
        player.seek(to: kCMTimeZero)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func textFieldEdit(textField:JJMaterialTextfield){
        if textField == myEmailTextField.textField{
//            if (self.presenter?.validateEmail(text: myEmailTextField.textField.text!))!{
//                myEmailTextField.textField.hideError()
//            }
        }else{
//            if (self.presenter?.validatePass(text: myPasswordTextField.textField.text!))!{
//                myPasswordTextField.textField.hideError()
//            }
        }
    }

    

}


extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        if (emailTextField.textField.text?.characters.count)! > 0 && (passwordTextField.textField.text?.characters.count)! > 0 {
        //            loginButton.isEnabled = true
        //        } else {
        //            loginButton.isEnabled = false
        //        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == myEmailTextField.textField {
            myPasswordTextField.textField.becomeFirstResponder()
        } else {
            myPasswordTextField.textField.resignFirstResponder()
        }
        return true
    }
    
    private func textFieldDidBeginEditing(_ textField: JJMaterialTextfield) {
        if textField == self.myEmailTextField.textField{
            if myEmailTextField.textField.errorLabel?.isHidden == false{
                myEmailTextField.textField .addTarget(self, action: #selector(textFieldEdit(textField:)), for: UIControlEvents.allEvents)
            }
        }else{
            if myPasswordTextField.textField.errorLabel?.isHidden == false{
                myPasswordTextField.textField .addTarget(self, action: #selector(textFieldEdit(textField:)), for: UIControlEvents.allEvents)
            }
        }
    }
}

