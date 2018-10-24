//
//  Base.swift
//  Store
//
//  Created by codemac-04i on 09/10/18.
//  Copyright © 2018 codemac-04i. All rights reserved.
//

import Foundation
//-------------- API ----------------------------

let BaseApi = "http://store.appcyan.com/"
let BasicOauthHeaderKey_Value = ["Authorization":"Basic c2VsaWw6c2VsaWwxMjM="]
var AccessToken = "0d47743066c4038fc3cd3275475eab0e2a20db32"
let RequestTokenApi = "index.php?route=feed/rest_api/gettoken&grant_type=client_credentials"
let LoginApi = "index.php?route=rest/login/login"
let SignUpApi = "index.php?route=rest/register/register"
let ForgotPasswordApi = "index.php?route=rest/forgotten/forgotten"
var CategoryApi = "index.php?route=feed/rest_api/categories"
