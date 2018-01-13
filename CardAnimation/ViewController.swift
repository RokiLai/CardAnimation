//
//  ViewController.swift
//  CardAnimation2
//
//  Created by Roki on 2018/1/13.
//  Copyright © 2018年 xindong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var homeCard = Card()
    var secondCard = Card()
    var homeBtn: UIButton = UIButton()
    var secondBtn: UIButton = UIButton()
    var knowBtn: Button = Button()
    var dontKnowBtn: Button = Button()
    var notSureBtn: Button = Button()
    
    var homeTitle: String = "汤姆米切尔提出的机器学习的定义"
    var secondTitle: String = "汤姆米切尔提出的机器学习的定义..."
    var buttonTime: Double = 0.2                        //按钮变大的时间
    var reBtnTime: Double = 0.3                         //还原三个按钮的时间
    var reBtnWidth: CGFloat = 30                        //下方按钮还原判定的宽度
    var reBtnHeight: CGFloat =  30                      //下方按钮还原判定的高度
    var slideWidth: CGFloat = 220                       //判定左右划出的宽度
    var slideHeight: CGFloat = 300                      //判定向上划出的高度
    var slideTime: Double = 0.6                         //点击按钮卡片滑动时间
    var slideTime2: Double = 0.2                        //拖拽甩出卡片的时间
    var reCardTime: Double = 0.3                        //卡片返回原处的时间
    
    var isUp = false                                    //判断是否向上滑动
    var lock = false                                    //方向锁
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9647058824, alpha: 1)
        view.addSubview(secondCard)
        view.addSubview(homeCard)
        
        initHomeCard()
        homeCard.addSubview(homeBtn)
        
        initSecondCard()
        secondCard.addSubview(secondBtn)
        secondCard.addSubview(knowBtn)
        secondCard.addSubview(notSureBtn)
        secondCard.addSubview(dontKnowBtn)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePanGesture(sender:)))
        secondCard.addGestureRecognizer(panGesture)
        
        knowBtn.addTarget(self, action: #selector(self.knowAction), for: .touchUpInside)
        notSureBtn.addTarget(self, action: #selector(self.notSureAction), for: .touchUpInside)
        dontKnowBtn.addTarget(self, action: #selector(self.dontKnowAction), for: .touchUpInside)
        
        
    }
    
    //初始化主页卡片的内容
    func initHomeCard(){
        initHomeBtn()
    }
    
    //初始化次页卡片的内容
    func initSecondCard(){
        initSecondBtn()
        initDownBtns()
    }
    
    //初始化下面三个按钮
    func initDownBtns(){
        initKnowBtn()
        initNotsureBtn()
        initDontKnowBtn()
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
        let translation : CGPoint = sender.translation(in: secondCard)
        let deltaX = abs(translation.x)
        let deltaY = abs(translation.y)
        
        if !lock {
            checkLock(deltaX: deltaX, deltaY: deltaY)
        } else {
            if isUp {
                if translation.y < 10 {
                    self.secondCard.transform = CGAffineTransform(translationX: 0, y: translation.y)
                    if translation.y < -reBtnHeight {
                        notSureAnimation()
                    } else {
                        UIView.animate(withDuration: reBtnTime, animations:  {
                            self.initDownBtns()
                        })
                    }
                }
            } else {
                secondCard.transform = CGAffineTransform(translationX: translation.x, y: getY(x: translation.x))
                if translation.x < -reBtnWidth {
                    knowAnimation()
                }else if translation.x > reBtnWidth {
                    dontKnowAnimation()
                }else{
                    UIView.animate(withDuration: reBtnTime, animations:  {
                        self.initDownBtns()
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
                        self.secondCard.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
                    })
                } else {
                    if translation.x < 0 {
                        //向左消失动画
                        UIView.animate(withDuration: slideTime2, animations:  {
                            self.secondCard.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: self.getY(x: self.view.bounds.width))
                        })
                    } else {
                        //向右消失动画
                        UIView.animate(withDuration: slideTime2, animations:  {
                            self.secondCard.transform = CGAffineTransform(translationX: self.view.bounds.width, y: self.getY(x: self.view.bounds.width))
                        })
                    }
                }
            }else{
                //卡片返回原处
                UIView.animate(withDuration: reCardTime, animations:  {
                    self.secondCard.transform = CGAffineTransform(translationX: 0, y: 0)
                })
                UIView.animate(withDuration: reBtnTime, animations:  {
                    self.initDownBtns()
                })
            }
            //解锁
            initLock()
        }
    }
    
    //重置锁
    func initLock(){
        lock = false
        isUp = false
    }
    
    //旋转角度计算 根据横坐标得到纵坐标
    func getY(x:CGFloat) -> CGFloat{
        let width = secondCard.bounds.width
        let temp : Double = Double(width)
        let tempx : Double = Double(x)
        return CGFloat(sqrt(pow(7.21 * temp, 2) - tempx * tempx) - 7.12 * temp) - Card.M
        
    }
    
    //初始化主页按钮
    func initHomeBtn() {
        homeBtn.frame = CGRect(x: 0, y: 0, width: homeCard.bounds.width, height:homeCard.bounds.height)
        homeBtn.layer.cornerRadius = 4
        homeBtn.setTitle(homeTitle, for: .normal)
        homeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        homeBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        homeBtn.backgroundColor = homeBtn.backgroundColor
        homeBtn.addTarget(self, action: #selector(flipHomeCardBtnAnimation), for: .touchUpInside)
        homeBtn.titleLabel?.lineBreakMode = .byWordWrapping
    }
    
    //初始化次页大按钮
    func initSecondBtn() {
        secondBtn.frame = CGRect(x: 0, y: 0, width: secondCard.bounds.width, height:secondCard.bounds.height)
        secondBtn.layer.cornerRadius = 4
        secondBtn.setTitle(secondTitle, for: .normal)
        secondBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        secondBtn.backgroundColor = homeBtn.backgroundColor
        secondBtn.addTarget(self, action: #selector(flipSecondCardBtnAnimation), for: .touchUpInside)
    }
    
    //初始化“知道”按钮
    func initKnowBtn(){
        knowBtn.frame = CGRect(x: 0, y: secondCard.bounds.height - Button.height, width: secondCard.bounds.width / 3, height: Button.height)
        knowBtn.setTitle("知道", for: .normal)
        knowBtn.reset()
    }
    
    //初始化“不确定”按钮
    func initNotsureBtn(){
        notSureBtn.frame = CGRect(x: secondCard.bounds.width / 3, y: secondCard.bounds.height - Button.height, width: secondCard.bounds.width / 3, height: Button.height)
        notSureBtn.setTitle("不确定", for: .normal)
        notSureBtn.reset()
    }
    
    //初始化“不知道”按钮
    func initDontKnowBtn(){
        dontKnowBtn.frame = CGRect(x: secondCard.bounds.width / 3 * 2, y: secondCard.bounds.height - Button.height, width: secondCard.bounds.width / 3, height: Button.height)
        dontKnowBtn.setTitle("不知道", for: .normal)
        dontKnowBtn.reset()
    }
    
    
    //点击主页按钮进行翻转页面
    @objc func flipHomeCardBtnAnimation() {
        initSecondCard()
        flipSecondCard90()
        UIView.animate(withDuration: 0.1, animations: {self.flipHomeCard90()})
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.flipSecondCardReturn), userInfo: nil, repeats: false)
        //        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.flipSecondCardReturn), userInfo: nil, repeats: false)
    }
    
    //点击次页大按钮进行翻转页面
    @objc func flipSecondCardBtnAnimation() {
        initHomeCard()
        flipHomeCard90()
        UIView.animate(withDuration: 0.1, animations: {self.flipSecondCard90()})
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.flipHomeCardReturn), userInfo: nil, repeats: false)
    }
    
    //主页转90°
    @objc func flipHomeCard90(){
        homeCard.layer.transform = CATransform3DMakeRotation(CGFloat(.pi / 2.0), 0, -1, 0)
    }
    
    //主页转回0°
    @objc func flipHomeCard0(){
        homeCard.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
    }
    
    //转回主页
    @objc func flipHomeCardReturn(){
        view.bringSubview(toFront: homeCard)
        UIView.animate(withDuration: 0.3, animations: {self.homeCard.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)})
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.flipHomeCard0), userInfo: nil, repeats: false)
    }
    
    //次页转90°
    @objc func flipSecondCard90(){
        secondCard.layer.transform = CATransform3DMakeRotation(CGFloat(.pi / 2.0), 0, -1, 0)
    }
    
    //次页转回0°
    @objc func flipSecondCard0(){
        secondCard.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)
    }
    
    //转回次页
    @objc func flipSecondCardReturn(){
        view.bringSubview(toFront: secondCard)
        UIView.animate(withDuration: 0.3, animations: {self.secondCard.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0)})
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.flipHomeCard0), userInfo: nil, repeats: false)
    }
    
    //“知道”按钮点击动作
    @objc func knowAction(){
        knowAnimation()
        UIView.animate(withDuration: slideTime, animations:  {
            self.secondCard.transform =  CGAffineTransform(translationX: -self.view.bounds.width, y: self.getY(x: self.view.bounds.width))
        })
    }
    
    //“不确定”按钮点击动作
    @objc func notSureAction(){
        notSureAnimation()
        UIView.animate(withDuration: slideTime, animations:  {
            self.secondCard.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height)
        })
        
    }
    
    //“不知道”按钮点击动作
    @objc func dontKnowAction(){
        dontKnowAnimation()
        UIView.animate(withDuration: slideTime, animations:  {
            self.secondCard.transform = CGAffineTransform(translationX: self.view.bounds.width, y: self.getY(x: self.view.bounds.width))
        })
    }
    
    //左滑动画（知道）
    func knowAnimation(){
        secondCard.bringSubview(toFront: knowBtn)
        UIView.animate(withDuration: buttonTime, animations:  {
            self.knowBtn.frame = CGRect(x:0, y:self.secondCard.bounds.height-Button.height, width:self.secondCard.bounds.width , height:Button.height)
            self.knowBtn.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
            self.knowBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            self.knowBtn.titleLabel?.font = UIFont.systemFont(ofSize: Button.bigFrontSize)
        })
    }
    
    //上滑动画（不确定）
    func notSureAnimation(){
        secondCard.bringSubview(toFront: notSureBtn)
        UIView.animate(withDuration: buttonTime, animations:  {
            self.notSureBtn.frame = CGRect(x:0, y:self.secondCard.bounds.height-Button.height, width:self.secondCard.bounds.width , height:Button.height)
            self.notSureBtn.backgroundColor = #colorLiteral(red: 1, green: 0.7333333333, blue: 0.3176470588, alpha: 1)
            self.notSureBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            self.notSureBtn.titleLabel?.font = UIFont.systemFont(ofSize: Button.bigFrontSize)
        })
    }
    
    //右滑动画（不知道）
    func dontKnowAnimation(){
        secondCard.bringSubview(toFront: dontKnowBtn)
        UIView.animate(withDuration: buttonTime, animations:  {
            self.dontKnowBtn.frame = CGRect(x:0, y:self.secondCard.bounds.height-Button.height, width:self.secondCard.bounds.width , height:Button.height)
            self.dontKnowBtn.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.8745098039, blue: 0.8980392157, alpha: 1)
            self.dontKnowBtn.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            self.dontKnowBtn.titleLabel?.font = UIFont.systemFont(ofSize: Button.bigFrontSize)
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

