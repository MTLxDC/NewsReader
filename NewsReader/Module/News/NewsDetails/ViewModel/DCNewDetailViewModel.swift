//
//  DCNewDetailViewModel.swift
//  NewsReader
//
//  Created by dengchen on 16/1/10.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit
import SwiftyJSON

private let tool = DCNetWorkTool.shareTool

class DCNewDetailViewModel  {
    
    static let shareModel = DCNewDetailViewModel()
    
    private var newDetailModelCache = [String:DCDetailModel]()
    
    private  let newDetailPath = NSStringFromClass(DCDetailModel).path(NSSearchPathDirectory.CachesDirectory)
    
    func saveModelCache() {
        if newDetailModelCache.count > 0  {
            NSKeyedArchiver.archiveRootObject(newDetailModelCache, toFile: newDetailPath)
        }
    }
    
    func getModelCache() {
        
        if let dm = NSKeyedUnarchiver.unarchiveObjectWithFile(newDetailPath) as? [String :DCDetailModel]{
            newDetailModelCache = dm
        }
        
    }
    
    func loadNewDetailModel(docid:String,complish:(DCDetailModel)->Void) {
        
        if let cacheMd = newDetailModelCache[docid] {
            complish(cacheMd)
            return
        }
        
        let urlString = "http://c.m.163.com/nc/article/\(docid)/full.html"
        
       tool.httpRequest(.GET, URLString:urlString, parameters: nil, success: { (res) -> Void in
        
        guard res != nil else { return }
        
        let json = JSON(res!)
        print(json.dictionaryObject)
        if let dict = json[docid].dictionaryObject {
            
            let detailModel = DCDetailModel(dict: dict)
            self.newDetailModelCache[docid] = detailModel
            complish(detailModel)
        }
        
        
        }) { (error) -> Void in
            
        }
    }
    
}
