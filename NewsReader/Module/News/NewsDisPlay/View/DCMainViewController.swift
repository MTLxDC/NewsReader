//
//  DCMainViewController.swift
//  NewsReader
//
//  Created by dengchen on 16/1/3.
//  Copyright © 2016年 name. All rights reserved.
//

import UIKit

class DCMainViewController: UICollectionViewController {
    

    init () {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - navHeight)
        layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        super.init(collectionViewLayout: layout)
        self.extendedLayoutIncludesOpaqueBars = false
        self.edgesForExtendedLayout = [.Bottom,.Left,.Right]
        setUpUI()
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {

        collectionView?.pagingEnabled = true
        collectionView?.backgroundColor = UIColor.lightGrayColor()
        collectionView?.registerClass(DCMainViewCell.self, forCellWithReuseIdentifier: MainCellReuseIdentifier)
    }
    
//    头条:http://c.3g.163.com/nc/article/headline/T1348647853363/0-20.html
//    娱乐:http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html
//    热点:http://c.3g.163.com/recommend/getSubDocPic
//    体育:http://c.3g.163.com/nc/article/list/T1348649079062/0-20.html
    //    本地:http://c.3g.163.com/nc/article/local/5YyX5Lqs/0-20.html军事:http://c.3g.163.com/nc/article/list/T1348648141035/0-20.html
//    历史:http://c.3g.163.com/nc/article/list/T1368497029546/0-20.html
//    家居:http://c.3g.163.com/nc/article/list/T1348654105308/0-20.html
//    原创:http://c.3g.163.com/nc/article/list/T1370583240249/0-20.html
//    游戏:http://c.3g.163.com/nc/article/list/T1348654151579/0-20.html
//    健康:http://c.3g.163.com/nc/article/list/T1414389941036/0-20.html
//    政务:http://c.3g.163.com/nc/article/list/T1414142214384/0-20.html
//    漫画:http://c.3g.163.com/nc/article/list/T1444270454635/0-20.html
//    哒哒:http://c.3g.163.com/nc/article/list/T1444289532601/0-20.html
//    彩票:http://c.3g.163.com/nc/article/list/T1356600029035/0-20.html
    
    private let NewsUrlArray:[String] =
    ["http://c.3g.163.com/nc/article/headline/T1348647853363/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1348649079062/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1368497029546/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1348654105308/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1370583240249/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1348654151579/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1414389941036/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1414142214384/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1414142214384/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1444270454635/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1444289532601/0-20.html",
    "http://c.3g.163.com/nc/article/list/T1356600029035/0-20.html",]
    
    private let MainCellReuseIdentifier = "MainCell"
    
}


//MARK:UICollectionViewDataSource

extension DCMainViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.NewsUrlArray.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MainCellReuseIdentifier, forIndexPath: indexPath) as? DCMainViewCell
    
        cell?.urlString = self.NewsUrlArray[indexPath.row]
    
        
        return cell!
    }
    
}
