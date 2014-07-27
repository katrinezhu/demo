//
//  MainScene.swift
//  2048-SW
//
//  Created by cyanzhong on 14-6-4.
//  Copyright (c) 2014年 Tencent_IT. All rights reserved.
//  游戏主场景

import Foundation
import UIKit
import QuartzCore
import SpriteKit

class MainScene: SKScene {
    // member variable
    // 变量var 常量let
    var contentCreated = false
    var currentScoreLabel = SKLabelNode()
    var bestScoreLabel = SKLabelNode()
    var chessboard = Chessboard(imageNamed: "chessboard")
    // constant
    let bgColor = UIColor(red: 250/255.0, green: 248/255.0, blue: 239/255.0, alpha: 1.0)
    let kTextColor = UIColor(red: 250/255.0, green: 248/255.0, blue: 239/255.0, alpha: 1.0)
    let kSysBoldFontName = "Helvetica-Bold"
    
    // 方法重写需要加override，很蛋疼
    override func didMoveToView(view: SKView!) {
        if !contentCreated {
            self.createContent()
            contentCreated = true
        }
    }
    
    // create content
    func createContent() {
        self.scaleMode = .AspectFit;
        self.backgroundColor = bgColor
        // 背景图
        var bg: SKSpriteNode = SKSpriteNode(imageNamed: "background")
        bg.anchorPoint = CGPointZero
        bg.position = CGPointMake(0, self.frame.size.height-bg.frame.size.height)
        self.addChild(bg)
        // 计分牌 font: Helvetica-Bold
        currentScoreLabel = SKLabelNode(fontNamed: kSysBoldFontName)
        currentScoreLabel.fontSize = 25.0
        currentScoreLabel.text = "0"
        currentScoreLabel.position = CGPointMake(167, self.frame.size.height-60.0)
        currentScoreLabel.fontColor = kTextColor
        self.addChild(currentScoreLabel)
        // 最高分数
        bestScoreLabel = SKLabelNode(fontNamed: kSysBoldFontName)
        bestScoreLabel.fontSize = 25.0
        bestScoreLabel.text = "0"
        bestScoreLabel.position = CGPointMake(262, self.frame.size.height-60.0)
        bestScoreLabel.fontColor = kTextColor
        self.addChild(bestScoreLabel)
        
        // 棋盘
        chessboard.initUI()
        chessboard.anchorPoint = CGPointMake(0.5, 0)
        chessboard.position = CGPointMake(self.frame.size.width*0.5, 35)
        self.addChild(chessboard)
        
        // 添加手势 上下左右
        var leftGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        // 请注意这个奇葩的点语法
        leftGesture.direction = .Left
        self.view.addGestureRecognizer(leftGesture)
    
        var rightGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        rightGesture.direction = .Right
        self.view.addGestureRecognizer(rightGesture)
        
        var upGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        upGesture.direction = .Up
        self.view.addGestureRecognizer(upGesture)
        
        var downGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        downGesture.direction = .Down
        self.view.addGestureRecognizer(downGesture)
    }
    
    // 处理滑动手势
    func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        // 输出语句
//        println("swipe: \(recognizer.direction.value)")
        chessboard.swipeToDirection(Int(recognizer.direction.toRaw()))
    }
}
