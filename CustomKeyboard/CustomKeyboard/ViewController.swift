//
//  ViewController.swift
//  CustomKeyboard
//
//  Created by cyan on 14-7-27.
//  Copyright (c) 2014年 cyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let textField = UITextField(frame: CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 40))
        textField.backgroundColor = UIColor.grayColor()
        textField.becomeFirstResponder()
        view.addSubview(textField)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

