//
//  GameViewController.swift
//  2048-SW
//
//  Created by cyanzhong on 14-6-4.
//  Copyright (c) 2014年 Tencent_IT. All rights reserved.
//
//  游戏入口controller

import UIKit
import QuartzCore
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 游戏主场景
        let scene = MainScene(size: CGSizeMake(self.view.frame.size.width, self.view.frame.size.height))
        // 使得本controller的view是一个SKView
        let skView = self.view as SKView
        // 显示FPS
        skView.showsFPS = true;
        // 显示节点统计
        skView.showsNodeCount = true;
        // 显示游戏主场景
        skView.presentScene(scene);
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
