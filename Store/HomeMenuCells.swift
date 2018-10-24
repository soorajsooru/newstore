//
//  HomeMenuCells.swift
//  Store
//
//  Created by codemac-04i on 16/10/18.
//  Copyright © 2018 codemac-04i. All rights reserved.
//

import UIKit

class HomeMenuCells: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var images: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
