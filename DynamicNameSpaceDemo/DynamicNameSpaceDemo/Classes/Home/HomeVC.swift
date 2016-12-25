//
//  HomeVC.swift
//  DynamicNameSpaceDemo
//
//  Created by 也许、 on 16/8/23.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let btnW = UIScreen.main.bounds.width - 20
        let btn = UIButton(frame: CGRect(x: 10, y: 100, width: btnW, height: 30))
        btn.backgroundColor = UIColor.gray
        btn.setTitle("点击我,观察切换底部tabBar", for: .normal)
        btn.addTarget(self, action: #selector(self.changeTabBar), for: .touchUpInside)
        self.view.addSubview(btn)
        
    }
    
    // 切换tabBar
    func changeTabBar() {
        
        let isChange = UserDefaults.standard.bool(forKey: "changeTabBar")
        UserDefaults.standard.set(!isChange, forKey: "changeTabBar")
        
        UIApplication.shared.windows.last?.rootViewController = MainTabBarController()
        
    }

}
