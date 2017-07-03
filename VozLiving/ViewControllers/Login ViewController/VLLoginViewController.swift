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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    // MARK: - Action
    @IBAction func loginAction(_ sender: Any) {
        
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
