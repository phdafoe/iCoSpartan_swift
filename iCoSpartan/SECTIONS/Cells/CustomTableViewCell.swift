//
//  CustomTableViewCell.swift
//  iCoSpartan
//
//  Created by Andres Felipe Ocampo Eljaiesk on 7/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageSport: UIImageView!
    @IBOutlet weak var myTitleSport: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
