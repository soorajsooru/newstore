//
//  Home_Page.swift
//  Store
//
//  Created by codemac-04i on 11/10/18.
//  Copyright © 2018 codemac-04i. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class Home_Page: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var LeadingSlide: NSLayoutConstraint!
    @IBOutlet weak var slidetable: UITableView!
    @IBOutlet weak var Table: UITableView!
    @IBOutlet weak var BannersOutlet: UIImageView!
    @IBOutlet weak var SlidemenuView: UIView!
    var products = [FLBstructure]()
    var small1 = [FLBsmallstructure]()
    var small2 = [FLBsmallstructure]()
    var small3 = [FLBsmallstructure]()
    var MenuTitles = ["Profile","Favorites","Settings","About Us","Logout"]
    var userId:Int?
    var Banners: [UIImage
        ] = [UIImage(named:"home-banner")!,UIImage(named:"home-banner1")!,UIImage(named:"home-banner2")!,UIImage(named:"home-banner3")!, ]
    var CellTitles = ["FEATURED","LATEST","BEST SELLER"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == slidetable{
            return MenuTitles.count
        }else{
        return products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == Table{
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCells") as! Home_Table_Cells
        cell.CustomBGview.layer.cornerRadius = 10
        cell.ViewMoreButton.layer.cornerRadius = 5
        cell.CellHeading.text = CellTitles[indexPath.item]
        cell.Firsttitle.text = products[indexPath.item].title1
        cell.secondtitle.text = products[indexPath.item].title2
        cell.thirdtitle.text = products[indexPath.item].title3
        cell.firstimage.sd_setImage(with: URL(string: products[indexPath.item].image1))
        cell.secondimage.sd_setImage(with: URL(string: products[indexPath.item].image2))
        cell.thirdimage.sd_setImage(with: URL(string: products[indexPath.item].image3))
        cell.firstprice.text = products[indexPath.item].price1
        cell.secondprice.text = products[indexPath.item].price2
        cell.thirdprice.text = products[indexPath.item].price3
        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "menucell") as! HomeMenuCells
            cell.title.text = MenuTitles[indexPath.item]
            cell.images.image = UIImage(named: MenuTitles[indexPath.item])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == Table{
        return Table.frame.height / 2
        }else{
            return slidetable.frame.height / 5
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == slidetable{
            if indexPath.item == 4{
                LogOut()
            }
        }
    }
    
    @IBOutlet weak var slidemenuview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
//        UIApplication.shared.keyWindow?.addSubview(SlidemenuView)
        LeadingSlide.constant = -SlidemenuView.frame.width
        BannersOutlet.animationImages = Banners
        BannersOutlet.animationDuration = 10.0
        BannersOutlet.startAnimating()
        
        GetFLB(url: "http://store.appcyan.com/index.php?route=feed/rest_api/featured&limit=3", access_token: AccessToken)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func MenuButton(_ sender: UIBarButtonItem) {
        if sender.tag == 0{
            LeadingSlide.constant = 0
            sender.tag = 1
        }else if sender.tag == 1 {
            LeadingSlide.constant = -SlidemenuView.frame.width
            sender.tag = 0
        }
    }
    
    @IBAction func CategoryButton(_ sender: UIButton) {
        performSegue(withIdentifier: "HomeToCategory", sender: self)
    }
    
    func GetFLB(url:String,access_token:String) {
        let convertedurl = URL(string: url)
        Alamofire.request(convertedurl!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization":"Bearer " + access_token]).responseJSON{ response in
            if let result = response.result.value as? NSDictionary{
                let success = result.value(forKey: "success") as? Int
                if success == 1 {
                    if let data = result.value(forKey: "data") as? [NSDictionary] {
                        if url == "http://store.appcyan.com/index.php?route=feed/rest_api/featured&limit=3"{
                        
                        let products = data[0].value(forKey: "products") as? [NSDictionary]
                        for product in products!{
                            let image = product.value(forKey: "thumb") as? String
                            let title = product.value(forKey: "name") as? String
                            let price = product.value(forKey: "price_formated") as? String
  
                            self.small1.append(FLBsmallstructure(image: image!, title: title!, price: price!))
      
                        }
                       self.products.append(FLBstructure(image1: self.small1[0].image, title1: self.small1[0].title, price1: self.small1[0].price, image2: self.small1[1].image, title2: self.small1[1].title, price2: self.small1[1].price, image3: self.small1[2].image, title3: self.small1[2].title, price3: self.small1[2].price))
    
                        
                            self.Table.reloadData()
                            self.GetFLB(url: "http://store.appcyan.com/index.php?route=feed/rest_api/latest&limit=3", access_token: AccessToken)
                        }else if url == "http://store.appcyan.com/index.php?route=feed/rest_api/latest&limit=3"{
                            for product in data{
                                let image = product.value(forKey: "thumb") as? String
                                let title = product.value(forKey: "name") as? String
                                let price = product.value(forKey: "price_formated") as? String
                                
                                self.small2.append(FLBsmallstructure(image: image!, title: title!, price: price!))
                                
                            }
                            self.products.append(FLBstructure(image1: self.small2[0].image, title1: self.small2[0].title, price1: self.small2[0].price, image2: self.small2[1].image, title2: self.small2[1].title, price2: self.small2[1].price, image3: self.small2[2].image, title3: self.small2[2].title, price3: self.small2[2].price))
                            
                            
                            self.Table.reloadData()
                            self.GetFLB(url: "http://store.appcyan.com/index.php?route=feed/rest_api/bestsellers&limit=3", access_token: AccessToken)
                        }else{
                            for product in data{
                                let image = product.value(forKey: "thumb") as? String
                                let title = product.value(forKey: "name") as? String
                                let price = product.value(forKey: "price_formated") as? String
                                
                                self.small3.append(FLBsmallstructure(image: image!, title: title!, price: price!))
                                
                            }
                            if self.small3.count < 3{
                            self.small3.append(FLBsmallstructure(image: "", title: "", price: ""))
                            }
                            self.products.append(FLBstructure(image1: self.small3[0].image, title1: self.small3[0].title, price1: self.small3[0].price, image2: self.small3[1].image, title2: self.small3[1].title, price2: self.small3[1].price, image3: self.small3[2].image, title3: self.small3[2].title, price3: self.small3[2].price))
                            
                            
                            self.Table.reloadData()
                        }
                    
                }else if success == 0{
                    AlertBox(title: "something went wrong", message: "", view: self)
                }else{
                    AlertBox(title: "something went wrong", message: "", view: self)
                }
            }else{
                AlertBox(title: "something went wrong", message: "", view: self)
            }
            
        }
    }

}
    
    func LogOut (){
        let url = URL(string: "http://store.appcyan.com/index.php?route=rest/logout/logout")
        Alamofire.request(url!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization":"Bearer " + AccessToken]).responseJSON{ response in
            if let res = response.result.value as? NSDictionary{
                if res.value(forKey: "success") as! Int == 1 {
                    self.performSegue(withIdentifier: "UnWindHtoL", sender: self)
                }else{
                    self.performSegue(withIdentifier: "UnWindHtoL", sender: self)
                }
            }else{
                AlertBox(title: "something went wrong", message: "", view: self)
            }
        }
    }
}
