//
//  SliderViewController.swift
//  Demo
//
//  Created by Roki on 2018/1/8.
//  Copyright © 2018年 Xindong. All rights reserved.
//

import UIKit
import Foundation

class SliderViewController: UIViewController {

    var mainContentView:UIView!
    var leftSideView:UIView!
    var rightSideView:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubViews()
        showLeftViewController()
        
        //用mainContentView装下MainTab
        let mainTabVC: UITabBarController! = self.storyboard!.instantiateViewController(withIdentifier: "MainTabViewController") as! UITabBarController
        mainContentView.addSubview(mainTabVC.view)
    }
    
    func initSubViews(){
        //划动手势
        //左划
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: Selector(("handleSwipeGesture:")))
        swipeLeftGesture.direction = UISwipeGestureRecognizerDirection.left //不设置是右
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        let viewRect = self.view.bounds
        rightSideView = UIView(frame: viewRect)
        rightSideView.backgroundColor = UIColor.blue
        self.view.addSubview(rightSideView)
        
        leftSideView = UIView(frame: viewRect)
        leftSideView.backgroundColor = UIColor.darkGray
        let myImageView: UIImageView = UIImageView(image: UIImage(named: "sidebar_bg@2x.jpg"))
        leftSideView.addSubview(myImageView)
        
        let myImageView2: UIImageView = UIImageView(frame: CGRect(x:30, y:220, width:30, height:30))
        myImageView2.image = UIImage(named: "qv_msg_bar_vip.png")
        let myLable :UILabel = UILabel(frame: CGRect(x:70, y:230, width:150, height:20))
        myLable.text = "开通会员"
        myLable.textColor = UIColor.green
        leftSideView.addSubview(myLable)
        leftSideView.addSubview(myImageView2)
        
        self.view.addSubview(leftSideView)
        
        mainContentView = UIView(frame: viewRect)
        mainContentView.backgroundColor = UIColor.red
        self.view.addSubview(mainContentView)
    }
    
    func showLeftViewController(){
        let translateX: CGFloat = 200
        let transcale: CGFloat = 0.85
        let transT: CGAffineTransform = CGAffineTransform(translationX: translateX, y: 0)
        let scaleT: CGAffineTransform = CGAffineTransform(scaleX: transcale, y: transcale)
        let conT: CGAffineTransform = transT.concatenating(scaleT)
        
        UIView.animate(withDuration: 0.8, animations: { () -> Void in
            self.mainContentView.transform = conT
        })
    }
    
    
    func handleSwipeGesture(sender:UISwipeGestureRecognizer){
        let mainVC: UIViewController! = self.storyboard!.instantiateViewController(withIdentifier: "MainTabViewController")
        
        //划动的方向
        let direction = sender.direction
        //判断是上下左右
        switch (direction){
        case UISwipeGestureRecognizerDirection.left:
            print("Left")
            self.present(mainVC, animated: false, completion: nil)
            break
        default:
            break;
        }
    }

}
