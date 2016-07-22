//
//  GameManager.swift
//  Fish
//
//  Created by le ha thanh on 7/16/16.
//  Copyright © 2016 le ha thanh. All rights reserved.
//

import UIKit

class  GameManager : NSObject {
    var fishViews : NSMutableArray?
    var hookView : HookerView?
    var point: Int = 0
    override init() {
        self.fishViews = NSMutableArray()
        self.hookView = HookerView(frame: CGRectMake(0, -490, 20, 490))
    }
    
    func addFishToViewController(viewcontroller: UIViewController, width: Int){
        
        let fishView = FishView(frame: CGRectMake(0, 0, 60, 45))
        fishView.generateFish(width)
        self.fishViews?.addObject(fishView)
        viewcontroller.view.addSubview(fishView)
        print(fishView.tag)
    }
    
    
    func updateMove(){
        self.hookView?.updateMove()
        for fishView in self.fishViews! {
            fishView.updateMove()
            
            if CGRectContainsPoint(fishView.frame, CGPointMake(self.hookView!.center.x, self.hookView!.frame.origin.y + self.hookView!.frame.height + fishView.frame.width/2)) && self.hookView?.status == self.hookView?.DROPPING {
                bite(fishView as! FishView)
            }
        }
    }
    
    func dropHookerAtX(x : Int){
        self.hookView?.dropDownAtX(x)
    }
    
    
    func bite(fishView: FishView){
        if (fishView.status != fishView.CAUGHT && self.hookView?.status != self.hookView?.DRAWINGUP && self.hookView?.info == self.hookView?.NO )
        {
            fishView.caught()
            self.hookView?.info = self.hookView?.YES
            fishView.center = CGPointMake(self.hookView!.center.x, self.hookView!.frame.origin.y +
                                            self.hookView!.frame.height + fishView.frame.width/2)
            point = fishView.tag == 100 ? point + 1 : fishView.tag == 101 ? point + 5 : point + 10
        }
        self.hookView?.status = self.hookView?.CAUGHTF
  
    }
    
    func diem() -> Int {
        return point
    }


}