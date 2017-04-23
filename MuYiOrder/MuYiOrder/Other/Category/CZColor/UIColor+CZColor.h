//
//  UIColor+CZColor.h
//  CZColorDemo
//
//  Created by Apple on 2017/3/20.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CZColor)

/**
 *  使用十六进制的色值设置颜色
 *
 *  @param hexString 十六进制的颜色色值，“#”可写可不写。色值可传的格式有：#RBG, #ARGB, #RRGGBB, #AARRGGBB
 *
 *  @return UIColor 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/**
 *  使用十六进制的色值设置颜色，可设置透明度
 *
 *  @param hexString 十六进制的颜色色值，“#”可写可不写。色值可传的格式有：#RBG, #RRGGBB
 *  @param alpha     颜色透明度
 *
 *  @return UIColor 颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

/**
 *  设置 RGB 颜色，传入的颜色为最大 255.0 的色值，透明度为 1.0
 *
 *  @param r Red 色值
 *  @param g Green 色值
 *  @param b Blue 色值
 *
 *  @return UIColor 颜色
 */
+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

/**
 *  设置 RGB 颜色和透明度，传入的颜色为最大 255.0 的色值
 *
 *  @param r     Red 色值
 *  @param g     Green 色值
 *  @param b     Blue 色值
 *  @param alpha 透明度
 *
 *  @return UIColor 颜色
 */
+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b alpha:(CGFloat)alpha;

/** 生成一个随机颜色 */
+ (UIColor *)randomColor;

/** 根据图片获取图片的主色调 */
+ (UIColor *)primaryColorWithImage:(UIImage *)image;

@end
