//
//  MyViewController.swift
//  Demo
//
//  Created by Roki on 2018/1/8.
//  Copyright © 2018年 Xindong. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {
    var number:Int!
    let colorMap=[
        1:UIColor.black,
        2:UIColor.orange,
        3:UIColor.blue
    ]
    
    init(number initNumber:Int){
        self.number = initNumber
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        let numberLabel = UILabel(frame:CGRect(x:130, y:50, width:50, height:30))
        numberLabel.text = "第\(number!)页"
        numberLabel.textColor = UIColor.white
        self.view.addSubview(numberLabel)
        self.view.backgroundColor = colorMap[number]
    }
}
