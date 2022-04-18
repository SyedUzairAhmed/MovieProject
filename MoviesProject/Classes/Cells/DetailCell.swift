//
//  DetailCell.swift
//  MoviesProject
//
//  Created by Ahmad on 03/04/2022.
//  Copyright © 2022 ahmad. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var titlee: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
