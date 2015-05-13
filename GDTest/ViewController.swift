//
//  ViewController.swift
//  GDTest
//
//  Created by Nirvana on 5/8/15.
//  Copyright (c) 2015 Nirvana. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MAMapViewDelegate, UIGestureRecognizerDelegate {

    var mapView: MAMapView?
    var locationButton: UIButton?
//    var currentPinch: UIPinchGestureRecognizer?
    var zoomButtonIn: UIButton?
    var zoomButtonOut: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initMapView()
        self.initControls()
    }
    
    func initControls() {
        
        //定位按钮
        locationButton = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        
        locationButton?.frame = CGRectMake(20, mapView!.bounds.height - 80, 28, 28)
        locationButton?.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin
        locationButton?.backgroundColor = UIColor.whiteColor()
        locationButton?.layer.cornerRadius = 5
        locationButton?.setImage(UIImage(named: "location_no"), forState: UIControlState.Normal)
        
        locationButton?.addTarget(self, action: Selector("locateAction"), forControlEvents: UIControlEvents.TouchUpInside)
        
        mapView?.addSubview(locationButton!)
        
        //放大按钮
        zoomButtonIn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        
        zoomButtonIn?.frame = CGRectMake(mapView!.bounds.width - 50, mapView!.bounds.height - 94, 28, 28)
        zoomButtonIn?.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin
        zoomButtonIn?.backgroundColor = UIColor.whiteColor()
        zoomButtonIn?.layer.cornerRadius = 5
        zoomButtonIn?.setImage(UIImage(named: "plus-128"), forState: UIControlState.Normal)
        
        zoomButtonIn?.addTarget(self, action: Selector("buttonHandlePinchIn"), forControlEvents: UIControlEvents.TouchUpInside)
        
        mapView?.addSubview(zoomButtonIn!)
        
        //缩小按钮
        zoomButtonOut = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        
        zoomButtonOut?.frame = CGRectMake(mapView!.bounds.width - 50, mapView!.bounds.height - 66, 28, 28)
        zoomButtonOut?.autoresizingMask = UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin
        zoomButtonOut?.backgroundColor = UIColor.whiteColor()
        zoomButtonOut?.layer.cornerRadius = 5
        zoomButtonOut?.setImage(UIImage(named: "minus-128"), forState: UIControlState.Normal)
        
        zoomButtonOut?.addTarget(self, action: Selector("buttonHandlePinchOut"), forControlEvents: UIControlEvents.TouchUpInside)
        
        mapView?.addSubview(zoomButtonOut!)
    }
    
    func locateAction() {
        println("点击事件成功发生")
        
        if mapView?.userTrackingMode != MAUserTrackingMode.Follow {
            mapView?.setUserTrackingMode(MAUserTrackingMode.Follow, animated: true)
            println("改变模式成功")
        }
        
    }
    
    func mapView(mapView: MAMapView!, didChangeUserTrackingMode mode: MAUserTrackingMode, animated: Bool) {
        if mode == MAUserTrackingMode.None {
            locationButton?.setImage(UIImage(named: "location_no"), forState: UIControlState.Normal)
            println("改变图片为no")
        } else {
            locationButton?.setImage(UIImage(named: "location_yes"), forState: UIControlState.Normal)
            println("改变图片为yes")
        }
    }
    
    func initMapView() {
        
        //mapView初始化设置
        mapView = MAMapView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        
        //接受委托
        mapView?.delegate = self
        
        //mapView界面参数设置
        mapView?.compassOrigin = CGPointMake(mapView!.compassOrigin.x, 22)
        mapView?.scaleOrigin = CGPointMake(mapView!.scaleOrigin.x, 22)
        
//        //mapView手势识别
//        currentPinch = UIPinchGestureRecognizer(target: self, action: Selector("handlePinch"))
//        currentPinch?.delegate = self
//        mapView?.addGestureRecognizer(currentPinch!)

        self.view.addSubview(mapView!)
        
        //定位功能打开
        mapView?.showsUserLocation = true
        
        
    }
    
//    func handlePinch() {
//        println("缩放手势识别")
//        mapView!.zoomLevel = mapView!.zoomLevel * Double(currentPinch!.scale)
//    }
    
    func buttonHandlePinchOut() {
        mapView!.zoomLevel = mapView!.zoomLevel * 0.9
    }
    
    func buttonHandlePinchIn() {
        mapView!.zoomLevel = mapView!.zoomLevel * 1.1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

