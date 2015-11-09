//
//  ViewController.swift
//  AWButton-Lab
//
//  Created by Alex Ling on 9/11/2015.
//  Copyright © 2015 Alex Ling. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
	
	var screenWidth : CGFloat!
	var screenHeight : CGFloat!
	
	var mainButtonView : UIButton!
	
	var buttons : [UIButton] = []
	var buttonNum : Int = 4
	
	let label = UILabel()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.view.backgroundColor = UIColor.lightGrayColor()
		
		self.screenWidth = UIScreen.mainScreen().bounds.size.width
		self.screenHeight = UIScreen.mainScreen().bounds.size.height
		
		self.label.frame = CGRectMake(0, self.screenHeight/2 - 50, self.screenWidth, 50)
		self.label.backgroundColor = UIColor.clearColor()
		self.label.textColor = UIColor.whiteColor()
		self.label.textAlignment = NSTextAlignment.Center
		self.label.font = UIFont.systemFontOfSize(30)
		self.view.addSubview(self.label)
		
		let buttonSize : CGFloat = 30
		self.mainButtonView = UIButton(frame: CGRectMake(30, self.screenHeight - 60, buttonSize, buttonSize))
		self.mainButtonView.backgroundColor = UIColor.clearColor()
		self.mainButtonView.layer.cornerRadius = buttonSize/2
		self.mainButtonView.clipsToBounds = true
		self.mainButtonView.addTarget(self, action: Selector("mainButtonTapped"), forControlEvents: .TouchDown)
		self.mainButtonView.setImage(UIImage(named: "more"), forState: .Normal)
		self.mainButtonView.adjustsImageWhenHighlighted = false
		self.view.addSubview(self.mainButtonView)
		
		for i in 0..<buttonNum {
			let button = UIButton(frame: self.mainButtonView.frame)
			button.backgroundColor = UIColor.clearColor()
			button.layer.cornerRadius = buttonSize/2
			button.clipsToBounds = true
			button.setTitle("\(i)", forState: .Normal)
			button.setImage(UIImage(named: "\(i)"), forState: .Normal)
			button.addTarget(self, action: Selector("optionButtonTapped:"), forControlEvents: .TouchDown)
			button.adjustsImageWhenHighlighted = false
			self.buttons.append(button)
			self.view.addSubview(button)
		}
		
		self.view.bringSubviewToFront(self.mainButtonView)
	}
	
	func mainButtonTapped(){
		self.label.text = ""
		for i in 0..<self.buttonNum{
			let theta : CGFloat = -CGFloat(i) * CGFloat(M_PI/2)/CGFloat(self.buttonNum - 1)
			self.moveButtonToPoint(self.buttons[i], point: CGPointMake(self.buttons[i].center.x + 100 * cos(theta), self.buttons[i].center.y + 100 * sin(theta)), delay: NSTimeInterval(i) * 0.05)
		}
	}
	
	func optionButtonTapped(sender : UIButton){
		let id = sender.currentTitle!
		let idDic = ["0" : "Message", "1" : "Calendar", "2" : "Info", "3" : "Options"]
		self.label.text = idDic[id]
	}
	
	func moveButtonToPoint(button : UIButton, point : CGPoint, delay : NSTimeInterval){
		if button.center == self.mainButtonView.center {
			UIView.animateWithDuration(0.5, delay: 0.05 * NSTimeInterval(self.buttonNum - 1) - delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
					button.center = point
			}, completion:  nil)
		}
		else {
			UIView.animateWithDuration(0.5, delay: delay + 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 10, options: [], animations: {
				button.center = self.mainButtonView.center
				}, completion:  {(finished) in
					button.transform = CGAffineTransformMakeRotation(0)
			})
			let animation = CABasicAnimation(keyPath: "transform.rotation")
			animation.duration = 0.5
			animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
			animation.toValue = NSNumber(float: Float(M_PI) * 8)
			button.layer.addAnimation(animation, forKey: nil)
		}
	}
}

