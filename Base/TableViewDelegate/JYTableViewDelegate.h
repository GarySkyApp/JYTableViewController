//
//  JYTableViewDelegate.h
//  JYTableViewController
//
//  Created by Gary on 16/5/6.
//  Copyright © 2016年 Gary. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  
 
 1、在使用FDT的时候，会导致时序不同。 描述：（猜测）可能是使用的runtime拦截了，在使用_cellBlock（）时，并且通过_cellBlock的模块中初始化Cell，使用的是 dequeueReusableCellWithIdentifier ，会导致不往下执行，而是跳转到了获取cell高度的位置
 2、会导致时序不同的还有 tableView.estimatedRowHeight 估算高度。描述：这个是减少计算量，顺带少了先计算高度。
 
 *
 */


/*
        Default
 */

/*      dataSource      */
typedef NSArray *(^dataSourceBlock)();
typedef NSInteger (^numberOfSectionsBlock)(UITableView *tableView);
typedef NSInteger (^numberOfRowsInSectionBlock)(UITableView *tableView, NSInteger section);
typedef void (^registerCellBlock)(UITableView *tableView);
typedef UITableViewCell *(^cellForRowBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef UIView *(^viewForHeaderBlock)(UITableView *tableView, NSInteger section);
typedef UIView *(^viewForFooterBlock)(UITableView *tableView, NSInteger section);

typedef CGFloat (^heightForRowBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat (^heightForHeaderBlock)(UITableView *tableView, NSInteger section);
typedef CGFloat (^heightForFooterBlock)(UITableView *tableView, NSInteger section);

/*      delegate        */
typedef void (^didSelectRowBlock)(UITableView *tableView, NSIndexPath *indexPath);


/*
        Default + UITableView+FDTemplateLayoutCell
 */
typedef NSString *(^heightForRowWithFDTemplateLayoutCellBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef BOOL (^heightForRowAutoLayoutBlock)(UITableView *tableView, NSIndexPath *indexPath);


typedef void (^emptyTouchBlock)();


@interface JYTableViewDelegate : NSObject

/*
        Default
 */
-(id) initWithDataSourceBlock:(dataSourceBlock) pdataSourceBlock
        numberOfSectionsBlock:(numberOfSectionsBlock) pnumberOfSectionsBlock
   numberOfRowsInSectionBlock:(numberOfRowsInSectionBlock) pnumberOfRowsInSectionBlock
            registerCellBlock:(registerCellBlock) pregisterCellBlock
              cellForRowBlock:(cellForRowBlock) pcellForRowBlock
           viewForHeaderBlock:(viewForHeaderBlock) pviewForHeaderBlock
           viewForFooterBlock:(viewForFooterBlock) pviewForFooterBlock
            heightForRowBlock:(heightForRowBlock) pheightForRowBlock
         heightForHeaderBlock:(heightForHeaderBlock) pheightForHeaderBlock
         heightForFooterBlock:(heightForFooterBlock) pheightForFooterBlock
            didSelectRowBlock:(didSelectRowBlock) pdidSelectRowBlock
           andEmptyTouchBlock:(emptyTouchBlock) pemptyTouchBlock
                  andDelegate:(UITableView *) ptableView;


/*
    Default + UITableView+FDTemplateLayoutCell
 */
-(id) initWithDataSourceBlock:(dataSourceBlock) pdataSourceBlock
        numberOfSectionsBlock:(numberOfSectionsBlock) pnumberOfSectionsBlock
   numberOfRowsInSectionBlock:(numberOfRowsInSectionBlock) pnumberOfRowsInSectionBlock
            registerCellBlock:(registerCellBlock) pregisterCellBlock
              cellForRowBlock:(cellForRowBlock) pcellForRowBlock
           viewForHeaderBlock:(viewForHeaderBlock) pviewForHeaderBlock
           viewForFooterBlock:(viewForFooterBlock) pviewForFooterBlock
            heightForRowWithFDTemplateLayoutCellBlock:(heightForRowWithFDTemplateLayoutCellBlock) pheightForRowWithFDTemplateLayoutCellBlock
  heightForRowAutoLayoutBlock:(heightForRowAutoLayoutBlock) pheightForRowAutoLayoutBlock
         heightForHeaderBlock:(heightForHeaderBlock) pheightForHeaderBlock
         heightForFooterBlock:(heightForFooterBlock) pheightForFooterBlock
            didSelectRowBlock:(didSelectRowBlock) pdidSelectRowBlock
           andEmptyTouchBlock:(emptyTouchBlock) pemptyTouchBlock
                  andDelegate:(UITableView *) ptableView;

@end
