//
//  LoginVC.swift
//  ViksitIOS
//
//  Created by Akshay Kumar Both on 7/24/17.
//  Copyright © 2017 Istar Feroz. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var passwordField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //errorLabel.frame = CGRect(origin: CGPoint(), size: CGSize(width: errorLabel.frame.width, height: 0))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose ofx any resources that can be recreated.
    }
    
    @IBAction func onLoginPressed(_ sender: UIButton) {
        var email: String = emailField.text!
        var password: String = passwordField.text!
        
        if validate(email: email, password: password) == true {
            let loginParams = [
                "email" : email,
                "password" : password
            ]
            do{
                var loginResponse = Helper.makeHttpCall(url: "http://elt.talentify.in/t2c/auth/login", method: "POST", param: loginParams)
                var studentprofile = StudentProfile(jsonString: loginResponse)
                if type(of: studentprofile.id) != nil {
                    //to goto dashboard
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Tab", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
                    self.present(nextViewController, animated:true, completion:nil)
                }
                //TabBarController
                //print(loginResponse)
            }catch let error as NSError {
                print(" Error \(error)")
            }
             /*if type(of: <#T##Type#>) == true {
             
            }*/
        }
        
    }
    
    func loginSuccess(){
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
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
                error_message = "Email id is required"
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            } else if isValidEmail(testStr: email) == false {
                error_message = "Please enter a valid email Id ";
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            }
            
            if password.characters.count == 0 {
                error_message = "Password is required"
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
                
            }  else if password.characters.count < 4 {
                error_message = error_message + "Password is too short";
                //errorLabel.text = error_message
                //errorLabel.isHidden = false
                print(error_message)
            }
            
            return false
        } else {
            return true
        }
    }
    
   
}
