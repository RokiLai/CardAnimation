//
//  ViewController.swift
//  Demo
//
//  Created by Roki on 2018/1/8.
//  Copyright © 2018年 Xindong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myView: UIView!                       //容器页面 包含两个页面
    @IBOutlet weak var secondView: UIView!              //次页面
    @IBOutlet weak var homeView: UIView!                //主页面
    @IBOutlet weak var homeBtn: UIButton!               //主页面的大按钮
    @IBOutlet weak var btn: UIButton!                   //次页面的大按钮
    @IBOutlet weak var btn1: UIButton!                  //次页面的“知道”按钮
    @IBOutlet weak var btn2: UIButton!                  //次页面的”不确定“按钮
    @IBOutlet weak var btn3: UIButton!                  //次页面的“不知道”按钮
    
    var isUp = false                                    //判断是否向上滑动
    var lock = false                                    //方向锁
    
    var screenWidth = UIScreen.main.bounds.width        //屏幕宽度
    var screenHeight = UIScreen.main.bounds.height      //屏幕高度
    
    var flipTime: Double = 0.2                          //翻转页面的时间
    var screenColor: UIColor = #colorLiteral(red: 0.9723983407, green: 0.9726732373, blue: 0.9681202769, alpha: 1)
    
    var viewWidth: CGFloat = 336                        //卡片视图的宽度
    var viewHeight: CGFloat = 578                       //卡片视图的高度
    var viewX: CGFloat = 20                             //卡片视图的x坐标
    var viewY: CGFloat = 59                             //卡片视图的y坐标
    var viewColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)                         //卡片视图的背景色
    
    var downBtnWidth: CGFloat = 112                      //下方按钮的宽度
    var downBtnHeight: CGFloat = 72                     //下方按钮的高度
    var downBtnFrontColor: UIColor = #colorLiteral(red: 0.6862745098, green: 0.6784313725, blue: 0.6784313725, alpha: 1)                 //下方按钮文字颜色
    var downBtnFrontSize: CGFloat = 16                  //下方按钮文字尺寸
    var downBtnColor: UIColor = #colorLiteral(red: 0.9372458458, green: 0.9372604489, blue: 0.9567177892, alpha: 0.9)                      //下方按钮的背景色
    var reBtnWidth: CGFloat = 30                        //下方按钮还原判定的宽度
    var reBtnHeight: CGFloat =  30                      //下方按钮还原判定的高度
    
    var slideTime: Double = 0.6                         //点击按钮卡片滑动时间
    var slideTime2: Double = 0.2                        //拖拽甩出卡片的时间
    var buttonTime: Double = 0.2                        //按钮变大的时间
    var buttonBigFrontSize: CGFloat = 20                //按钮变大时文字尺寸
    var reBtnTime: Double = 0.3                         //还原三个按钮的时间
    var reCardTime: Double = 0.3                        //卡片返回原处的时间
    var slideWidth: CGFloat = 220                       //判定左右划出的宽度
    var slideHeight: CGFloat = 300                      //判定向上划出的高度
    
    var cornerRadius: CGFloat = 4                       //圆角度
    var borderWidth: CGFloat = 0.5                      //边框宽度
    var borderColor: CGColor = #colorLiteral(red: 0.8784313725, green: 0.8980392157, blue: 0.9294117647, alpha: 1)                       //边框颜色
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanGesture(sender:)))
        self.view.addGestureRecognizer(panGesture)
        
        initMyView()
        initHomeView()
        hideSecondView()
        homeBtn.titleLabel?.lineBreakMode = .byWordWrapping
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initMyView(){
        myView.layer.cornerRadius = cornerRadius
        myView.backgroundColor = viewColor
    }
    
    func initHomeView(){
        homeView.layer.cornerRadius = cornerRadius
        homeView.layer.borderWidth = borderWidth
        homeView.layer.borderColor = borderColor
        homeView.backgroundColor = viewColor
        homeView.alpha = 1
        homeView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    func hideHomeView(){
        homeView.alpha = 0
    }
    
    func initSecondView(){
        initBtn1()
        initBtn2()
        initBtn3()
        secondView.backgroundColor = viewColor
        secondView.layer.cornerRadius = cornerRadius
        secondView.layer.borderWidth = borderWidth
        secondView.layer.borderColor = borderColor
        secondView.alpha = 1
//        secondView.frame = CGRect(x:0, y:0, width:viewWidth, height:viewHeight)
        secondView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    @objc func hideSecondView(){
        secondView.alpha = 0
    }
    
    func initBtn1(){
        btn1.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:downBtnWidth, height:downBtnHeight)
        btn1.layer.borderColor = borderColor
        btn1.backgroundColor = downBtnColor
        btn1.titleLabel?.font = UIFont.systemFont(ofSize: downBtnFrontSize)
        btn1.setTitleColor(downBtnFrontColor, for: .normal)
        btn1.isHidden = false
        
    }
    
    func initBtn2(){
        btn2.frame = CGRect(x:downBtnWidth, y:self.viewHeight-self.downBtnHeight, width:downBtnWidth, height:downBtnHeight)
        btn2.layer.borderColor = borderColor
        btn2.backgroundColor = downBtnColor
        btn2.titleLabel?.font = UIFont.systemFont(ofSize: downBtnFrontSize)
        btn2.setTitleColor(downBtnFrontColor, for: .normal)
        btn2.isHidden = false
    }
    
    func initBtn3(){
        btn3.frame = CGRect(x:downBtnWidth * 2, y:self.viewHeight-self.downBtnHeight, width:downBtnWidth, height:downBtnHeight)
        btn3.titleLabel?.font = UIFont.systemFont(ofSize: downBtnFrontSize)
        btn3.layer.borderColor = borderColor
        btn3.backgroundColor = downBtnColor
        btn3.setTitleColor(downBtnFrontColor, for: .normal)
        btn3.isHidden = false
    }
    
    func initBtns(){
        initBtn1()
        initBtn2()
        initBtn3()
    }
    
    //重置锁
    func initLock(){
        lock = false
        isUp = false
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
                if translation.y < 10 {
                    self.secondView.transform = CGAffineTransform(translationX: 0, y: translation.y)
                    if translation.y < -reBtnHeight {
                        notSureAnimation()
                    } else {
                        UIView.animate(withDuration: reBtnTime, animations:  {
                            self.initBtns()
                        })
                    }
                }
            } else {
                secondView.transform = CGAffineTransform(translationX: translation.x, y: getY(x: translation.x))
                if translation.x < -reBtnWidth {
                    knowAnimation()
                }else if translation.x > reBtnWidth {
                    dontKnowAnimation()
                }else{
                    UIView.animate(withDuration: reBtnTime, animations:  {
                        self.initBtns()
                    })
                }
            }
        }
        //放开鼠标 重置状态
        if sender.state == UIGestureRecognizerState.ended{
            //让当前卡片消失
            if deltaX > slideWidth || deltaY > slideHeight{
                if isUp{
                    //向上消失动画
                    UIView.animate(withDuration: slideTime2, animations:  {
                        self.secondView.transform = CGAffineTransform(translationX: 0, y: -self.screenHeight)
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
                Timer.scheduledTimer(timeInterval: slideTime2, target: self, selector: #selector(self.hideSecondView), userInfo: nil, repeats: false)
            }else{
                //卡片返回原处
                UIView.animate(withDuration: reCardTime, animations:  {
                    self.secondView.transform = CGAffineTransform(translationX: 0, y: 0)
                })
                UIView.animate(withDuration: reBtnTime, animations:  {
                    self.initBtns()
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
        return CGFloat(sqrt(pow(7.21 * temp, 2) - tempx * tempx) - 7.12 * temp) - 26
        
    }
    
    //按钮“知道”
    @IBAction func know() {
        knowAnimation()
        UIView.animate(withDuration: slideTime, animations:  {
            self.secondView.transform = CGAffineTransform(translationX: -self.screenWidth, y: self.getY(x: self.screenWidth))
        })
        Timer.scheduledTimer(timeInterval: slideTime, target: self, selector: #selector(self.hideSecondView), userInfo: nil, repeats: false)
    }
    
    func knowAnimation(){
        buttonSwitch(flag: "btn1")
        UIView.animate(withDuration: buttonTime, animations:  {
            self.btn1.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:self.viewWidth , height:self.downBtnHeight)
            self.btn1.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
            self.btn1.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            self.btn1.titleLabel?.font = UIFont.systemFont(ofSize: self.buttonBigFrontSize)
        })
        self.homeView.alpha = 1
    }
    
    //按钮“不确定”
    @IBAction func notSure() {
        notSureAnimation()
        UIView.animate(withDuration: slideTime, animations:  {
            self.secondView.transform = CGAffineTransform(translationX: 0, y: -self.screenHeight)
        })
        Timer.scheduledTimer(timeInterval: slideTime, target: self, selector: #selector(self.hideSecondView), userInfo: nil, repeats: false)
    }
    
    func notSureAnimation(){
        buttonSwitch(flag: "btn2")
        UIView.animate(withDuration: buttonTime, animations:  {
            self.btn2.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:self.viewWidth , height:self.downBtnHeight)
            self.btn2.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.3176470588, alpha: 1)
            self.btn2.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            self.btn2.titleLabel?.font = UIFont.systemFont(ofSize: self.buttonBigFrontSize)
        })
        self.homeView.alpha = 1
    }
    
    //按钮“不知道”
    @IBAction func dontKnow() {
        dontKnowAnimation()
        UIView.animate(withDuration: slideTime, animations:  {
            self.secondView.transform = CGAffineTransform(translationX: self.screenWidth, y: self.getY(x: self.screenWidth))
        })
        Timer.scheduledTimer(timeInterval: slideTime, target: self, selector: #selector(self.hideSecondView), userInfo: nil, repeats: false)
    }
    
    func dontKnowAnimation(){
        buttonSwitch(flag: "btn3")
        UIView.animate(withDuration: buttonTime, animations:  {
            self.btn3.frame = CGRect(x:0, y:self.viewHeight-self.downBtnHeight, width:self.viewWidth , height:self.downBtnHeight)
            self.btn3.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8745098039, blue: 0.8980392157, alpha: 1)
            self.btn3.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            self.btn3.titleLabel?.font = UIFont.systemFont(ofSize: self.buttonBigFrontSize)
        })
        self.homeView.alpha = 1
    }
    
    //主页大按钮点击切换页面
    @IBAction func flip(_ sender: Any) {
        initSecondView()
        UIView.transition(with: myView, duration: flipTime, options: .transitionFlipFromRight, animations: {self.hideHomeView()}, completion: nil)
    }
    
    //次页大按钮返回主页
    @IBAction func retHome(_ sender: Any) {
        initHomeView()
        UIView.transition(with: myView, duration: flipTime, options: .transitionFlipFromRight, animations: {self.hideSecondView()}, completion: nil)
        
    }
    
    
}
