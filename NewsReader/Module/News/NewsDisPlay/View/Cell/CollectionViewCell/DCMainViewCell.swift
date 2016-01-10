//
//  DCMainViewCell.swift
//  NewsReader
//
//  Created by dengchen on 16/1/3.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit
import SnapKit

class DCMainViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    
    

    internal var urlString:String?
    {
        didSet{
            self.loadView?.hidden = false
            
            DCTouTiaoViewModel.shareModel.loadTouTiaoData(false,urlString: urlString!, parameters: urlString?.parseURLQueryString()) { (data, error) -> Void in
                
                guard error == nil else {
                    print(error)
                    return
                }
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.DisplayPicInfos = data.DisplayPicInfo
                    self.touTiaos = data.TouTiao
                }
            }
        }
    }
    
    
    
    private let InfoCellReuseIdentifier =  "InfoCell"
    private let PicCellReuseIdentifier  =  "PicCell"
    private let OnePicCellReuseIdentifier = "OnePicCell"
    
    private let headViewHieght:CGFloat = 150
    
    private var DisplayPicInfos:[DCDisplayPicInfo]?
    {
        didSet{
            
            guard self.DisplayPicInfos?.count > 0 else {
                tableView?.tableHeaderView?.hidden = true
                tableView?.tableHeaderView?.frame = CGRectZero
                return
            }
            
            setPicScrollView()
        }
    }
    
    private var touTiaos:[DCTouTiao]?
        {
        didSet{
                self.tableView!.reloadData()
                self.loadView?.hidden = true
        }
    }

    @objc private func reloadTouTiaoData() {
        
        
        DCTouTiaoViewModel.shareModel.loadTouTiaoData(true,urlString: urlString!, parameters: urlString?.parseURLQueryString()) { (data, error) -> Void in
            
            guard error == nil else {
                print(error)
                return
            }
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.DisplayPicInfos = data.DisplayPicInfo
                self.touTiaos = data.TouTiao
            }
        }
        
    }
    
    
    private weak var tableView:UITableView!{
        didSet {
            
        }
    }
    private weak var loadView:UIView!
    
   
    
    private func setUpTabelView() {
        
        let tb = UITableView(frame: contentView.bounds, style: .Plain)
        tableView = tb
        
        contentView.addSubview(tableView!)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        
        

       contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
       }
   
        tableView.snp_makeConstraints(closure: { (make) -> Void in
            make.edges.equalTo(contentView)
        })
        
        
    }

    private func setUpLoadView() {
        
        let loadView = UIView()
        loadView.backgroundColor = UIColor.whiteColor()
        let imageView = UIImageView(image: UIImage(named: "contentview_loading_background"))
        loadView.addSubview(imageView)
        
        imageView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(loadView)
        }
        
        self.addSubview(loadView)
        self.loadView = loadView
        
        
        self.loadView?.snp_makeConstraints(closure: { (make) -> Void in
            make.edges.equalTo(contentView)
        })
    }
    
    
    private func setPicScrollView() {

        var titleArr = [String]()
        var imageUrlArr = [String]()
        
        for info in self.DisplayPicInfos!
        {
            titleArr.append(info.title ?? "")
            imageUrlArr.append(info.imgsrc!)
        }
        
        
        let pic = DCPicScrollView(frame: CGRectMake(0,0,ScreenWidth,headViewHieght), withImageUrls: imageUrlArr)
        
        pic.titleData = titleArr
        pic.AutoScrollDelay = 0
        pic.placeImage = placeImage
        
        tableView!.tableHeaderView = pic
        
    }
    private func setUpUI() {
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        
        setUpTabelView()
        setUpLoadView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: UITableViewDelegate

extension DCMainViewCell{
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let docid = touTiaos?[indexPath.row].docid{
            let ndVc =  DCNewDetailsController()
            ndVc.docid = docid
            self.NavController?.pushViewController(ndVc, animated: true)
        }
        
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.touTiaos != nil ? self.touTiaos!.count : 0
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        
        let md = self.touTiaos![indexPath.row]
        
        if md.imgextra?.count > 0 {
            
            var picCell = tableView.dequeueReusableCellWithIdentifier(PicCellReuseIdentifier) as? DCPicCell
            
            if picCell == nil {
                picCell = DCPicCell(style: UITableViewCellStyle.Default, reuseIdentifier: PicCellReuseIdentifier)
            }
            picCell?.model = md
            
            return picCell!
            
        }else{
            
            if md.imgType == true {
                
            var OnePicCell = tableView.dequeueReusableCellWithIdentifier(OnePicCellReuseIdentifier) as? DCOnePicCell
            if OnePicCell == nil {
                    OnePicCell = DCOnePicCell(style: UITableViewCellStyle.Default, reuseIdentifier: InfoCellReuseIdentifier)
                }
                
            OnePicCell?.touTiao = md
                
                return OnePicCell!
                
            }else {
                
                var InfoCell = tableView.dequeueReusableCellWithIdentifier(InfoCellReuseIdentifier) as? DCInfoCell
                if InfoCell == nil {
                    InfoCell = DCInfoCell(style: UITableViewCellStyle.Default, reuseIdentifier: InfoCellReuseIdentifier)
                }
                
                InfoCell?.touTiao = md
                
                return InfoCell!
            }
            
        }
        
        
    }
    
    

}
