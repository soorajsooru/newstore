//
//  CategoryTableViewCell.swift
//  Store
//
//  Created by codemac-04i on 17/10/18.
//  Copyright © 2018 codemac-04i. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var bView: UIView!
    @IBOutlet weak var CatTitle: UILabel!

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
