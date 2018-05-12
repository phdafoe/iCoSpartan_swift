//
//  MenuLateralTableViewController.swift
//  iCoSpartan
//
//  Created by Andres Felipe Ocampo Eljaiesk on 7/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit
import MessageUI
import Parse


class MenuLateralTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myNombrePerfil: UILabel!
    @IBOutlet weak var myApellidoPerfil: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        myImagenPerfil.layer.cornerRadius = myImagenPerfil.frame.size.width / 2
        myImagenPerfil.layer.borderColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myImagenPerfil.layer.borderWidth = 1
        myImagenPerfil.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dameInformacionPerfil()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section==1){
            switch indexPath.row {
            case 2:
                sendMessage()
            case 3:
                showRateAlertInmediatly(self)
            default:
                break
            }
        }
    }
    
    ///MARK: - Envio de mensaje email
    func sendMessage(){
        let mailComposeViewControler = configuredMailComposeViewController()
        mailComposeViewControler.mailComposeDelegate = self
        if MFMailComposeViewController.canSendMail(){
            present(mailComposeViewControler, animated: true, completion: nil)
        }else{
            present(muestraAlertVC("Atención",
                                   messageData: "El mail no se ha enviado correctamente"),
                    animated: true,
                    completion: nil)
        }
    }
    
    //MARK: - Utils
    func dameInformacionPerfil(){
        //1. primera consulta
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objectsBusqueda, errorBusqueda) in
            if errorBusqueda == nil{
                if let objectData = objectsBusqueda?.first{
                    //2. segunda consulta
                    let queryBusquedaFoto = PFQuery(className: "ImageProfile")
                    queryBusquedaFoto.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    queryBusquedaFoto.findObjectsInBackground(block: { (objectsBusquedaFoto, errorFoto) in
                        if errorFoto == nil{
                            if let objectsBusquedaFotoData = objectsBusquedaFoto?.first{
                                let userImageFile = objectsBusquedaFotoData["imageProfile"] as! PFFile
                                //3. tercera consulta
                                userImageFile.getDataInBackground(block: { (imageData, errorImageData) in
                                    if errorImageData == nil{
                                        if let imageDataDesempaquetado = imageData{
                                            let imagenFinal = UIImage(data: imageDataDesempaquetado)
                                            self.myImagenPerfil.image = imagenFinal
                                            self.tableView.reloadData()
                                        }
                                    }else{
                                        print("Hola chicos no tenemos imagen :(")
                                    }
                                })
                            }
                        }else{
                            print("Error: \(errorFoto!.localizedDescription) ")
                        }
                    })
                    self.myNombrePerfil.text = objectData["nombre"] as? String
                    self.myApellidoPerfil.text = objectData["apellido"] as? String
                }
            }else{
                self.present(muestraAlertVC("Atención",
                                            messageData: "ha ocurrido un problema en la busqueda de la Base de Datos"),
                             animated: true,
                             completion: nil)
            }
        })
    }

}


//MARK: - DELEGADOS
extension MenuLateralTableViewController : MFMailComposeViewControllerDelegate{
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
