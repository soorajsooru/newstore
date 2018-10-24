//
//  Category_Page.swift
//  Store
//
//  Created by codemac-04i on 17/10/18.
//  Copyright © 2018 codemac-04i. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class Category_Page: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var categorydatas = [CategoryModel]()
    
    @IBOutlet weak var Table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorydatas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCells") as! CategoryTableViewCell
        cell.bView.layer.cornerRadius = 20
        cell.images.layer.cornerRadius = 20
        cell.CatTitle.text = categorydatas[indexPath.item].title
        cell.images.sd_setImage(with: URL(string: categorydatas[indexPath.item].image))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toproducts", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        GetCategory(url: BaseApi + CategoryApi)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetCategory(url:String){
        self.categorydatas = []
        let convertedurl = URL(string: url)
        Alamofire.request(convertedurl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization":"Bearer " + AccessToken]).responseJSON{ response in
            if let datas = response.result.value as? NSDictionary{
                if datas.value(forKey: "success") as! Int == 1{
                    let data = datas.value(forKey: "data") as! [NSDictionary]
                    for items in data{
                        let catid = items.value(forKey: "category_id") as? Int
                        let image = items.value(forKey: "image") as? String
                        let title = items.value(forKey: "name") as? String
                        self.categorydatas.append(CategoryModel(title: title!, id: catid!, image: image!))
                        
                    }
                    self.Table.reloadData()
                }else{
                    AlertBox(title: "", message: "something went wrong", view: self)
                }
            }else{
                AlertBox(title: "", message: "something went wrong, please try again", view: self)
            }
            
        }
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let send = segue.destination as! Products_Page
    }
}
