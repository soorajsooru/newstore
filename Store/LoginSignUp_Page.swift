//
//  ViewController.swift
//  Store
//
//  Created by codemac-04i on 08/10/18.
//  Copyright © 2018 codemac-04i. All rights reserved.
//

import UIKit
import Alamofire
class LoginSignUp_Page: UIViewController {
    @IBOutlet weak var Remember: UIButton!
    @IBOutlet weak var SinH: UIButton!
    @IBOutlet weak var SupH: UIButton!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var SignUpView: UIView!
    
    // ------------ SIGN UP VIEW -----------------------
    @IBOutlet weak var Firstname: UITextField!
    @IBOutlet weak var Lastname: UITextField!
    @IBOutlet weak var Phonenumber: UITextField!
    @IBOutlet weak var EmailRegister: UITextField!
    @IBOutlet weak var PasswordRegister: UITextField!
    @IBOutlet weak var Confirmpassword: UITextField!
    @IBOutlet weak var AgreeOutlet: UIButton!
    
    var remembercheck = false
    var userId:Int?
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin(url: BaseApi + LoginApi, access_token: AccessToken)
         self.navigationController?.isNavigationBarHidden = true
        Remember.layer.borderWidth = 1
        Remember.layer.borderColor = UIColor.darkGray.cgColor
        AgreeOutlet.layer.borderWidth = 1
        AgreeOutlet.layer.borderColor = UIColor.darkGray.cgColor
        Password.layer.borderColor = UIColor.darkGray.cgColor
        SinH.layer.backgroundColor = UIColor.white.cgColor
        SupH.layer.backgroundColor = UIColor.clear.cgColor
        SupH.setTitleColor(UIColor.white, for: UIControlState.normal)
        SinH.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        SignUpView.isHidden = true
        if UserDefaults.standard.object(forKey: "username") != nil {
            Email.text = UserDefaults.standard.value(forKey: "username") as! String
            Password.text = UserDefaults.standard.value(forKey: "password") as! String
            }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ------------ SIGN IN VIEW ---------------------
    
    
    
    @IBAction func SignInPageSelector(_ sender: UIButton) {
        SinH.layer.backgroundColor = UIColor.white.cgColor
        SupH.layer.backgroundColor = UIColor.clear.cgColor
        SupH.setTitleColor(UIColor.white, for: UIControlState.normal)
        SinH.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        SignUpView.isHidden = true
    }

    @IBAction func SignUpPageSelector(_ sender: UIButton) {
        SignUpView.isHidden = false
        SinH.layer.backgroundColor = UIColor.clear.cgColor
        SupH.layer.backgroundColor = UIColor.white.cgColor
        SupH.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        SinH.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    @IBAction func RememberAction(_ sender: UIButton) {
        let uncheck = UIImage()
        if sender.tag == 0{
            sender.tag = 1
            sender.setImage(UIImage(named:"check"), for: UIControlState.normal)
            remembercheck = true
        }else{
            sender.tag = 0
            sender.setImage(uncheck, for: UIControlState.normal)
            remembercheck = false
        }

    }
    @IBAction func SignIn(_ sender: UIButton) {
        Login(url: BaseApi + LoginApi, access_token: AccessToken)
    }
    @IBAction func ForgotPassword(_ sender: UIButton) {
    }
    @IBAction func CancelButton(_ sender: UIButton) {
    }
    



//--------------------------- SIGN UP VIEW-------------------------
    @IBAction func SignUpToRegister(_ sender: UIButton) {
    }
    @IBAction func Terms(_ sender: UIButton) {
    }
    @IBAction func Privacy(_ sender: UIButton) {
    }
    @IBAction func AgreeButton(_ sender: UIButton) {
        let uncheck = UIImage()
        if sender.tag == 0{
            sender.tag = 1
            sender.setImage(UIImage(named:"check"), for: UIControlState.normal)
            
        }else{
            sender.tag = 0
            sender.setImage(uncheck, for: UIControlState.normal)
            
        }
    }

//------------------FUNCTIONS------------------------------
    func Login(url:String, access_token :String){
        let convertedurl = URL(string: url)
        Alamofire.request(convertedurl!, method: .post, parameters: ["email": Email.text!,"password":Password.text!], encoding: JSONEncoding.default, headers: ["Authorization":"Bearer " + access_token]).responseJSON{ response in
            if let result = response.result.value as? NSDictionary{
                let success = result.value(forKey: "success") as? Int
                if success == 1 {
                    UserDefaults.standard.setValue(self.Email.text!, forKey: "username")
                    UserDefaults.standard.setValue(self.Password.text!, forKey: "password")
                    self.userId = result.value(forKey: "customer_id") as? Int
                    self.performSegue(withIdentifier: "logTOhome", sender: self)
                }else if success == 0{
                    let tokenexpired = String("User is logged.")
                    let error = result.value(forKey: "error") as? [String]
                    if error?[0] == tokenexpired {
                        let alert = UIAlertController(title: "session expired", message: "", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Refresh", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: { res in
                            self.GetAccessToken(url: BaseApi + RequestTokenApi)
                            
                        })
                    }else{
                        AlertBox(title: "", message: (error?[0])!, view: self)
                    }
                }else{
                    AlertBox(title: "something went wrong", message: "", view: self)
                }
                
            }else{
                AlertBox(title: "something went wrong", message: "", view: self)
            }
            }
        }
    
    func GetAccessToken(url:String) {
        let convertedurl = URL(string: url)
        Alamofire.request(convertedurl!, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: BasicOauthHeaderKey_Value).responseJSON{ response in
            if let result = response.result.value as? NSDictionary{
                let success = result.value(forKey: "success") as? Int
                if success == 1 {
                    let data = result.value(forKey: "data") as? NSDictionary
                    let token = data?.value(forKey: "access_token") as? String
                    AccessToken = token!
                }else if success == 0{
                    let error = result.value(forKey: "error") as? [String]
                    AlertBox(title: (error?[0])!, message: "", view: self)
                }else{
                    AlertBox(title: "something went wrong", message: "", view: self)
                }
            }else{
                AlertBox(title: "something went wrong", message: "", view: self)
            }
    
        }
    }
    
    
    
    
    func checkLogin(url:String, access_token :String){
        let convertedurl = URL(string: url)
        Alamofire.request(convertedurl!, method: .post, parameters: ["email": Email.text!,"password":Password.text!], encoding: JSONEncoding.default, headers: ["Authorization":"Bearer " + access_token]).responseJSON{ response in
            if let result = response.result.value as? NSDictionary{
                let success = result.value(forKey: "success") as? Int
                if success == 0 {
                    let tokenexpired = String("User is logged.")
                    let error = result.value(forKey: "error") as? [String]
                    if error?[0] == tokenexpired {
                    self.performSegue(withIdentifier: "logTOhome", sender: self)
                    }
                    
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logTOhome"{
            let send = segue.destination as! Home_Page
            send.userId = userId
        }
    }
}
