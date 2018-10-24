//
//  Home_Table_Cells.swift
//  Store
//
//  Created by codemac-04i on 11/10/18.
//  Copyright © 2018 codemac-04i. All rights reserved.
//

import UIKit

class Home_Table_Cells: UITableViewCell {
    @IBOutlet weak var CustomBGview: UIView!
    @IBOutlet weak var CellHeading: UILabel!
    @IBOutlet weak var Firsttitle: UILabel!
    @IBOutlet weak var secondtitle: UILabel!
    @IBOutlet weak var thirdtitle: UILabel!
    @IBOutlet weak var firstimage: UIImageView!
    @IBOutlet weak var secondimage: UIImageView!
    @IBOutlet weak var thirdimage: UIImageView!
    @IBOutlet weak var ViewMoreButton: UIButton!
    @IBOutlet weak var thirdprice: UILabel!
    @IBOutlet weak var secondprice: UILabel!
    @IBOutlet weak var firstprice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
