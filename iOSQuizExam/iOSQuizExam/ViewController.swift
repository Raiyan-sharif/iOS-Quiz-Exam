//
//  ViewController.swift
//  iOSQuizExam
//
//  Created by BJIT on 27/4/23.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, LoginButtonDelegate {


    let btnFacebook = FBLoginButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btnFacebook)
        btnFacebook.center = view.center
        btnFacebook.delegate = self
        if let token = AccessToken.current,
              !token.isExpired {
              // User is logged in, do work such as go to next view controller.
        }else{
            btnFacebook.permissions = ["public_profile", "email"]
        }
        AppEvents.shared.logEvent(AppEvents.Name("ViewController"))

       
    }
}

extension ViewController{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(result)")
            AppEvents.shared.logEvent(AppEvents.Name("FacebookLogin"))
            if(error == nil){

            }else{

            }
        }

    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }

}

