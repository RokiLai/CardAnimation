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
    
    var isUp = false                        //判断是否向上滑动
    var lock = false                        //方向锁
    
    var viewWidth: CGFloat = 279            //卡片视图的宽度
    var viewHeight: CGFloat = 500           //卡片视图的高度
    var viewX: CGFloat = 21                 //卡片视图的x坐标
    var viewY: CGFloat = 40                 //卡片视图的y坐标
    
    var downBtnWidth: CGFloat = 93          //下方按钮的宽度
    var downBtnHeight: CGFloat = 60         //下方按钮的高度
    
    var slideTime: Double = 1               //点击按钮卡片滑动时间
    var slideTime2: Double = 0.5            //拖拽甩出卡片的时间
    var buttonTime: Double = 0.5            //按钮变大的时间
    
    var cornerRadius: CGFloat = 4           //圆角度
    var borderWidth: CGFloat = 0          //边框宽度
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanGesture(sender:)))
        self.view.addGestureRecognizer(panGesture)
        
        homeView.alpha = 1
        secondView.alpha = 0
        myView.layer.cornerRadius = cornerRadius
        myView.layer.borderWidth = borderWidth
        homeView.layer.cornerRadius = cornerRadius
        homeView.layer.borderWidth = borderWidth
        secondView.layer.cornerRadius = cornerRadius
        secondView.layer.borderWidth = borderWidth
        homeBtn.titleLabel?.lineBreakMode = .byWordWrapping
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initSecondView(){
        initButtons()
        self.secondView.alpha = 1
        self.secondView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    func initHomeView(){
        self.homeView.alpha = 1
        self.homeView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    //重置下方按钮
    func initButtons(){
        self.btn1.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:downBtnWidth, height:downBtnHeight)
        self.btn1.backgroundColor = #colorLiteral(red: 0.9372458458, green: 0.9372604489, blue: 0.9567177892, alpha: 0.9)
        self.btn2.frame = CGRect(x:downBtnWidth, y:self.viewHeight-self.downBtnHeight, width:downBtnWidth, height:downBtnHeight)
        self.btn2.backgroundColor = #colorLiteral(red: 0.9372458458, green: 0.9372604489, blue: 0.9567177892, alpha: 0.9)
        self.btn3.frame = CGRect(x:downBtnWidth * 2, y:self.viewHeight-self.downBtnHeight, width:downBtnWidth, height:downBtnHeight)
        self.btn3.backgroundColor = #colorLiteral(red: 0.9372458458, green: 0.9372604489, blue: 0.9567177892, alpha: 0.9)
        buttonSwitch(flag: "all")
    }
    
    //对下方三个按钮设置可见状态
    func buttonSwitch(flag:String){
        btn1.isHidden = true
        btn2.isHidden = true
        btn3.isHidden = true
        switch flag {
        case "btn1":
            btn1.isHidden = false
        case "btn2":
            btn2.isHidden = false
        case "btn3":
            btn3.isHidden = false
        case "all":
            btn1.isHidden = false
            btn2.isHidden = false
            btn3.isHidden = false
        default:
            return
        }
    }
    
    //重置锁
    func initLock(){
        lock = false
        isUp = false
    }
    
    //检查锁
    func checkLock(deltaX:CGFloat,deltaY:CGFloat){
        if deltaX > 1 || deltaY > 1{
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
                if translation.y < -1 {
                    notSureAnimation()
                    self.secondView.transform = CGAffineTransform(translationX: 0, y: translation.y-1)
                }
            } else {
                secondView.transform = CGAffineTransform(translationX: translation.x, y: getY(x: translation.x))
                if translation.x < -30 {
                    knowAnimation()
                }else if translation.x > 30 {
                    dontKnowAnimation()
                }else{
                    UIView.animate(withDuration: 0.3, animations:  {
                        self.initButtons()
                    })
                }
            }
        }
        //放开鼠标 重置状态
        if sender.state == UIGestureRecognizerState.ended{
            //让当前卡片消失
            if deltaX > 210 || deltaY > 330{
                if isUp{
                    //向上消失动画
                    UIView.animate(withDuration: slideTime2, animations:  {
                        self.secondView.transform = CGAffineTransform(translationX: 0, y: -self.viewHeight)
                    })
                } else {
                    if translation.x < 0 {
                        //向左消失动画
                        UIView.animate(withDuration: slideTime2, animations:  {
                            self.secondView.transform = CGAffineTransform(translationX: -self.viewWidth, y: self.getY(x: self.viewWidth))
                        })
                    } else {
                        //向右消失动画
                        UIView.animate(withDuration: slideTime2, animations:  {
                            self.secondView.transform = CGAffineTransform(translationX: self.viewWidth, y: self.getY(x: self.viewWidth))
                        })
                    }
                }
                UIView.animate(withDuration: 1, animations:  {
                    self.secondView.alpha = 0
                })
            }else{
                //卡片返回原处
                UIView.animate(withDuration: 0.5, animations:  {
                    self.secondView.transform = CGAffineTransform(translationX: 0, y: 0)
                })
                UIView.animate(withDuration: 0.8, animations:  {
                    self.initButtons()
                })
            }
            //解锁
            initLock()
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
        UIView.animate(withDuration: slideTime, animations:  {
            self.secondView.transform = CGAffineTransform(translationX: -self.viewWidth, y: self.getY(x: self.viewWidth))
        })
        UIView.animate(withDuration: 2, animations:  {
            self.secondView.alpha = 0
        })
    }
    
    func knowAnimation(){
        buttonSwitch(flag: "btn1")
        
        UIView.animate(withDuration: buttonTime, animations:  {
            self.btn1.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:self.viewWidth , height:self.downBtnHeight)
            self.btn1.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
        })
        UIView.animate(withDuration: 2, animations:  {
            self.homeView.alpha = 1
        })
    }
    
    //按钮“不确定”
    @IBAction func notSure() {
        notSureAnimation()
        UIView.animate(withDuration: slideTime, animations:  {
            self.secondView.transform = CGAffineTransform(translationX: 0, y: -500)
        })
        UIView.animate(withDuration: 2, animations:  {
            self.secondView.alpha = 0
        })
        
    }
    
    func notSureAnimation(){
        buttonSwitch(flag: "btn2")
        
        UIView.animate(withDuration: buttonTime, animations:  {
            self.btn2.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:self.viewWidth , height:self.downBtnHeight)
            self.btn2.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.3176470588, alpha: 1)
        })
        UIView.animate(withDuration: 2, animations:  {
            self.homeView.alpha = 1
        })
    }
    
 
    
    //按钮“不知道”
    @IBAction func dontKnow() {
        dontKnowAnimation()
        UIView.animate(withDuration: slideTime, animations:  {
             self.secondView.transform = CGAffineTransform(translationX: self.viewWidth, y: self.getY(x: self.viewWidth))
        })
        UIView.animate(withDuration: 2, animations:  {
            self.secondView.alpha = 0
        })
    }
    
    func dontKnowAnimation(){
        buttonSwitch(flag: "btn3")
        
        UIView.animate(withDuration: buttonTime, animations:  {
            self.btn3.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:self.viewWidth , height:self.downBtnHeight)
            self.btn3.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8745098039, blue: 0.8980392157, alpha: 1)
        })
        UIView.animate(withDuration: 2, animations:  {
            self.homeView.alpha = 1
        })
    }
    
    //主页大按钮点击切换页面
    @IBAction func flip(_ sender: Any) {
        self.initSecondView()
        UIView.transition(with: myView, duration: 1, options: .transitionFlipFromRight, animations: {self.homeView.alpha = 0}, completion: nil)
    }
    
    //次页大按钮返回主页
    @IBAction func retHome(_ sender: Any) {
        self.initHomeView()
        UIView.transition(with: myView, duration: 1, options: .transitionFlipFromRight, animations: {self.secondView.alpha = 0}, completion: nil)
        
    }
    
    
}
