//
//  UITableView+ProjectCellRadius.m
//  Easement
//
//  Created by Ug's iMac on 2016/12/21.
//  Copyright © 2016年 avery. All rights reserved.
//

#import "UITableView+ProjectCellRadius.h"

@implementation UITableView (ProjectCellRadius)

- (void)sectionCornerRadiusWillDisplayCell:(UITableViewCell *)cell
						 forRowAtIndexPath:(NSIndexPath *)indexPath {
	[self sectionCornerRadius:6.0
					  dxInset:15.0
					  dyInset:0.0
			  backgroundColor:[UIColor whiteColor]
				  borderColor:[UIColor clearColor]
				  shadowColor:[UIColor blackColor]
				 shadowOffset:CGSizeMake(0.0, 5.0)
				shadowOpacity:0.05
				 shadowRadius:7.0
				  addCellLine:NO
			  willDisplayCell:cell
			forRowAtIndexPath:indexPath];
}

- (void)cellCornerRadiusWillDisplayCell:(UITableViewCell *)cell
					  forRowAtIndexPath:(NSIndexPath *)indexPath {
	[self cellCornerRadius:6.0
				   dxInset:15.0
				   dyInset:0.0
		   backgroundColor:[UIColor whiteColor]
			   borderColor:[UIColor clearColor]
			   shadowColor:[UIColor blackColor]
			  shadowOffset:CGSizeMake(0.0, 5.0)
			 shadowOpacity:0.05
			  shadowRadius:7.0
		   willDisplayCell:cell
		 forRowAtIndexPath:indexPath];
}

@end
