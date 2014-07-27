//
//  Chessboard.swift
//  2048-SW
//
//  Created by cyanzhong on 14-6-4.
//  Copyright (c) 2014年 Tencent_IT. All rights reserved.
//  棋盘

import Foundation
import SpriteKit

// 棋盘移动方向
enum ChessboardSwipeDirection: Int {
    case ChessboardSwipeDirectionRight  = 1
    case ChessboardSwipeDirectionLeft   = 2
    case ChessboardSwipeDirectionUp     = 4
    case ChessboardSwipeDirectionDown   = 8
}

class Chessboard: SKSpriteNode {
    let kColMax = 4
    let kRowMax = 4
    let kMaxNumber = 2048
    
    // 合并音效
    let sumSfx =  SKAction.playSoundFileNamed("sfx_sum.mp3", waitForCompletion: false)
    // 移动音效
    let moveSfx = SKAction.playSoundFileNamed("sfx_sweep.mp3", waitForCompletion: false)
    
    // i_dir[0]表示列初始化的位置 i_dir[1]表示列增加的顺序
    let i_dir = [
        [0, 0, 0, 3],
        [1, 1, 1,-1]
    ]
    // j_dir[0]表示行初始化的位置 j_dir[1]表示行增加的顺序
    let j_dir = [
        [ 3, 0, 0, 0],
        [-1, 1, 1, 1]
    ]
    // pos_dir[0]表示行方向 pos_dir[1]表示列方向
    let pos_dir = [
        [0, 0,-1, 1],
        [1,-1, 0, 0]
    ]
    
    func initUI() {
        // 初始化两个点
        self.addNewChess()
        self.addNewChess()
    }
    
    // 添加一个新数字
    func addNewChess() {
        var i:Int
        var j:Int
        do {
            // 随机的生成位置 但是不重复
            i = random() % 4
            j = random() % 4
            if let node = self.childNodeWithName(self.nodeName(i, j: j)) {
                var chessNode = node as ChessNode
                if chessNode.number == 0 || self.children.count >= 16 {
                    break
                }
            } else {
                break
            }
        } while true
        
        if self.children.count >= 16 {
            return
            // 棋盘满了
        }
        
        // 不出现重复的点
        var newNode = ChessNode(imageNamed: "tile")
        newNode.initUI(random()%2==1 ? 2 : 4)
        newNode.position = self.positionOfRow(i, col: j)
        newNode.name = nodeName(i, j: j) // 起个好听的名字
        newNode.showInChessboard(self)
    }
    
    // 子节点名字 "i:j"
    func nodeName(i: Int, j: Int) -> String {
        return String(i) + ":" + String(j)
    }
    
    // 第row行col列的坐标
    func positionOfRow(row: Int, col: Int) -> CGPoint {
        var x = CGFloat(-self.frame.size.width)*0.5 + CGFloat(col)*70.0 + 41
        if col < 2 {
            x -= 1;
        }
        var y = CGFloat(self.frame.size.height) - 42.0 - CGFloat(row)*70
        if row < 2 {
            y += 1
        }
        return CGPointMake(x, y)
    }
    
    // 是否在棋盘内
    func inrange(x: Int, y: Int) -> Bool {
        return x >= 0 && x < 4 && y >= 0 && y < 4
    }
    
    // 处理移动方向
    func swipeToDirection(direction: Int) {
        // 播放音效
        self.runAction(moveSfx)
        // 处理数字
        self.moveTo(direction)
        self.combineTo(direction)
        self.moveTo(direction)
        self.addNewChess() // 新增加一个棋子
    }
    // 移动格子
    func moveTo(direction: Int) {
        let idx = Int(log2(Double(direction))) // 获得mask
        let ioffset = i_dir[1][idx]
        let joffset = j_dir[1][idx]
        let roffset = pos_dir[0][idx]
        let coffset = pos_dir[1][idx]
        let i0 = i_dir[0][idx]
        let j0 = j_dir[0][idx]
        var next_row: Int = 0
        var next_col: Int = 0
        for var i=i0; i<kRowMax&&i>=0; i+=ioffset {
            for var j=j0; j<kColMax&&j>=0; j+=joffset {
                next_row = i + roffset
                next_col = j + coffset
                // 第i行j列的棋子
                if let nodeIJ = self.childNodeWithName(self.nodeName(i, j: j)) {
                    let chessNode = nodeIJ as ChessNode
                    while self.inrange(next_row, y: next_col) {
                        // 第next_row行next_col的棋子
                        if let nodeRC = self.childNodeWithName(self.nodeName(next_row, j: next_col)) {
                            let chessNodeRC = nodeRC as ChessNode
                            if chessNodeRC.number != 0 {
                                break
                            }
                        }
                        next_row += roffset
                        next_col += coffset
                    }
                    next_row -= roffset
                    next_col -= coffset
                    if self.inrange(next_row, y: next_col) && chessNode.number != 0 {
                        // 将(i, j)移动到(next_row, next_col)
                        //                    println("i: \(i), j: \(j)")
                        //                    println("r: \(next_row), c: \(next_col)")
                        chessNode.moveTo(self.positionOfRow(next_row, col:next_col))
                        chessNode.name = self.nodeName(next_row, j: next_col) // 新名字
                    }
                }
            }
        }
    }
    // 合并相同的格子 跟移动算法差不多
    func combineTo(direction: Int) {
        let idx = Int(log2(Double(direction))) // 获得mask
        let ioffset = i_dir[1][idx]
        let joffset = j_dir[1][idx]
        let roffset = pos_dir[0][idx]
        let coffset = pos_dir[1][idx]
        let i0 = i_dir[0][idx]
        let j0 = j_dir[0][idx]
        var next_row: Int = 0
        var next_col: Int = 0
        for var i=i0; i<kRowMax&&i>=0; i+=ioffset {
            for var j=j0; j<kColMax&&j>=0; j+=joffset {
                next_row = i + roffset
                next_col = j + coffset
                if let nodeIJ = self.childNodeWithName(self.nodeName(i, j: j)){
                    let chessNodeIJ = nodeIJ as ChessNode
                    if let nodeRC = self.childNodeWithName(self.nodeName(next_row, j: next_col)) {
                        let chessNodeRC = nodeRC as ChessNode
                        if self.inrange(next_row, y: next_col) &&
                            (next_row != i || next_col != j) &&
                            chessNodeIJ.number == chessNodeRC.number {
                            // 合并了(i, j) & (next_row, next_col)到(next_row, next_col) 执行动画
                            self.runAction(sumSfx)
                            chessNodeRC.combine()
                            chessNodeIJ.removeFromParent()
                            // 计分逻辑 TODO
                            if (chessNodeRC.number == kMaxNumber) { // 2048
                                println("WIN")
                            }
                        }
                    }
                }
            }
        }

    }
    // 检查是否游戏结束 TODO
    func isGameOver() -> Bool {
        for var i=0; i<kRowMax; ++i {
            for var j=0; j<kColMax; ++j {
                // TODO
            }
        }
        return self.children.count >= 16
    }
}