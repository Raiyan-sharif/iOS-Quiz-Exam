//
//  ViewController.swift
//  iOSQuizExam
//
//  Created by BJIT on 27/4/23.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

//LoginButtonDelegate
class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionProgress: UIProgressView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    //    let btnFacebook = FBLoginButton()
    var questionBank = QuestionBank()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(btnFacebook)
//        btnFacebook.center = view.center
//        btnFacebook.delegate = self
        
        if let token = AccessToken.current,
              !token.isExpired {
              // User is logged in, do work such as go to next view controller.
        }else{
//            btnFacebook.permissions = ["public_profile", "email"]
        }
        questionProgress.progress = questionBank.getProgress()
        
        AppEvents.shared.logEvent(AppEvents.Name("ViewController"))
        
        questionLabel.text = questionBank.getTextQuestion()
        scoreLabel.text = "Score: \(questionBank.getScore()) pts."

       
    }
    
    @IBAction func takeAnswer(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        if sender.tag == 1{
            if questionBank.checkAnswer(userAnswer: true){
                firstButton.backgroundColor = UIColor.green
            }else{
                firstButton.backgroundColor = UIColor.red
                generator.impactOccurred()
            }
        }
        else if sender.tag == 2{
            if questionBank.checkAnswer(userAnswer: false){
                secondButton.backgroundColor = UIColor.green
            }else{
                secondButton.backgroundColor = UIColor.red
                generator.impactOccurred()
            }
        }
        firstButton.isEnabled = false
        secondButton.isEnabled = false
        
        if questionBank.nextQuestion(){
            let alert = UIAlertController(title: "End OF QUIZ", message: "DO YOU WANT TO TRY AGAIN?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .default) {[weak self] _ in
                guard let `self` = self else{
                    return
                }
                self.questionBank.score = 0
                self.questionBank.numQuestion = 0
                Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.showNextQuestion), userInfo: nil, repeats: false)
                
            }
            let noAction = UIAlertAction(title: "No", style: .cancel){
                _ in
                exit(0)
            }
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            present(alert, animated: true)
        }else{
            Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(showNextQuestion), userInfo: nil, repeats: false)
        }
    }
    
    @objc func showNextQuestion(){
        questionLabel.text = questionBank.getTextQuestion()
        questionProgress.progress = questionBank.getProgress()
        scoreLabel.text = "Score: \(questionBank.getScore()) pts."
        firstButton.isEnabled = true
        secondButton.isEnabled = true
        firstButton.backgroundColor = .white
        secondButton.backgroundColor = .white
        
    }
    
    
}

//extension ViewController{
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        let token = result?.token?.tokenString
//        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name"], tokenString: token, version: nil, httpMethod: .get)
//        request.start { (connection, result, error) in
//            print("\(result)")
//            AppEvents.shared.logEvent(AppEvents.Name("FacebookLogin"))
//            if(error == nil){
//
//            }else{
//
//            }
//        }
//
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//        print("Logout")
//    }
//
//}

