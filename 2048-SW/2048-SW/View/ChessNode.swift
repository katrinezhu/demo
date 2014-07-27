//
//  ChessNode.swift
//  2048-SW
//
//  Created by cyanzhong on 14-6-4.
//  Copyright (c) 2014年 Tencent_IT. All rights reserved.
//  棋子

import Foundation
import SpriteKit

class ChessNode : SKSpriteNode {
    var num = 0
    // 背景颜色表
    var colorTable = [
        0x000000, // dummy
        0xeee4da, // 2
        0xede0c8, // 4
        0xf2b179, // 8
        0xf59563, // 16
        0xf67c5f, // 32
        0xf65e3b, // 64
        0xedcf72, // 128
        0xedcc61, // 256
        0xedc850, // 512
        0xedc53f, // 1024
        0xedc22e  // 2048!
    ]
    
    var number: Int {
        get {
            return num
        }
        set {
            num = newValue
            numLabel.text = String(num)
            // 数字颜色
            numLabel.fontColor = num <= 4 ? self.colorWithRGB(0x776e65) : self.colorWithRGB(0xf9f6f2)
            // 底色
            tile.fillColor = self.colorWithRGB(colorTable[Int(log2(Double(num)))])
            tile.strokeColor = self.colorWithRGB(colorTable[Int(log2(Double(num)))])
        }
    }
    
    var numLabel = SKLabelNode()
    var tile = SKShapeNode()
    
    let k2BGColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
    
    func initUI(number: Int) {
        // 背景色
        tile.path = CGPathCreateWithRoundedRect(CGRectMake(-30, -30, 60, 60), 4, 4, nil)
        var idx = Int(log2(Double(number)))
        tile.fillColor = self.colorWithRGB(colorTable[idx])
        tile.strokeColor = self.colorWithRGB(colorTable[idx])
        self.addChild(tile)
        
        numLabel = SKLabelNode(fontNamed: "Helvetica-Bold")
        numLabel.fontColor = self.colorWithRGB(0x776e65)
        self.number = number
        numLabel.fontSize = 30.0
        numLabel.text = String(num)
        numLabel.position = CGPointMake(0, -numLabel.frame.size.height*0.5)
        tile.addChild(numLabel)
    }
    // 移动到Position位置
    func moveToPosition(position: CGPoint) {
        if position.x == self.position.x && self.position.y == position.y {
            return
        }
        // 使用SKAction动画
        var moveTo = SKAction.moveTo(position, duration: 0.15)
        moveTo.timingMode = .EaseInEaseOut;
        self.runAction(moveTo)
    }
    
    func showInChessboard(chessboard: Chessboard) {
        chessboard.addChild(self)
        self.setScale(0.2)
        var scale = SKAction.scaleTo(1.0, duration:0.2)
        self.runAction(scale)
    }
    // 生成颜色
    func colorWithRGB(v: Int) -> UIColor {
        var red = CGFloat(((v & 0xff0000) >> 16)) / 255.0
        var green = CGFloat(((v & 0xff00) >> 8)) / 255.0
        var blue = CGFloat((v & 0xff)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    // 移除
    func remove() {
        var action = SKAction.fadeOutWithDuration(0.15)
        self.runAction(action, completion: {()in
            self.removeFromParent()
        })
    }
    // 移动
    func moveTo(position: CGPoint) {
        if position.x == self.position.x && self.position.y == position.y {
            return
        }
        var moveTo = SKAction.moveTo(position, duration:0.15)
        moveTo.timingMode = .EaseInEaseOut;
        self.runAction(moveTo)
    }
    // 合并
    func combine() {
        // 这里会调用number的set方法
        self.number = num * 2
        var act1 = SKAction.scaleTo(1.2, duration:0.05)
        var act2 = SKAction.scaleTo(0.9, duration:0.02)
        var act3 = SKAction.scaleTo(1.0, duration:0.06)
        // 动画序列
        var scaleTo = SKAction.sequence([ act1, act2, act3 ])
        self.runAction(scaleTo)
    }
}