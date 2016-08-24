//
//  MainTabBarController.swift
//  DynamicNameSpaceDemo
//
//  Created by 也许、 on 16/8/23.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let isChange = UserDefaults.standard.bool(forKey: "changeTabBar")
        
        if !isChange {
            self.tabBar.tintColor = UIColor.orange
            setupChildrenController(childController: HomeVC(), title: "首页", icon: "tabbar_home")
            setupChildrenController(childController: MessageVC(), title: "消息", icon: "tabbar_message_center")
            setupChildrenController(childController: DiscoverVC(), title: "广场", icon: "tabbar_discover")
            setupChildrenController(childController: MeVC(), title: "我", icon: "tabbar_profile")
            
        } else {
            
            self.tabBar.tintColor = UIColor.black
            let path = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil)
            let array = try! JSONSerialization.jsonObject(with: NSData(contentsOfFile: path!) as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
         
            for obj in array {
               
                let dic = obj as! NSDictionary
                let className = dic["vcName"] as! String
                let title = dic["title"] as! String
                let icon = dic["imageName"] as! String
                setupChildrenController(className: className, title: title, icon: icon)
                
            }
            
        }
        
    }
    
    // 默认的添加子控制器
    func setupChildrenController(childController:UIViewController, title:String, icon:String) {
    
        childController.title = title
        childController.tabBarItem.image = UIImage(named: icon)
        childController.tabBarItem.selectedImage = UIImage(named: String(format: "%@_highlighted", icon))
        self.addChildViewController(UINavigationController(rootViewController: childController))
    
    }
    
    // 添加动态加载的控制器
    func setupChildrenController(className:String, title:String , icon:String) {
        
        // 动态获取命名空间
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        
        // 控制器类与命名空间具有关联关系，名称完成才能够正确的初始化控制器
        let vcClass = NSClassFromString(String(format: "%@.%@", nameSpace, className))! as! UIViewController.Type
        let childrenController = vcClass.init()
        childrenController.title = title
        childrenController.tabBarItem.image = UIImage(named: icon)?.withRenderingMode(.alwaysOriginal)
        childrenController.tabBarItem.selectedImage = UIImage(named: String(format: "%@_click_icon", icon))?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(UINavigationController(rootViewController: childrenController))
    
    }



}
