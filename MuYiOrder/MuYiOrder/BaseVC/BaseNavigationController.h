//
//  BaseNavigationController.h
//  EnjoyiOS
//
//  Created by Ug's iMac on 2016/11/23.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

@end

@interface UIImage (NCColor)

/** 生成一张所需颜色的图片，大小为(50.0, 50.0) */
+ (UIImage *)imageWithColorForNavigationController:(UIColor *)color;
/** 生成一张所需颜色的图片，可以自定义大小 */
+ (UIImage *)imageWithColorForNavigationController:(UIColor *)color imageSize:(CGSize)size;

@end
