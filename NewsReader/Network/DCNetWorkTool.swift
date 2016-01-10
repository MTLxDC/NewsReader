//
//  DCNetWorkTool.swift
//  NewsReader
//
//  Created by dengchen on 15/12/30.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit
import AFNetworking

public enum requestMethod {
    case POST
    case GET
}

public class DCNetWorkTool:AFHTTPSessionManager  {
    
    static let shareTool = DCNetWorkTool()
    
    init () {
        super.init(baseURL: nil, sessionConfiguration: nil)
        self.responseSerializer.acceptableContentTypes?.insert("text/html")
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 public func httpRequest(method:requestMethod,URLString: String, parameters: AnyObject?,success:((res:AnyObject?) -> Void)?,failure: ((error:NSError) -> Void)?) {
        
        if method == requestMethod.GET {
            
            GET(URLString, parameters: parameters, progress: nil, success: { (_, res:AnyObject?) -> Void in
                
                if success != nil {
                    success!(res: res)
                }
                
                }) { (_, error:NSError) -> Void in
                    
                if failure != nil {
                    failure!(error: error)
                }
            }
            
        }else if method == requestMethod.POST {
            
            POST(URLString, parameters: parameters, progress: nil, success: { (_, res:AnyObject?) -> Void in
                
                if success != nil {
                    success!(res: res)
                }
                
                }) { (_, error:NSError) -> Void in
                    
                if failure != nil {
                    failure!(error: error)
                }
            }
            
        }
       
    }
 
}
