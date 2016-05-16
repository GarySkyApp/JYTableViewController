//
//  JYTableViewDelegate.m
//  JYTableViewController
//
//  Created by Gary on 16/5/6.
//  Copyright © 2016年 Gary. All rights reserved.
//

#import "JYTableViewDelegate.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface JYTableViewDelegate ()<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic, copy) dataSourceBlock dataBlock;
@property(nonatomic, copy) numberOfSectionsBlock sectionsBlock;
@property(nonatomic, copy) numberOfRowsInSectionBlock rowsBlock;
@property(nonatomic, copy) registerCellBlock registerBlock;
@property(nonatomic, copy) cellForRowBlock cellBlock;
@property(nonatomic, copy) viewForHeaderBlock headerViewBlok;
@property(nonatomic, copy) viewForFooterBlock footerViewBlock;

@property(nonatomic, copy) heightForRowBlock cellHeightBlock;
@property(nonatomic, copy) heightForRowWithFDTemplateLayoutCellBlock cellHeightWithFDTBlock;
@property(nonatomic, copy) heightForRowAutoLayoutBlock autoLayoutBlock;
@property(nonatomic, copy) heightForHeaderBlock headerHeightBlock;
@property(nonatomic, copy) heightForFooterBlock footerHeightBlock;

@property(nonatomic, copy) didSelectRowBlock selectBlcok;
@property(nonatomic, copy) emptyTouchBlock emptyActionBlock;

@end

@implementation JYTableViewDelegate

#pragma mark - 初始化

-(id)initWithDataSourceBlock:(dataSourceBlock)pdataSourceBlock
       numberOfSectionsBlock:(numberOfSectionsBlock)pnumberOfSectionsBlock
  numberOfRowsInSectionBlock:(numberOfRowsInSectionBlock)pnumberOfRowsInSectionBlock
           registerCellBlock:(registerCellBlock)pregisterCellBlock
             cellForRowBlock:(cellForRowBlock)pcellForRowBlock
          viewForHeaderBlock:(viewForHeaderBlock)pviewForHeaderBlock
          viewForFooterBlock:(viewForFooterBlock)pviewForFooterBlock
           heightForRowBlock:(heightForRowBlock)pheightForRowBlock
        heightForHeaderBlock:(heightForHeaderBlock)pheightForHeaderBlock
        heightForFooterBlock:(heightForFooterBlock)pheightForFooterBlock
           didSelectRowBlock:(didSelectRowBlock)pdidSelectRowBlock
          andEmptyTouchBlock:(emptyTouchBlock)pemptyTouchBlock
                 andDelegate:(UITableView *)ptableView{

    self = [super init];
    if (self) {
        _dataBlock = pdataSourceBlock;
        _sectionsBlock = pnumberOfSectionsBlock;
        _rowsBlock = pnumberOfRowsInSectionBlock;
        _registerBlock = pregisterCellBlock;
        _cellBlock = pcellForRowBlock;
        _headerViewBlok = pviewForHeaderBlock;
        _footerViewBlock = pviewForFooterBlock;
        _cellHeightBlock = pheightForRowBlock;
        _headerHeightBlock = pheightForHeaderBlock;
        _footerHeightBlock = pheightForFooterBlock;
        _selectBlcok = pdidSelectRowBlock;
        _emptyActionBlock = pemptyTouchBlock;
        
        [self configerTableView:ptableView];
    }
    return self;
}


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
                  andDelegate:(UITableView *) ptableView{

    self = [super init];
    if (self) {
        _dataBlock = pdataSourceBlock;
        _sectionsBlock = pnumberOfSectionsBlock;
        _rowsBlock = pnumberOfRowsInSectionBlock;
        _registerBlock = pregisterCellBlock;
        _cellBlock = pcellForRowBlock;
        _headerViewBlok = pviewForHeaderBlock;
        _footerViewBlock = pviewForFooterBlock;
        _cellHeightWithFDTBlock = pheightForRowWithFDTemplateLayoutCellBlock;
        _autoLayoutBlock = pheightForRowAutoLayoutBlock;
        _headerHeightBlock = pheightForHeaderBlock;
        _footerHeightBlock = pheightForFooterBlock;
        _selectBlcok = pdidSelectRowBlock;
        _emptyActionBlock = pemptyTouchBlock;
        
        [self configerTableView:ptableView];
    }
    return self;

}


-(void)configerTableView:(UITableView *)tableView{
    _registerBlock(tableView);
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.delegate = self;
    tableView.dataSource = self;
}


#pragma  makr - UITableView delegate and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_sectionsBlock) {
        return _sectionsBlock(tableView);
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_rowsBlock) {
        return _rowsBlock(tableView, section);
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = _cellBlock(tableView, indexPath);
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_headerViewBlok) {
       return _headerViewBlok(tableView, section);
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_footerViewBlock) {
        return _footerViewBlock(tableView, section);
    }
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellHeightBlock) {
        return _cellHeightBlock(tableView, indexPath);
    }else if(_cellHeightWithFDTBlock) {
        return [tableView fd_heightForCellWithIdentifier:_cellHeightWithFDTBlock(tableView, indexPath) configuration:^(id cell) {
            if (_autoLayoutBlock != nil) {
                BOOL state = _autoLayoutBlock(tableView, indexPath);
                UITableViewCell *tcell = cell;
                tcell.fd_enforceFrameLayout = !state;
            }
            
        }];
    }
    return 0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_headerHeightBlock) {
        return _headerHeightBlock(tableView, section);
    }
    return 0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_footerHeightBlock) {
        return _footerHeightBlock(tableView, section);
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectBlcok) {
        _selectBlcok(tableView, indexPath);
    }
}

#pragma mark - 占位符

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty_placeholder"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Please Allow Photo Access";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"This allows you to share photos from your library and save photos to your camera roll.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    
    return [[NSAttributedString alloc] initWithString:@"继续" attributes:attributes];
}

- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"img_empty"];
}

//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIColor whiteColor];
//}
//
//- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
//{
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [activityView startAnimating];
//    return activityView;
//}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 20.0f;
}

/*
 - (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
 {
 return YES;
 }
 */

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

/*
 //Asks for image view animation permission (Default is NO) :
 - (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView
 {
 return YES;
 }
 */

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

//Notifies when the dataset view was tapped:
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    // Do something
    NSLog(@"didTapView");
    _emptyActionBlock();
}

//Notifies when the data set call to action button was tapped:
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    // Do something
    NSLog(@"didTapButton");
    _emptyActionBlock();
}




@end
