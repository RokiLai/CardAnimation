//
//  ViewController.swift
//  Demo
//
//  Created by Roki on 2018/1/8.
//  Copyright © 2018年 Xindong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myView: UIView!           //容器页面 包含两个页面
    @IBOutlet weak var secondView: UIView!  //次页面
    @IBOutlet weak var homeView: UIView!    //主页面
    @IBOutlet weak var homeBtn: UIButton!   //主页面的大按钮
    @IBOutlet weak var btn: UIButton!       //次页面的大按钮
    @IBOutlet weak var btn1: UIButton!      //次页面的“知道”按钮
    @IBOutlet weak var btn2: UIButton!      //次页面的”不确定“按钮
    @IBOutlet weak var btn3: UIButton!      //次页面的“不知道”按钮
    
    var isUp = false        //判断是否向上滑动
    var lock = false        //方向锁
    
    var viewWidth = 279         //卡片视图的宽度
    var viewHeight = 500        //卡片视图的高度
    var viewX = 21              //卡片视图的x坐标
    var viewY = 40              //卡片视图的y坐标
    
    var downBtnWidth:Int = 93    //下方按钮的宽度
    var downBtnHeight:Int = 60   //下方按钮的高度
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanGesture(sender:)))
        self.view.addGestureRecognizer(panGesture)
        
        homeView.alpha = 1
        secondView.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //对下方按钮一起设置可见状态
    func hideButtons(f:Bool){
        btn1.isHidden = f
        btn2.isHidden = f
        btn3.isHidden = f
    }
    
    //重置下方按钮
    func initButtons(){
        self.btn1.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:downBtnWidth, height:downBtnHeight)
        self.btn1.backgroundColor = #colorLiteral(red: 0.9372458458, green: 0.9372604489, blue: 0.9567177892, alpha: 0.9)
        self.btn2.frame = CGRect(x:downBtnWidth, y:self.viewHeight-self.downBtnHeight, width:downBtnWidth, height:downBtnHeight)
        self.btn2.backgroundColor = #colorLiteral(red: 0.9372458458, green: 0.9372604489, blue: 0.9567177892, alpha: 0.9)
        self.btn3.frame = CGRect(x:downBtnWidth * 2, y:self.viewHeight-self.downBtnHeight, width:downBtnWidth, height:downBtnHeight)
        self.btn3.backgroundColor = #colorLiteral(red: 0.9372458458, green: 0.9372604489, blue: 0.9567177892, alpha: 0.9)
        hideButtons(f: false)
        
    }
    
    //重置锁
    func initLock(){
        lock = false
        isUp = false
    }
    
    //检查锁
    func checkLock(deltaX:CGFloat,deltaY:CGFloat){
        if deltaX>1 || deltaY > 1{
            lock = true
            if deltaX * 2 < deltaY {
                isUp = true
            }else{
                isUp = false
            }
        }
    }
    
    //拖动手势
    @ objc func handlePanGesture(sender: UIPanGestureRecognizer){

        //得到拖的过程中的xy坐标
        let translation : CGPoint = sender.translation(in: btn)
        let deltaX = abs(translation.x)
        let deltaY = abs(translation.y)
        
        
        if !lock {
            checkLock(deltaX: deltaX, deltaY: deltaY)
        } else {
            if isUp {
                if(translation.y<0){
                    notSureAnimation()
                    self.secondView.transform = CGAffineTransform(translationX: 0, y: translation.y)
                }
            } else {
                if(translation.x<0){
                    secondView.transform = CGAffineTransform(translationX: translation.x, y: getY(x: translation.x))
                    knowAnimation()
                }else{
                    secondView.transform = CGAffineTransform(translationX: translation.x, y: getY(x: translation.x))
                    dontKnowAnimation()
                }
                
            }
        }
        
        
        //放开鼠标 重置状态
        if sender.state == UIGestureRecognizerState.ended{
            
            //让当前卡片消失
            if deltaX > 200 || deltaY > 300{
                secondView.alpha = 0
            }
            secondView.transform = CGAffineTransform(translationX: 0, y: 0)
            initLock()
            initButtons()
        }
    }
    
    //旋转角度计算 根据横坐标得到纵坐标
    func getY(x:CGFloat) -> CGFloat{
        let width = secondView.bounds.width
        let temp : Double = Double(width)
        let tempx : Double = Double(x)
        return CGFloat(sqrt(pow(7.21 * temp, 2) - tempx * tempx) - 7.12 * temp) - 28
        
    }
    
    //按钮“知道”
    @IBAction func know() {
        knowAnimation()
        UIView.animate(withDuration: 1, animations:  {
            self.secondView.alpha = 0
        })
    }
    
    func knowAnimation(){
        btn1.isHidden = false
        btn2.isHidden = true
        btn3.isHidden = true
        
        UIView.animate(withDuration: 0.5, animations:  {
            self.btn1.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:self.viewWidth , height:self.downBtnHeight)
            self.btn1.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
            self.homeView.alpha = 1
        })
    }
    
    //按钮“不确定”
    @IBAction func notSure() {
        notSureAnimation()
        UIView.animate(withDuration: 1, animations:  {
            self.secondView.alpha = 0
        })
    }
    
    func notSureAnimation(){
        btn1.isHidden = true
        btn2.isHidden = false
        btn3.isHidden = true
        UIView.animate(withDuration: 0.5, animations:  {
            self.btn2.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:self.viewWidth , height:self.downBtnHeight)
            self.btn2.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.3176470588, alpha: 1)
            self.homeView.alpha = 1
        })
    }
    
    //按钮“不知道”
    @IBAction func dontKnow() {
        notSureAnimation()
        UIView.animate(withDuration: 1, animations:  {
            self.secondView.alpha = 0
        })
    }
    
    func dontKnowAnimation(){
        btn1.isHidden = true
        btn2.isHidden = true
        btn3.isHidden = false
        UIView.animate(withDuration: 0.5, animations:  {
            self.btn3.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:self.viewWidth , height:self.downBtnHeight)
            self.btn3.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8745098039, blue: 0.8980392157, alpha: 1)
            self.homeView.alpha = 1
        })
    }
    
    //主页大按钮点击切换页面
    @IBAction func flip(_ sender: Any) {
        initButtons()
        UIView.transition(with: myView, duration: 1, options: .transitionFlipFromRight, animations: {self.homeView.alpha = 0;self.secondView.alpha = 1}, completion: nil)
    }
    
    //次页大按钮返回主页
    @IBAction func retHome(_ sender: Any) {
        UIView.transition(with: myView, duration: 1, options: .transitionFlipFromRight, animations: {self.homeView.alpha = 1;self.secondView.alpha = 0}, completion: nil)
        
    }
    
    
}
