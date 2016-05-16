//
//  JYBaseTableViewController.h
//  JYTableViewController
//
//  Created by Gary on 16/5/16.
//  Copyright © 2016年 JY. All rights reserved.
//

/*
 结合Post Filter 和 MJ 的刷新控件
 使用的时候需要重写没有在基类实现的方法
 
 Post Filter 需要自己手动和本基类结合
 
 因为不能确定数据源的类型（NSDictionary 或者 NSArray 或者其他）所以不约定赋值方法，不过框架结构还要做，和使用.
 */


#import <UIKit/UIKit.h>

@interface JYBaseTableViewController : UITableViewController

//data
-(void)setjyDataSource:(id)pdataSource; // 基类不做实现，用来提醒是否实现
-(id)getjyDataSource; // 基类不做实现，用来提醒是否实现
//post data
-(void)postNetData;
-(void)postMoreData;
//action
-(void)stopHeaderRush;
-(void)stopFooterRush;
-(void)nomoreData;
-(void)moreData;
-(void)configerRefresh;

//delgate
-(id) getjyDelegate;

@end
