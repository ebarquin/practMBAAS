//
//  LoginViewController.swift
//  PracticaBoot4
//
//  Created by Eugenio Barquín on 4/4/17.
//  Copyright © 2017 COM. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var handle: FIRAuthStateDidChangeListenerHandle!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handle = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            print("El mail del usuario logado es \(user?.email)")
        })
    }
    

    @IBAction func loginWithMail(_ sender: Any) {
        showUserLoginDialog(withCommand: login, userAction: .toLogin)
    }
    
    fileprivate func login(_ name: String, andPass pass: String){
        FIRAuth.auth()?.signIn(withEmail: name, password: pass, completion: { ( user, error ) in
            if let _ = error {
                print("Creamos un nuevo usuario -> \(error?.localizedDescription)")
                FIRAuth.auth()?.createUser(withEmail: name, password: pass, completion: { (user, error) in
                    if let _ = error {
                        print("Tenemos un error -> \(error?.localizedDescription)")
                        return
                    }
                    print("\(user)")
                })
                return
            }
            print("user: \(user?.email)")
            
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: User Credentials capture
    
    
    func showUserLoginDialog(withCommand actionCmd: @escaping actionUserCmd, userAction: ActionUser) {
        let alertController = UIAlertController(title: "Login", message: userAction.rawValue, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: userAction.rawValue, style: .default, handler: { (action) in
            let eMailText = (alertController.textFields?[0])! as UITextField
            let passText = (alertController.textFields?[1])! as UITextField
            
            if (eMailText.text?.isEmpty)!, (passText.text?.isEmpty)! {
                //No continuar y lanzar un error
                
                
            } else {
                actionCmd(eMailText.text!,
                          passText.text!)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        
        alertController.addTextField { (txtField) in
            txtField.placeholder = "email"
            txtField.textAlignment = .natural
            
        }
        
        alertController.addTextField { (txtField) in
            txtField.placeholder = " password"
            txtField.textAlignment = .natural
            txtField.isSecureTextEntry = true
        }
        
        self.present(alertController, animated: true, completion: nil)
    }

}
