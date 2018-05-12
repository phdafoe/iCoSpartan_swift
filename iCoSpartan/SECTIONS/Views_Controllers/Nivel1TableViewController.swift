//
//  Nivel1TableViewController.swift
//  iCoSpartan
//
//  Created by Andres Felipe Ocampo Eljaiesk on 7/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

class Nivel1TableViewController: UITableViewController {
    
    //MARK: - local Variables
    var ejerciciosArray : NSArray = []
    var ejerciciosDiccionario : NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")

        //Aqui buscamos en la raiz principal el fichero dque contiene informacion
        let path = Bundle.main.path(forResource: "spartanLevel1", ofType: "plist")
        ejerciciosArray = NSArray(contentsOfFile: path!)! as NSArray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ejerciciosArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        ejerciciosDiccionario = ejerciciosArray.object(at: indexPath.row) as! NSDictionary
        let title = ejerciciosDiccionario["title"] as! String
        let imageName = ejerciciosDiccionario["imageName1"]as! String
        let imageCustom = UIImage(named: imageName)
        cell.myTitleSport.text = title
        cell.myImageSport.image = imageCustom
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detalleVC = self.storyboard?.instantiateViewController(withIdentifier: "DetalleViewController") as! DetalleViewController
        
        
        ejerciciosDiccionario = ejerciciosArray.object(at: indexPath.row) as! NSDictionary
        let title = ejerciciosDiccionario["title"] as! String
        /*let description = ejerciciosDiccionario["description"]as! String
        let imageName = ejerciciosDiccionario["imageName1"]as! String
        let imageCustom = UIImage(named: imageName)*/
        
        detalleVC.title = title
        
        self.navigationController?.pushViewController(detalleVC, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
