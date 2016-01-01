//
//  String+extension.swift
//  NewsReader
//
//  Created by dengchen on 15/12/30.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit

public extension String {
    
   public func parseURLQueryString() ->[String:AnyObject]{
        
        var dict = [String:AnyObject]()
        
        let pairs = self.componentsSeparatedByString("&")
        
        for pair in pairs {
            let keyValue = pair.componentsSeparatedByString("=")
            
            if keyValue.count == 2 {
                let key = keyValue[0]
                let value:String = keyValue[1].stringByRemovingPercentEncoding!
                
                if key.characters.count > 0 && value.characters.count > 0 {
                    dict[key] = value
                }
            }
        }
        
        return dict
    }
    
}