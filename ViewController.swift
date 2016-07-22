//
//  ViewController.swift
//  Fish
//
//  Created by le ha thanh on 7/15/16.
//  Copyright © 2016 le ha thanh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var diemLabel: UILabel!
    var gameManager : GameManager?
    var timer = NSTimer()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gameManager = GameManager()
        self.view.addSubview((self.gameManager?.hookView)!)
        self.gameManager?.addFishToViewController(self, width: Int(self.view.bounds.width))
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tapHandle(_:))))
        //        print("xyz")
        
        
        NSTimer.scheduledTimerWithTimeInterval(0.025, target : self,selector: #selector(ViewController.updateMove), userInfo: nil, repeats: true)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: true)
        
    }
    func updateMove(){
        gameManager?.updateMove()
        diemLabel.text = String(gameManager!.point)
        
    }
    
    func update(){
        if Int(diemLabel.text!)! >= 100 {
            self.timer.invalidate()
            let alertController = UIAlertController(title: "Kết thúc", message: "Bạn câu 100 điểm trong \(count)", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Chơi lại", style: .Default, handler: { (action) -> Void in
                self.count = 0
                self.countDownLabel.text = "0"
                self.gameManager!.point = 0
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
            })
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            count = count + 1
            countDownLabel.text = String(count)

        }
        
    }
    
    func tapHandle(sender: UIGestureRecognizer){
        let tapPoint = sender.locationInView(self.view)
        self.gameManager?.dropHookerAtX(Int(tapPoint.x))
    }
    
    @IBAction func reset(sender: AnyObject) {
        self.gameManager?.fishViews?.removeAllObjects()
        for object in self.view.subviews {
            if object.isKindOfClass(FishView)
            {
                object.removeFromSuperview()
            }
            
        }
        self.gameManager!.point = 0
        countDownLabel.text = "0"
        count = 0
        
        
        self.gameManager?.addFishToViewController(self, width: Int(self.view.bounds.width))
    }
    
    @IBAction func addFish(sender: AnyObject) {
        self.gameManager?.addFishToViewController(self, width: Int(self.view.bounds.width))
    }
    
}

