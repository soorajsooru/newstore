//
//  BaseFunctions.swift
//  Store
//
//  Created by codemac-04i on 10/10/18.
//  Copyright © 2018 codemac-04i. All rights reserved.
//

import Foundation
import UIKit


func AlertBox(title:String, message:String, view:UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    view.present(alert, animated: true, completion: nil)
}
