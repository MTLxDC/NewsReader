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
            DCTouTiaoViewModel.shareModel.loadTouTiaoData(urlString!, parameters: urlString?.parseURLQueryString()) { (data, error) -> Void in
                
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
    
    private var DisplayPicInfos:[DCDisplayPicInfo]?
        {
        didSet{
            guard self.DisplayPicInfos!.count > 1 else {
                tableView?.tableHeaderView?.hidden = true
                tableView?.tableHeaderView?.frame = CGRectZero
                return
            }
            tableView?.tableHeaderView?.hidden = false
            setPicScrollView()
        }
    }
    
    private var touTiaos:[DCTouTiao]?
        {
        didSet{
                self.tableView!.reloadData()
        }
    }
    

    
   
  override init(frame: CGRect) {
        super.init(frame: CGRectZero)
        setUpUI()
    }
  

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
    
        setUpTabelView()
        
    }
    
    
    private weak var tableView:UITableView?
    
    private func setUpTabelView() {
        
        let tb = UITableView(frame: contentView.bounds, style: .Plain)
        tableView = tb
        
        guard tableView != nil else {
            return
        }
        contentView.addSubview(tableView!)
        tableView!.estimatedRowHeight = 80
        tableView!.rowHeight = UITableViewAutomaticDimension
        tableView!.dataSource = self
        tableView!.delegate = self
        
       contentView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
       }
        
        tableView?.snp_makeConstraints(closure: { (make) -> Void in
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
        
        
        let pic = DCPicScrollView(frame: CGRectMake(0,64,ScreenWidth, 200), withImageUrls: imageUrlArr)
        
        pic.titleData = titleArr
        pic.AutoScrollDelay = 0
        
        tableView!.tableHeaderView = pic
        
    }
    
}
//MARK: UITableViewDelegate

extension DCMainViewCell{
   
   
    
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
