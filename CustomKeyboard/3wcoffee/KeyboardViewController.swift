//
//  KeyboardViewController.swift
//  3wcoffee
//
//  Created by cyan on 14-7-27.
//  Copyright (c) 2014年 cyan. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet weak var nextKeyboardButton: UIButton!
    
    let values = [ "3w", "coffee", ".com" ]

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
    
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
    
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
    
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
        
        // add buttons
        
        let btnWidth:CGFloat = 70.0
        let btnHeight:CGFloat = 28.0
        let padding:CGFloat = 8.0
        
        let selector = Selector("type:")
        
        let wwwBtn = UIButton.buttonWithType(.Custom) as UIButton
        wwwBtn.frame = CGRect(x: padding, y: 36, width: btnWidth, height: btnHeight)
        wwwBtn.setBackgroundImage(UIImage(named: "char"), forState: .Normal)
        wwwBtn.setTitle("3w", forState: .Normal)
        wwwBtn.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
        wwwBtn.tag = 0
        view.addSubview(wwwBtn)
        
        let coffeeBtn = UIButton.buttonWithType(.Custom) as UIButton
        coffeeBtn.frame = CGRect(x: padding*2+btnWidth, y: 36, width: btnWidth, height: btnHeight)
        coffeeBtn.setBackgroundImage(UIImage(named: "char"), forState: .Normal)
        coffeeBtn.setTitle("coffee", forState: .Normal)
        coffeeBtn.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
        coffeeBtn.tag = 1
        view.addSubview(coffeeBtn)

        let comBtn = UIButton.buttonWithType(.Custom) as UIButton
        comBtn.frame = CGRect(x: padding*3+btnWidth*2, y: 36, width: btnWidth, height: btnHeight)
        comBtn.setBackgroundImage(UIImage(named: "char"), forState: .Normal)
        comBtn.setTitle(".com", forState: .Normal)
        comBtn.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
        comBtn.tag = 2
        view.addSubview(comBtn)
        
        let delBtn = UIButton.buttonWithType(.Custom) as UIButton
        delBtn.frame = CGRect(x: padding*4+btnWidth*3, y: 36, width: btnWidth, height: btnHeight)
        delBtn.setBackgroundImage(UIImage(named: "del"), forState: .Normal)
        delBtn.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
        delBtn.addTarget(self, action: "clear", forControlEvents: .TouchDragExit)
        delBtn.tag = 3
        view.addSubview(delBtn)
        
        let enterBtn = UIButton.buttonWithType(.Custom) as UIButton
        enterBtn.frame = CGRect(x: padding, y: 72, width: btnWidth*4+padding*3, height: btnHeight)
        enterBtn.setBackgroundImage(UIImage(named: "enter"), forState: .Normal)
        enterBtn.addTarget(self, action: selector, forControlEvents: .TouchUpInside)
        enterBtn.tag = 4
        view.addSubview(enterBtn)
        
    }
    
    func clear() {
        let proxy = self.textDocumentProxy as UITextDocumentProxy
        while proxy.hasText() {
            proxy.deleteBackward()
        }
    }
    
    func type(sender: UIButton) {
//        sender.alpha -= 0.2
        let index = sender.tag
        
        let proxy = self.textDocumentProxy as UITextDocumentProxy
        
        switch index {
        case 0...2:
            // insert text
            proxy.insertText(values[index])
        case 3:
            // delete
            proxy.deleteBackward()
        case 4:
            proxy.insertText("\n")
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
    
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }

}
