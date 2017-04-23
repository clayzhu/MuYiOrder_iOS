//
//  UIColor+CZColor.m
//  CZColorDemo
//
//  Created by Apple on 2017/3/20.
//  Copyright © 2017年 Clay Zhu. All rights reserved.
//

#import "UIColor+CZColor.h"

@implementation UIColor (CZColor)

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
	NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
	NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat:@"%@%@", substring, substring];
	unsigned hexComponent;
	[[NSScanner scannerWithString: fullHex] scanHexInt:&hexComponent];
	return hexComponent / 255.0;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
	NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
	CGFloat alpha, red, blue, green;
	switch ([colorString length]) {
		case 3: // #RGB
			alpha = 1.0f;
			red   = [self colorComponentFrom:colorString start:0 length:1];
			green = [self colorComponentFrom:colorString start:1 length:1];
			blue  = [self colorComponentFrom:colorString start:2 length:1];
			break;
		case 4: // #ARGB
			alpha = [self colorComponentFrom:colorString start:0 length:1];
			red   = [self colorComponentFrom:colorString start:1 length:1];
			green = [self colorComponentFrom:colorString start:2 length:1];
			blue  = [self colorComponentFrom:colorString start:3 length:1];
			break;
		case 6: // #RRGGBB
			alpha = 1.0f;
			red   = [self colorComponentFrom:colorString start:0 length:2];
			green = [self colorComponentFrom:colorString start:2 length:2];
			blue  = [self colorComponentFrom:colorString start:4 length:2];
			break;
		case 8: // #AARRGGBB
			alpha = [self colorComponentFrom:colorString start:0 length:2];
			red   = [self colorComponentFrom:colorString start:2 length:2];
			green = [self colorComponentFrom:colorString start:4 length:2];
			blue  = [self colorComponentFrom:colorString start:6 length:2];
			break;
		default:
			[NSException raise:@"Invalid color value" format:@"Color value %@ is invalid. It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB.", hexString];
			break;
	}
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
	NSString *colorString = [[hexString stringByReplacingOccurrencesOfString:@"#" withString:@""] uppercaseString];
	CGFloat red, blue, green;
	switch ([colorString length]) {
		case 3:	// #RGB
			red   = [self colorComponentFrom:colorString start:0 length:1];
			green = [self colorComponentFrom:colorString start:1 length:1];
			blue  = [self colorComponentFrom:colorString start:2 length:1];
			break;
		case 6:	// #RRGGBB
			red   = [self colorComponentFrom:colorString start:0 length:2];
			green = [self colorComponentFrom:colorString start:2 length:2];
			blue  = [self colorComponentFrom:colorString start:4 length:2];
			break;
		default:
			[NSException raise:@"Invalid color value" format:@"Color value %@ is invalid. It should be a hex value of the form #RBG, or #RRGGBB.", hexString];
			break;
	}
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b {
	return     [UIColor colorWithRed:r / 255.0  green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b alpha:(CGFloat)alpha {
	return [UIColor colorWithRed:r / 255.0  green:g / 255.0 blue:b / 255.0 alpha:alpha];
}

+ (UIColor *)randomColor {
	static BOOL seeded = NO;
	if (!seeded) {
		srand48(time(0));	// drand48 函数需要使用 srand48 来初始化随机数种子
		seeded = YES;
	}
	// drand48 函数会生成一个 0.0 – 1.0 的 double
	CGFloat r = (CGFloat)drand48();
	CGFloat g = (CGFloat)drand48();
	CGFloat b = (CGFloat)drand48();
	return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

+ (UIColor *)primaryColorWithImage:(UIImage *)image {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
	int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
	int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
	//第一步，先把图片缩小，加快计算速度。但越小结果误差可能越大
	CGSize thumbSize = CGSizeMake(image.size.width / 2.0, image.size.height / 2.0);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL,
												 thumbSize.width,
												 thumbSize.height,
												 8,	// bits per component
												 thumbSize.width * 4,
												 colorSpace,
												 bitmapInfo);
	
	CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
	CGContextDrawImage(context, drawRect, image.CGImage);
	CGColorSpaceRelease(colorSpace);
	
	//第二步，取每个点的像素值
	unsigned char *data = CGBitmapContextGetData(context);
	if (data == NULL) return nil;
	NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width * thumbSize.height];
	
	for (int x = 0; x < thumbSize.width; x ++) {
		for (int y = 0; y < thumbSize.height; y ++) {
			int offset = 4 * (x * y);
			int red = data[offset];
			int green = data[offset + 1];
			int blue = data[offset + 2];
			int alpha = data[offset + 3];
			if (alpha > 0) {	// 去除透明
				if (red == 255 && green == 255 && blue == 255) {	// 去除白色
				} else {
					NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
					[cls addObject:clr];
				}
			}
		}
	}
	CGContextRelease(context);
	//第三步，找到出现次数最多的那个颜色
	NSEnumerator *enumerator = [cls objectEnumerator];
	NSArray *curColor = nil;
	NSArray *MaxColor = nil;
	NSUInteger MaxCount = 0;
	while ((curColor = [enumerator nextObject]) != nil) {
		NSUInteger tmpCount = [cls countForObject:curColor];
		if (tmpCount < MaxCount) continue;
		MaxCount = tmpCount;
		MaxColor = curColor;
		
	}
	return [UIColor colorWithRed:([MaxColor[0] intValue] / 255.0f) green:([MaxColor[1] intValue] / 255.0f) blue:([MaxColor[2] intValue] / 255.0f) alpha:([MaxColor[3] intValue] / 255.0f)];
}

@end
