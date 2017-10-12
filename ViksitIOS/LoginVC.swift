//
//  LoginVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/24/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet var passwordField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var showPasswordBtn: UIButton!
    var iconClick : Bool!
    
    @IBAction func togglePassword(_ sender: UIButton) {
        if(iconClick == true) {
            //show pswrd
            passwordField.isSecureTextEntry = false
            showPasswordBtn.tintColor = UIColor.Custom.themeColor
            iconClick = false
        } else {
            //hide pswrd
            passwordField.isSecureTextEntry = true
            showPasswordBtn.tintColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1.0)
            iconClick = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //x()
        iconClick = true
        loginBtn.backgroundColor = UIColor.Custom.themeColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        //errorLabel.frame = CGRect(origin: CGPoint(), size: CGSize(width: errorLabel.frame.width, height: 0))
        // Do any additional setup after loading the view.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        
        errorLabel.isHidden = true
        view.endEditing(true)
    }

    @IBAction func onLoginPressed(_ sender: UIButton) {
        let email: String = emailField.text!
        let password: String = passwordField.text!
        
        if validate(email: email, password: password) == true {
            let loginParams = [
                "email" : email,
                "password" : password
            ]
            do{
                DispatchQueue.global(qos: .userInteractive).async {
                    let loginResponse = Helper.makeHttpCall(url: "\(Constant.prodUrlString)t2c/auth/login", method: "POST", param: loginParams)
                    DispatchQueue.main.async {
                        if loginResponse.contains("istarViksitProComplexKeyUsername does not exists") {
                            self.errorLabel.text = "Username does not exists"
                            self.errorLabel.isHidden = false
                        } else if loginResponse.contains("istarViksitProComplexKeyPassword is incorrect") {
                            self.errorLabel.text = "Password is incorrect"
                            self.errorLabel.isHidden = false
                        } else {
                            let studentprofile = StudentProfile(jsonString: loginResponse)
                            if type(of: studentprofile.id) != nil {
                                print(studentprofile.id)
                                if let id = studentprofile.id {
                                    if studentprofile.isVerified! {
                                        DispatchQueue.global(qos: .userInteractive).async {
                                            let response: String = Helper.makeHttpCall (url : "\(Constant.prodUrlString)t2c/user/\(id)/complex", method: "GET", param: [:])
                                            DispatchQueue.main.async {
                                                DataCache.sharedInstance.cache["complexObject"] = response
                                                self.createFolders()
                                                Helper.saveProfileImageAsync(urlString: studentprofile.profileImage!)
                                                
                                                let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
                                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
                                                self.present(nextViewController, animated:true, completion:nil)
                                            }
                                        }
                                    } else if !studentprofile.isVerified!{
                                        
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Welcome", bundle:nil)
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "VerifyPhoneVC") as! VerifyPhoneVC
                                        nextViewController.mobileNumber = studentprofile.mobile!
                                        nextViewController.userID = id
                                        self.present(nextViewController, animated:true, completion:nil)
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                }
                
            }catch let error as NSError {
                print(" Error \(error)")
            }
            
        }
        
    }
    
    func x() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        
        
        
        //ref.child("istar-notification-ios").child("Feroz").setValue(someDictionary)
        ref.child("istar-notification").child("8").observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            for (key, value) in postDict {
                print("my key -> \(key as String)")
                if key  is Dictionary<AnyHashable,Any> {
                    print("Yes, it's a Dictionary")
                    let myref = value as! NSDictionary
                    
                    for(key1, value1) in myref {
                        print("child key -> \(key1 as! String) child values -> \(value1 as Any)")
                    }
                }else{
                    print("No , it's not a Dictionary")
                }
            }
            print("dddd \(postDict)")
            
        })
    }
    
    func createFolders(){
        MediaUtil.createFolderInDocuments(folderName: "Viksit", extraPath: "/")
        //MediaUtil.createFolderInDocuments(folderName: "Viksit_COURSE", extraPath: "/Viksit/")
        MediaUtil.createFolderInDocuments(folderName: "Viksit_LESSON_PRESENTATION", extraPath: "/Viksit/")
        MediaUtil.createFolderInDocuments(folderName: "Viksit_MODULE", extraPath: "/Viksit/")
        MediaUtil.createFolderInDocuments(folderName: "Viksit_NOTIFICATION", extraPath: "/Viksit/")
        MediaUtil.createFolderInDocuments(folderName: "Viksit_PROFILE_PIC", extraPath: "/Viksit/")
        MediaUtil.createFolderInDocuments(folderName: "Viksit_ROLES", extraPath: "/Viksit/")
        MediaUtil.createFolderInDocuments(folderName: "Viksit_STUDENTS", extraPath: "/Viksit/")
        MediaUtil.createFolderInDocuments(folderName: "Viksit_TASKS", extraPath: "/Viksit/")
    }
    
    func isValidEmail(testStr:String) -> Bool {
        //print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func validate (email: String , password: String) -> Bool{
        if (password.characters.count == 0 || password.characters.count < 4 || email.characters.count < 4 || isValidEmail(testStr: email) == false) {
            var error_message: String = ""
            if email.characters.count == 0 {
                error_message = "Email id is required "
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            } else if isValidEmail(testStr: email) == false {
                error_message = "please enter a valid email Id "
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            }
            
            if password.characters.count == 0 {
                if error_message != "" {
                    error_message += "and "
                }
                error_message += "password is required."
                print(error_message)
                
            }  else if password.characters.count < 4 {
                if error_message != "" {
                    error_message += "and "
                }
                error_message = error_message + "password is too short."
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            }
            
            errorLabel.text = error_message
            errorLabel.isHidden = false
            
            return false
        } else {
            errorLabel.isHidden = true
            return true
        }
    }
    
    
}

