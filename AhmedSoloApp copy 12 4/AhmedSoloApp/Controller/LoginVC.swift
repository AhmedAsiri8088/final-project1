//
//  LoginVC.swift
//  AhmedSoloApp
//
//  Created by Ahmed Assiri on 04/05/1443 AH.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class Login: UIViewController {
    
    
    @IBOutlet weak var EmailTF: UITextField!
    
    @IBOutlet weak var PassTF: UITextField!
    
    //  @IBOutlet weak var sign: UIButton!
    
    //  @IBOutlet weak var login: UIButton!
    
    
    var uid:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color")
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Image-10")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        EmailTF.text = ""
        PassTF.text = ""
        
        //self.sign.layer.cornerRadius = 10
        
        //FirebaseApp.configure() self.login.layer.cornerRadius = 10
        
        
    }
    
    @IBAction func Sign(_ sender: Any) {
        
        if EmailTF.text != nil && PassTF.text != nil {
            Auth.auth().createUser(withEmail: EmailTF.text!, password: PassTF.text!) { [self] (result, error) in
                if error != nil {
                    
                    print("THERE WAS AN ERROR")
                }
                else {
                    //
                    self.uid = (result?.user.uid)!
                    let ref = Database.database().reference (withPath: "users").child(self.uid)
                    ref.setValue(["email" : self.EmailTF.text!, "password": self.PassTF.text!])
                    self.performSegue(withIdentifier: "logIn", sender: self)
                }//
            }
        }
    }
    
    
    
    @IBAction func LogIn(_ sender: Any) {
        if EmailTF.text != nil && PassTF.text != nil {
            Auth.auth().signIn(withEmail: EmailTF.text!, password: PassTF.text!) { (result, error) in
                if error != nil {
                    
                    print("THERE WAS AN ERROR")
                }
                else {
                    
                    self.uid = (result?.user.uid)!
                    self.performSegue(withIdentifier: "123", sender: self)
                }
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigation = segue.destination as! UINavigationController
        //        let todoVC = navigation.topViewController as! profile
        //        todoVC.userId = uid
    }
    
}
