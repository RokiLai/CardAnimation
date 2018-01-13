//
//  Button.swift
//  CardAnimation
//
//  Created by Roki on 2018/1/13.
//  Copyright © 2018年 Xindong. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    static var height: CGFloat = 72                        //按钮高度
    static var bigFrontSize: CGFloat = 20                  //按钮变大后字体尺寸
    static var frontSize: CGFloat = 16                     //默认字体尺寸
    static var borderWidth: CGFloat = 0.5                  //默认边框宽度
    static var cornerRadius: CGFloat = 4                   //默认圆角度
    static var borderColor: CGColor = #colorLiteral(red: 0.8784313725, green: 0.8980392157, blue: 0.9294117647, alpha: 1)                   //边框颜色
    static var BtnFrontColor: UIColor = #colorLiteral(red: 0.6862745098, green: 0.6784313725, blue: 0.6784313725, alpha: 1)                 //默认钮文字颜色
    static var downBtnColor: UIColor = #colorLiteral(red: 0.9630343318, green: 0.9728212953, blue: 0.9811994433, alpha: 1)                  //默认背景色
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = Button.borderWidth
        layer.cornerRadius = Button.cornerRadius
        layer.borderColor = Button.borderColor
        backgroundColor = Button.downBtnColor
        titleLabel?.font = UIFont.systemFont(ofSize: Button.frontSize)
        setTitleColor(Button.BtnFrontColor, for: .normal)
    }
    
    func reset(){
        layer.borderWidth = Button.borderWidth
        layer.cornerRadius = Button.cornerRadius
        layer.borderColor = Button.borderColor
        backgroundColor = Button.downBtnColor
        titleLabel?.font = UIFont.systemFont(ofSize: Button.frontSize)
        setTitleColor(Button.BtnFrontColor, for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
