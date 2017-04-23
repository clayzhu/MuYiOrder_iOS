//
//  UIImage+Custom.h
//  Yookeer_iOS
//
//  Created by ug19 on 15/9/8.
//  Copyright (c) 2015年 Ugood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

CGFloat DegreesToRadians(CGFloat degrees);

CGFloat RadiansToDegrees(CGFloat radians);

@interface UIImage (Custom)

/**
 *  使用指定颜色生成一张纯色图片
 *
 *  @param color 需要生成图片的颜色
 *
 *  @return 使用指定颜色生成的纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 使用指定颜色生成一张纯色图片，可指定图片大小

 @param color 需要生成图片的颜色
 @param size 需要生成图片的大小
 @return 使用指定颜色生成的纯色图片，图片大小指定
 */
+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)size;

/**
 *  以原图片中心为新图片的中心，按给定的 size 裁剪出一张新图片
 *
 *  @param size 裁剪后新图片的大小
 *
 *  @return 裁剪后的新图片
 */
- (UIImage *)cropImageAtCenterWithSize:(CGSize)size;

- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;
- (UIImage *)imageWithBackgroundColor:(UIColor *)bgColor
						  shadeAlpha1:(CGFloat)alpha1
						  shadeAlpha2:(CGFloat)alpha2
						  shadeAlpha3:(CGFloat)alpha3
						  shadowColor:(UIColor *)shadowColor
						 shadowOffset:(CGSize)shadowOffset
						   shadowBlur:(CGFloat)shadowBlur;
- (UIImage *)imageWithShadowColor:(UIColor *)shadowColor
					 shadowOffset:(CGSize)shadowOffset
					   shadowBlur:(CGFloat)shadowBlur;
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;
- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
				customAlbumName:(NSString *)customAlbumName
				completionBlock:(void (^)(void))completionBlock
				   failureBlock:(void (^)(NSError *error))failureBlock;

@end
