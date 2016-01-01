//
//  DCBaseController.swift
//  NewsReader
//
//  Created by dengchen on 15/12/16.
//  Copyright © 2015年 name. All rights reserved.
//

import UIKit



class DCBaseController: UITableViewController {

    private let CellReuseIdentifier =  "DCBaseCell"

    internal var DisplayPicInfos:[DCDisplayPicInfo]?
    {
        didSet {
            setPicScrollView()
        }
    }
    
    internal var touTiaos:[DCTouTiao]?
    {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.registerClass(DCBaseCell.self, forCellReuseIdentifier:CellReuseIdentifier)

        DCMyDataManager.loadTouTiaoData { (data:([DCDisplayPicInfo],[DCTouTiao])) -> Void in
            
            self.DisplayPicInfos = data.0
            self.touTiaos = data.1
            
        }
    

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
        pic.AutoScrollDelay = 2.0
        pic.textColor = UIColor.redColor()
        
        tableView.tableHeaderView = pic
        
    }

}
//MARK: UITableViewDelegate

 extension DCBaseController {
    
    
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     {
        return self.touTiaos != nil ? self.touTiaos!.count : 0
     }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
     {
       let cell = tableView.dequeueReusableCellWithIdentifier(CellReuseIdentifier) as! DCBaseCell
      
        let md = self.touTiaos![indexPath.row]
        
        cell.touTiao = md
        
        return cell
     }
    

}
