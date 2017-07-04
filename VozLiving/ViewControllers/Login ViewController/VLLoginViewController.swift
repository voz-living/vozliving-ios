//
//  VLLoginViewController.swift
//  VozLiving
//
//  Created by Hung Nguyen Thanh on 7/3/17.
//  Copyright © 2017 VozLiving. All rights reserved.
//

import UIKit
import TextFieldEffects

class VLLoginViewController: VLViewController {

    @IBOutlet weak var userNameTextField: HoshiTextField!
    @IBOutlet weak var passwordTextField: HoshiTextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var layoutBottomLoginV: NSLayoutConstraint!
    @IBOutlet weak var layouBottomLoginBT: NSLayoutConstraint!
    @IBOutlet weak var layouWidthLoginBT: NSLayoutConstraint!
    
    
    private var isShowedLoginV = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.layoutBottomLoginV.constant = -250
        self.layouBottomLoginBT.constant = 0
        self.layouWidthLoginBT.constant = self.view.frame.size.width
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func hideLoginViewAction(_ sender: Any) {
        
        self.userNameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()

        UIView.animate(withDuration: 0.3, animations: {
            
            self.userNameTextField.alpha = 0
            self.passwordTextField.alpha = 0
            
            self.layouBottomLoginBT.constant = 0
            self.layouWidthLoginBT.constant = self.view.frame.size.width
            self.view.layoutIfNeeded()
        }) { (finished) in
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.layoutBottomLoginV.constant = -250
            self.view.layoutIfNeeded()
        }) { (finished) in
            
            self.userNameTextField.alpha = 1
            self.passwordTextField.alpha = 1


        }

        self.isShowedLoginV = false

    }
    // MARK: - Action
    @IBAction func loginAction(_ sender: Any) {
        
        if !isShowedLoginV {
            
            self.isShowedLoginV = true
            self.userNameTextField.alpha = 0
            self.passwordTextField.alpha = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.layoutBottomLoginV.constant = 0
                self.view.layoutIfNeeded()
            }) { (finished) in
                
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.layouWidthLoginBT.constant = 300
                self.layouBottomLoginBT.constant = 200
                self.view.layoutIfNeeded()
            }) { (finished) in
                
            }
            
            UIView.animate(withDuration: 0.8, animations: {
                
                self.userNameTextField.alpha = 1
            }) { (finished) in
                
            }
            
            UIView.animate(withDuration: 1, animations: {
                
                self.passwordTextField.alpha = 1
                self.view.layoutIfNeeded()
            }) { (finished) in
                
            }

        } else {
        
            guard let userName = self.userNameTextField.text, userName.length > 0,
                let password = self.passwordTextField.text, password.length > 0
                else {
                    
                    userNameTextField.becomeFirstResponder()
                    return
            }
            
            _ = self.showHUD(text: "Đang đăng nhập", animated: true)
            VLNetworkUtils.sharedInstance.login(userName: userName, password: password) { (success) in
                
                if success {
                    
                    _ = self.showHUD(text: "Đăng nhập thành công rồi\n nha ku", animated: true)
                    _ = self.hide(animated: true, afterDelay: 3, hudDismissCompleteHandler: {
                        
                    })
                    
                } else {
                    
                    self.showAlert(title: "Đăng nhập thất bại", message: "Vui lòng kiểm tra thông tin tài khoản của bạn", buttonTitles: "Uh, biết rồi", completeHandler: { (button) in
                        
                        self.userNameTextField.becomeFirstResponder()
                        _ = self.hide(animated: true)
                    })
                }
            }

        }
        
    }
    
}
