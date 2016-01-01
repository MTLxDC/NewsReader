//
//  UILabel+extension.swift
//  NewsReader
//
//  Created by dengchen on 16/1/1.
//  Copyright © 2016年 name. All rights reserved.
//

import Foundation

public extension UILabel {
    
    convenience init(text:String?,font:UIFont,textColor:UIColor?,Alignment:NSTextAlignment = .Left) {
        self.init()

        self.numberOfLines = 0
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = Alignment
    }
    
}