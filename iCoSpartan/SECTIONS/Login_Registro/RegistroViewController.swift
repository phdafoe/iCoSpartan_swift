//
//  RegistroViewController.swift
//  iCoSpartan
//
//  Created by Andres Felipe Ocampo Eljaiesk on 4/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import Parse

class RegistroViewController: UITableViewController {
    
    //MARK: - local variables
    var photoSelected = false
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myImageProfile: UIImageView!
    @IBOutlet weak var myEmail: FormTextView!
    @IBOutlet weak var myContrasegna: FormTextView!
    @IBOutlet weak var myNombre: FormTextView!
    @IBOutlet weak var myApellido: FormTextView!
    @IBOutlet weak var myActiInd: UIActivityIndicatorView!
    @IBOutlet weak var myRegistroBTN : UIButton!
    
    
    //MARK: - IBActions
    
    @IBAction func closeVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registroACTION(_ sender: UIButton) {
        registroNuevoUsuario()
    }
    
    @IBAction func showCamera(_ sender : UIButton){
        pickerPhoto()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myEmail.textField.delegate = self
        myContrasegna.textField.delegate = self
        myNombre.textField.delegate = self
        myApellido.textField.delegate = self
        myActiInd.isHidden = true

        customUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.myEmail.textField.text?.isEmpty)! {
            (self.myEmail.textField).showError(withText: "Campo Obligatorio")
        }
        
        if (self.myContrasegna.textField.text?.isEmpty)! {
            (self.myContrasegna.textField).showError(withText: "Campo Obligatorio")
        }
    }

    func customUI(){
        myEmail.assignPlaceholder(placeholder: "Usuario",
                                  password: false,
                                  showPassword: false,
                                  upPlaceHolder: true,
                                  color: "000000")
        
        myContrasegna.assignPlaceholder(placeholder: "Contraseña",
                                        password: true,
                                        showPassword: true,
                                        upPlaceHolder: true,
                                        color: "000000")
        
        myNombre.assignPlaceholder(placeholder: "Nombre",
                                   password: false,
                                   showPassword: false,
                                   upPlaceHolder: true,
                                   color: "000000")
        
        myApellido.assignPlaceholder(placeholder: "Apellido",
                                     password: false,
                                     showPassword: false,
                                     upPlaceHolder: true,
                                     color: "000000")
    }
    
    @objc func textFieldEdit(textField:JJMaterialTextfield){
        if textField == myEmail.textField{
            //            if (self.presenter?.validateEmail(text: myEmailTextField.textField.text!))!{
            //                myEmailTextField.textField.hideError()
            //            }
        }else{
            //            if (self.presenter?.validatePass(text: myPasswordTextField.textField.text!))!{
            //                myPasswordTextField.textField.hideError()
            //            }
        }
    }
    
    func registroNuevoUsuario(){
        
        var errorInicial = ""
        if (self.myEmail.textField.text?.isEmpty)! || (self.myContrasegna.textField.text?.isEmpty)! || self.myImageProfile.image == nil{
            errorInicial = "Estimado usuario por favor rellene todos los campos"
        }else{
            let newUser = PFUser()
            newUser.username = self.myEmail.textField.text
            newUser.password = self.myContrasegna.textField.text
            newUser["nombre"] = myNombre.textField.text
            newUser["apellido"] = myApellido.textField.text
            
            
            myActiInd.isHidden = false
            myActiInd.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            newUser.signUpInBackground(block: { (exitoso, errorRegistro) in
                
                self.myActiInd.isHidden = true
                self.myActiInd.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if errorRegistro != nil{
                    self.present(muestraAlertVC("Atención",
                                                messageData: "Error al registrar"),
                                 animated: true,
                                 completion: nil)
                }else{
                    self.signUpWithPhoto()
                    self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
                }
            })
        }
        
        if errorInicial != ""{
            present(muestraAlertVC("Atención",
                                   messageData: errorInicial),
                    animated: true,
                    completion: nil)
        }
    }
    
    func signUpWithPhoto(){
        if photoSelected {
            let imageProfile = PFObject(className: "ImageProfile")
            let imageDataProfile = UIImageJPEGRepresentation(myImageProfile.image!, 0.5)
            let imageProfileFile = PFFile(name: "userImageProfile.jpg", data: imageDataProfile!)
            imageProfile["imageProfile"] = imageProfileFile
            imageProfile["username"] = PFUser.current()?.username
            
            imageProfile.saveInBackground()
            
            self.photoSelected = false
            self.myEmail.textField.text = ""
            self.myContrasegna.textField.text = ""
            self.myNombre.textField.text = ""
            self.myApellido.textField.text = ""
            self.myImageProfile.image = #imageLiteral(resourceName: "avatar")
        }else{
            self.present(muestraAlertVC("Atención",
                                        messageData: "Foto no seleccionada"),
                         animated: true,
                         completion: nil)
        }
        
    }

}


extension RegistroViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (myEmail.textField.text?.count)! > 0 && (myContrasegna.textField.text?.count)! > 0 && (self.myImageProfile.image != nil){
            myRegistroBTN.isEnabled = true
        } else {
            myRegistroBTN.isEnabled = false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == myEmail.textField {
            myContrasegna.textField.becomeFirstResponder()
        } else {
            myContrasegna.textField.resignFirstResponder()
        }
        return true
    }
    
    private func textFieldDidBeginEditing(_ textField: JJMaterialTextfield) {
        if textField == self.myEmail.textField{
            if myEmail.textField.errorLabel?.isHidden == false{
                myEmail.textField .addTarget(self, action: #selector(textFieldEdit(textField:)), for: UIControlEvents.allEvents)
            }
        }else{
            if myContrasegna.textField.errorLabel?.isHidden == false{
                myContrasegna.textField .addTarget(self, action: #selector(textFieldEdit(textField:)), for: UIControlEvents.allEvents)
            }
        }
    }
}



//MARK: - EXTENSION
extension RegistroViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func pickerPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        }else{
            muestraLibreria()
        }
    }
    
    func muestraMenu(){
        let menuVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menuVC.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        menuVC.addAction(UIAlertAction(title: "Camara de Fotos", style: .default, handler: { Void in
            self.muestraCamaraFotos()
        }))
        menuVC.addAction(UIAlertAction(title: "Libreria de Fotos", style: .default, handler: { Void in
            self.muestraLibreria()
        }))
        present(menuVC, animated: true, completion: nil)
    }
    
    
    func muestraLibreria(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func muestraCamaraFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            myImageProfile.image = possibleImage
            self.photoSelected = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
