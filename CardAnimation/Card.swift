//
//  Card.swift
//  CardAnimation
//
//  Created by Roki on 2018/1/13.
//  Copyright © 2018年 Xindong. All rights reserved.
//

import UIKit

class Card: UIView{
    static var X: CGFloat = 20                             //卡片视图的x坐标
    static var Y: CGFloat = 59                             //卡片视图的y坐标
    static var M: CGFloat = 30                             //卡片下方留白
    static var viewColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)                     //卡片视图的背景色
    static var cornerRadius: CGFloat = 4                   //卡片圆角度
    static var borderWidth: CGFloat = 0.5                  //卡片边框宽度
    static var borderColor: CGColor = #colorLiteral(red: 0.8784313725, green: 0.8980392157, blue: 0.9294117647, alpha: 1)                   //卡片边框颜色


    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: Card.X, y: Card.Y, width: UIScreen.main.bounds.width - 2 * Card.X, height: UIScreen.main.bounds.height - Card.Y - Card.M))
        layer.cornerRadius = Card.cornerRadius
        backgroundColor = Card.viewColor
        layer.borderWidth = Card.borderWidth
        layer.borderColor = Card.borderColor
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
