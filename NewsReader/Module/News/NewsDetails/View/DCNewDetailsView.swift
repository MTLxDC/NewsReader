//
//  DCNewDetailsController.swift
//  NewsReader
//
//  Created by dengchen on 16/1/10.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit

class DCNewDetailsController: UIViewController {

    internal var docid:String! {
        didSet {
            DCNewDetailViewModel.shareModel.loadNewDetailModel(docid) { (md:DCDetailModel) -> Void in
                self.model = md
            }
        }
    }
    
    private var model:DCDetailModel! {
        didSet {
            loadHtml()
        }
    }
    
    private func loadHtml() {
        
        let css = "file//" + NSBundle.mainBundle().pathForResource("content.css", ofType: nil)!
        
        let formatStr = "<html><head><link rel=\"stylesheet\" href=\"%@\"></head><body>%@</body></html>"
        
        let html = String(format: formatStr,css,pieceBody())

        self.webView.loadHTMLString(html, baseURL: nil)
    }
    
    
    private func pieceBody()->String {
        
        var body = String()
        
        body.appendContentsOf("<div class=\"title\">\(self.model.title!)</div>")
        body.appendContentsOf("<div class=\"time\">\(self.model.ptime!)</div>")
        if self.model.body != nil {
            body.appendContentsOf(self.model.body!)
        }
        
        if self.model.img?.count > 0  {
            
            //遍历图片模型
            for imgMd in self.model.img! {
                //设置图片的div
                var imageHtml = "<div class=\"img-parent\">"
                
                //分割像素字符串,取出其中的宽和高
                let pixel = imgMd.pixel?.componentsSeparatedByString("*")
                
                var w = pixel?.first!.floatValue
                var h = pixel?.last!.floatValue
                
                //判断是否超过屏幕宽度
                let maxW = Float(ScreenWidth * 0.96)
                
                if maxW < w {
                    let scale = maxW / w!
                    w = maxW
                    h = scale * h!
                }
                
                let onload = "this.onclick = function() {window.location.href = 'sx:src=' +this.src;}"
                
                if w == nil || h == nil {
                    w = 0
                    h = 0
                }
                let content = String(format:"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,w!,h!,imgMd.src!)
                
                imageHtml.appendContentsOf(content)
                imageHtml.appendContentsOf("</div>")
                
              body = body.stringByReplacingOccurrencesOfString(imgMd.ref!, withString:imageHtml, options:[.CaseInsensitiveSearch], range:Range(start: body.startIndex,end: body.endIndex))
            }
        
        }
        
            return body
    }
    
    private weak var webView:UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpWebView()
        
    }
    
    private func setUpUI() {
        view.backgroundColor = UIColor.whiteColor()
    }

    private func setUpWebView() {
        let wb = UIWebView()
        webView = wb
        
        view.addSubview(webView)
        webView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
    }

}
