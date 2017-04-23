//
//  UITableView+CellRadius.h
//  Easement
//
//  Created by Ug's iMac on 2016/12/21.
//  Copyright © 2016年 avery. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 设置 UITableView cell 圆角，在 -tableView:willDisplayCell:forRowAtIndexPath: 中调用
 */
@interface UITableView (CellRadius)


/**
 为整个 section 设置带圆角的背景，即一个 section 中，第一个和最后一个 cell 带圆角，其他为直线

 @param radius 圆角大小
 @param dx 背景左右边距
 @param dy 背景上下边距，设置 cell 高度时，要把这个边距 * 2加上
 @param backgroundColor 圆角背景颜色
 @param borderColor 圆角背景边框颜色
 @param shadowColor 圆角背景阴影颜色
 @param shadowOffset 圆角背景阴影位移
 @param shadowOpacity 圆角背景阴影透明度
 @param shadowRadius 圆角背景阴影模糊度
 @param addCellLine 是否给一个 section 中的 cell 添加分割线，需要配合 tableView 的 separatorStyle 属性调试
 @param cell -tableView:willDisplayCell:forRowAtIndexPath: 中的 cell 参数
 @param indexPath -tableView:willDisplayCell:forRowAtIndexPath: 中的 indexPath 参数
 */
- (void)sectionCornerRadius:(CGFloat)radius
					dxInset:(CGFloat)dx
					dyInset:(CGFloat)dy
			backgroundColor:(UIColor *)backgroundColor
				borderColor:(UIColor *)borderColor
				shadowColor:(UIColor *)shadowColor
			   shadowOffset:(CGSize)shadowOffset
			  shadowOpacity:(CGFloat)shadowOpacity
			   shadowRadius:(CGFloat)shadowRadius
				addCellLine:(BOOL)addCellLine
			willDisplayCell:(UITableViewCell *)cell
		  forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 为单个 cell 设置带圆角的背景，即一个 section 中，每一个 cell 都带圆角
 
 @param radius 圆角大小
 @param dx 背景左右边距
 @param dy 背景上下边距，设置 cell 高度时，要把这个边距 * 2加上
 @param backgroundColor 圆角背景颜色
 @param borderColor 圆角背景边框颜色
 @param shadowColor 圆角背景阴影颜色
 @param shadowOffset 圆角背景阴影位移
 @param shadowOpacity 圆角背景阴影透明度
 @param shadowRadius 圆角背景阴影模糊度
 @param cell -tableView:willDisplayCell:forRowAtIndexPath: 中的 cell 参数
 @param indexPath -tableView:willDisplayCell:forRowAtIndexPath: 中的 indexPath 参数
 */
- (void)cellCornerRadius:(CGFloat)radius
				 dxInset:(CGFloat)dx
				 dyInset:(CGFloat)dy
		 backgroundColor:(UIColor *)backgroundColor
			 borderColor:(UIColor *)borderColor
			 shadowColor:(UIColor *)shadowColor
			shadowOffset:(CGSize)shadowOffset
		   shadowOpacity:(CGFloat)shadowOpacity
			shadowRadius:(CGFloat)shadowRadius
		 willDisplayCell:(UITableViewCell *)cell
	   forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
