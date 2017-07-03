//
//  VLViewController.swift
//  VozLiving
//
//  Created by Hung Nguyen Thanh on 7/3/17.
//  Copyright © 2017 VozLiving. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift
import MBProgressHUD


class VLViewController: UIViewController {

    private var _hud : MBProgressHUD?
    var hudDismissCompleteHandler: VLClosueNonArgument!
    
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
    
    // MARK: - MBProgressHUB
    func hud() -> MBProgressHUD {
        if _hud != nil {
            _hud?.hide(animated: true)
        } else {
            _hud = MBProgressHUD(view: self.view)
        }
        _hud?.delegate = self
        self.view.addSubview(_hud!)
        return _hud!
    }
    
    private func showHUD(_ hud: MBProgressHUD,  animated : Bool, whileExecutingBlock block: VLClosueNonArgument! = nil, completionBlock completion: MBProgressHUDCompletionBlock! = nil) {
        
        let showHud = {
            hud.show(animated: animated)
            if block != nil {
                DispatchQueue.global().async(execute: {
                    block()
                    DispatchQueue.main.async(execute: {
                        hud.hide(animated: animated)
                        if completion != nil {
                            completion()
                        }
                    })
                })
            }
        }
        
        if Thread.current.isMainThread {
            showHud()
        } else {
            
            DispatchQueue.main.async(execute: {
                showHud()
            })
            
        }
    }
    
    func showHUD(animated : Bool, whileExecutingBlock block: VLClosueNonArgument! = nil, completionBlock completion: MBProgressHUDCompletionBlock! = nil) -> MBProgressHUD {
        
        self.showHUD(self.hud(), animated: animated, whileExecutingBlock: block, completionBlock: completion)
        return _hud!;
    }
    
    func showHUD(text: String, mode: MBProgressHUDMode = .annularDeterminate, animated : Bool, whileExecutingBlock block: VLClosueNonArgument! = nil, completionBlock completion: MBProgressHUDCompletionBlock! = nil) -> MBProgressHUD {
        let hud = self.hud()
        hud.mode = mode
        hud.label.text = text
        self.showHUD(hud, animated: animated, whileExecutingBlock: block, completionBlock: completion)
        return _hud!;
    }
    
    func hide(animated:Bool, afterDelay: TimeInterval = 0, hudDismissCompleteHandler: VLClosueNonArgument! = nil) {
        
        let hideHud = {
            if (self._hud != nil) {
                self._hud!.hide(animated: animated, afterDelay: afterDelay)
                self._hud!.hide(animated: animated, afterDelay: afterDelay)
            }
            
            self.hudDismissCompleteHandler = hudDismissCompleteHandler
        }
        
        if Thread.current.isMainThread {
            hideHud()
        } else {
            DispatchQueue.main.async(execute: {
                hideHud()
            })
        }
    }
    
    func updateHudProcess(process: Float) {
        if _hud != nil {
            _hud!.progress = process
        }
    }
    
    
    // MARK: - AlertView
    func showAlert(title: String?, message: String, buttonTitles: String..., completeHandler: VLAlertHandlerClosue?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        var alertAction: UIAlertAction
        alertAction = UIAlertAction(title: buttonTitles[0], style: .cancel, handler: { (action) in
            
            if let completeHandler = completeHandler {
                
                completeHandler(0)
                
            }
            
        })
        
        alertController.addAction(alertAction)
        
        if buttonTitles.count > 1 {
            
            for index in 1..<buttonTitles.count {
                
                alertAction = UIAlertAction(title: buttonTitles[index], style: .cancel, handler: { (action) in
                    
                    if let completeHandler = completeHandler {
                        
                        completeHandler(index)
                        
                    }
                    
                })
                
                alertController.addAction(alertAction)
                
            }
            
        }
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    

}

extension VLViewController: MBProgressHUDDelegate {
    
    func hudWasHidden(_ hud: MBProgressHUD) {
        if self.hudDismissCompleteHandler != nil {
            self.hudDismissCompleteHandler()
        }
    }
    
}
