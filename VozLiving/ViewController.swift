//
//  ViewController.swift
//  VozLiving
//
//  Created by Hung Nguyen Thanh on 7/3/17.
//  Copyright © 2017 Hung Nguyen Thanh. All rights reserved.
//

import UIKit

class ViewController: VLViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class LayerButton: UIButton {
    @IBInspectable var shadowColor: UIColor = UIColor.clear
    @IBInspectable var shadowOffset: CGSize = CGSize.zero
    @IBInspectable var shadowOpacity : Float = 0
    @IBInspectable var shadowRadius: CGFloat = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
}
