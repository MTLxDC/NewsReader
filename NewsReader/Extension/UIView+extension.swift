//
//  UIView+extension.swift
//  NewsReader
//
//  Created by dengchen on 16/1/10.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit

extension UIView {

    internal var NavController:UINavigationController? {
        get {
           var next = self.nextResponder()
            
            while next != nil {
                
                if next?.isKindOfClass(UINavigationController.self) == true {
                    return next as? UINavigationController
                }
                
                next = next?.nextResponder()
            }
            
            return nil
        }
    }
    
   internal var navHeight:CGFloat!
        {
        get {
            let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
            
            return statusBarHeight + (self.NavController?.navigationBar.bounds.height ?? 0)
        }
    }
    
}


