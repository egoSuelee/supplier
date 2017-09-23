//
//  MyOwnBidVC.swift
//  HLScs
//
//  Created by @xwy_brh on 2017/4/14.
//  Copyright © 2017年 @egosuelee. All rights reserved.
//

import UIKit
import Then

class MyOwnBidVC: BaseVC {

    //日期控件视图
    lazy var datePickerBtn:DatePickerBtn = {[weak self] in
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: 50)
        let dateView = DatePickerBtn.init(frame: rect)
        dateView.setBtnTitle(startDate: NSDate.getPreviousDay()!, endDate: NSDate.getToday()!)
        return dateView
    }()

    //分页导航pageTitleView
    lazy var bidPageTitleView:PageTitleView = {[weak self] in
        let rect = CGRect(x: 0, y: 50, width: kScreenW, height: 50)
        let pagetitleView = PageTitleView.init(frame: rect, titles: ["未提交", "已提交"])
        pagetitleView.delegate = self
        return pagetitleView
        }()
    //Mark: --- 分页导航内容控制器视图
    lazy var bidPageContentView:PageContentView = {[weak self] in
        let contentFrame = CGRect(x: 0, y:  100 + 0.5, width: kScreenW, height: kScreenH - kNavigationBarH - kStatusBarH - 100)
        var childVcs = [UIViewController]()
        childVcs.append(DisCommitOwnBidVC())
        childVcs.append(HadCommitOwnBidVC())
    
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        //MARK:- 控制器作为PageContentViewDelegate代理
        contentView.delegate = self
        return contentView
        }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的竞价单"
        showNavBackBtn()
        setupUI()
    }
    
    func setupUI() {
        self.view.addSubview(datePickerBtn)
        self.view.addSubview(bidPageTitleView)
        self.view.addSubview(bidPageContentView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension MyOwnBidVC:PageTitleViewDelegate {
    
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        bidPageContentView.setCurrentIndex(currentIndex: index)
    }
}

extension MyOwnBidVC:PageContentViewDelegate {
    
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        bidPageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func pageContentView(index: Int, vc: UIViewController) -> UITableView? {
        
        switch index {
        case 0:
            let vc1 = vc as! DisCommitOwnBidVC
            return vc1.discmtTV
        case 1:
            let vc1 = vc as! HadCommitOwnBidVC
            return vc1.hadCmtTV
        default:
            return nil
        }
    }
}