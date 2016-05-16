//
//  JYBaseTableViewController.m
//  JYTableViewController
//
//  Created by Gary on 16/5/16.
//  Copyright © 2016年 JY. All rights reserved.
//

#import "JYBaseTableViewController.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"

#import "JYTableViewDelegate.h"

@interface JYBaseTableViewController ()

@property (nonatomic, strong) JYTableViewDelegate *tableDelegate;
@end

@implementation JYBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configerTableViewDelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - configer
-(void) configerTableViewDelegate{
    self.tableDelegate = [self getjyDelegate];
}

-(void) configerRefresh{
    MJRefreshNormalHeader *mjheader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postNetData];
    }];
    
    MJRefreshAutoNormalFooter *mjfooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self postMoreData];
    }];
    
    self.tableView.mj_header = mjheader;
    self.tableView.mj_footer = mjfooter;
}

#pragma mark - post data
-(void)postNetData{
    
}
-(void)postMoreData{
    
}

#pragma mark - action
-(void)stopHeaderRush{
    [self.tableView.mj_header endRefreshing];
}
-(void)stopFooterRush{
    [self.tableView.mj_footer endRefreshing];
}
-(void)nomoreData{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
-(void)moreData{
    [self.tableView.mj_footer resetNoMoreData];
}

#pragma mark - delegate
//注意，不能使用super
-(id) getjyDelegate{
    return nil;
};

@end
