//
//  UITableView+CellRadius.m
//  Easement
//
//  Created by Ug's iMac on 2016/12/21.
//  Copyright © 2016年 avery. All rights reserved.
//

#import "UITableView+CellRadius.h"

@implementation UITableView (CellRadius)

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
		  forRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([cell respondsToSelector:@selector(tintColor)]) {
		CGFloat cornerRadius = radius;
		cell.backgroundColor = UIColor.clearColor;
		CAShapeLayer *layer = [[CAShapeLayer alloc] init];
		CGMutablePathRef pathRef = CGPathCreateMutable();
		CGRect bounds = CGRectInset(cell.bounds, dx, dy);
		BOOL addLine = NO;
		if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section] - 1) {	// 绘制 section 只有一个 cell 的圆角
			CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
			// 阴影
			layer.shadowColor = shadowColor.CGColor;
			layer.shadowOffset = shadowOffset;
			layer.shadowOpacity = shadowOpacity;
			layer.shadowRadius = shadowRadius;
		} else if (indexPath.row == 0) {	// 绘制 section 中第一个 cell 的圆角
			CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
			CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
			CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
			CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
			addLine = YES;
		} else if (indexPath.row == [self numberOfRowsInSection:indexPath.section] - 1) {	// 绘制 section 中最后一个 cell 的圆角
			CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
			CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
			CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
			CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
			// 阴影
			layer.shadowColor = shadowColor.CGColor;
			layer.shadowOffset = shadowOffset;
			layer.shadowOpacity = shadowOpacity;
			layer.shadowRadius = shadowRadius;
		} else {	// 绘制 section 中间几个 cell 的边
			CGPathAddRect(pathRef, nil, bounds);
			addLine = YES;
		}
		layer.path = pathRef;
		CFRelease(pathRef);
		
		// 背景颜色
		layer.fillColor = backgroundColor.CGColor;
		layer.strokeColor = borderColor.CGColor;
		
		// 添加 cell 分割线
		if (addLine == YES && addCellLine == YES) {
			CALayer *lineLayer = [[CALayer alloc] init];
			CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
			lineLayer.frame = CGRectMake(CGRectGetMinX(bounds) + 10.0, bounds.size.height - lineHeight, bounds.size.width - 10.0, lineHeight);
			lineLayer.backgroundColor = self.separatorColor.CGColor;
			[layer addSublayer:lineLayer];
		}
		
		UIView *testView = [[UIView alloc] initWithFrame:bounds];
		[testView.layer insertSublayer:layer atIndex:0];
		testView.backgroundColor = UIColor.clearColor;
		cell.backgroundView = testView;
	}
}

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
	   forRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([cell respondsToSelector:@selector(tintColor)]) {
		CGFloat cornerRadius = radius;
		cell.backgroundColor = UIColor.clearColor;
		CAShapeLayer *layer = [[CAShapeLayer alloc] init];
		CGMutablePathRef pathRef = CGPathCreateMutable();
		CGRect bounds = CGRectInset(cell.bounds, dx, dy);
		BOOL addLine = NO;
		// 圆角
		CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
		// 阴影
		layer.shadowColor = shadowColor.CGColor;
		layer.shadowOffset = shadowOffset;
		layer.shadowOpacity = shadowOpacity;
		layer.shadowRadius = shadowRadius;
		
		layer.path = pathRef;
		CFRelease(pathRef);
		
		// 背景颜色
		layer.fillColor = backgroundColor.CGColor;
		layer.strokeColor = borderColor.CGColor;
		
		// 添加 cell 分割线
		if (addLine == YES) {
			CALayer *lineLayer = [[CALayer alloc] init];
			CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
			lineLayer.frame = CGRectMake(CGRectGetMinX(bounds) + 10.0, bounds.size.height - lineHeight, bounds.size.width - 10.0, lineHeight);
			lineLayer.backgroundColor = self.separatorColor.CGColor;
			[layer addSublayer:lineLayer];
		}
		
		UIView *testView = [[UIView alloc] initWithFrame:bounds];
		[testView.layer insertSublayer:layer atIndex:0];
		testView.backgroundColor = UIColor.clearColor;
		cell.backgroundView = testView;
	}
}

@end
