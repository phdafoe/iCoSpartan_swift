//
//  CustomCell.swift
//  iCoSpartan
//
//  Created by Andres Felipe Ocampo Eljaiesk on 7/5/18.
//  Copyright © 2018 icologic. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var customTitleLabel : UILabel!
    @IBOutlet weak var customDescriptionLabel : UILabel!
    @IBOutlet weak var customImageNameLabel : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
