//
//  UITableView+ProjectCellRadius.h
//  Easement
//
//  Created by Ug's iMac on 2016/12/21.
//  Copyright © 2016年 avery. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+CellRadius.h"

@interface UITableView (ProjectCellRadius)

/** 为整个 section 设置带圆角的背景，即一个 section 中，第一个和最后一个 cell 带圆角，其他为直线 */
- (void)sectionCornerRadiusWillDisplayCell:(UITableViewCell *)cell
						 forRowAtIndexPath:(NSIndexPath *)indexPath;

/** 为单个 cell 设置带圆角的背景，即一个 section 中，每一个 cell 都带圆角  */
- (void)cellCornerRadiusWillDisplayCell:(UITableViewCell *)cell
					  forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
