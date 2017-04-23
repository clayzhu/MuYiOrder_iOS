//
//  CZString.m
//  EnjoyiOS
//
//  Created by Ug's iMac on 2016/12/14.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import "CZString.h"

@implementation CZString

+ (BOOL)isEmpty:(id)object {
	if ([object isKindOfClass:[NSNull class]]) {
		return YES;
	} else {
		NSString *str = (NSString *)object;
		NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
		NSString *trimmedString = [str stringByTrimmingCharactersInSet:set];
		if (trimmedString.length == 0) {
			return YES;
		} else {
			return NO;
		}
	}
}

+ (BOOL)isNil:(id)object {
	if ([object isKindOfClass:[NSNull class]]) {
		return YES;
	} else {
		NSString *str = (NSString *)object;
		NSString *checkStr = [NSString stringWithFormat:@"%@", str];
		return [checkStr isEqualToString:@"(null)"] || [checkStr isEqualToString:@""] || checkStr.length == 0 ? YES : NO;
	}
}

+ (NSString *)formatString:(id)object {
	if ([CZString isNil:object]) {
		return @"";
	} else {
		NSString *str = (NSString *)object;
		return [NSString stringWithFormat:@"%@", str];
	}
}

+ (NSString *)trimString:(NSString *)string limit:(NSInteger)limit {
	if (string == nil) {
		return string;
	}
	if (string.length > limit) {
		return [string substringToIndex:limit];
	} else {
		return string;
	}
}

+ (NSString *)trimMixString:(NSString *)string limit:(NSInteger)limit {
	if (string == nil) {
		return string;
	}
	NSMutableString *c = [NSMutableString new];
	NSInteger position = limit;
	for (int i = 0; i < string.length; i ++) {
		if (position == 0) {
			break;
		}
		unichar ch = [string characterAtIndex:i];
		if (0x4e00 < ch && ch < 0x9fff) {
			//若为汉字
			[c appendString:[string substringWithRange:NSMakeRange(i, 1)]];
			position = position - 2;
		} else {
			[c appendString:[string substringWithRange:NSMakeRange(i, 1)]];
			position = position - 1;
		}
	}
	return c;
}

/** 十六进制字符串转换为十进制 */
+ (NSString *)stringFromHexString:(NSString *)hexString {
	if (![hexString hasSuffix:@"0x"]) {	// 需要补全加上十六进制的标记
		return [NSString stringWithFormat:@"%.0lu", strtoul([hexString UTF8String], 0, 16)];
	} else {
		return [NSString stringWithFormat:@"%.0lu", strtoul([[NSString stringWithFormat:@"0x%@", hexString] UTF8String], 0, 16)];
	}
}

+ (BOOL)isValidateChineseString:(NSString *)string {
	NSString *cnNameRegex = @"^\\s*[\\u4e00-\\u9fa5]{1,}[\\u4e00-\\u9fa5.·]{0,15}[\\u4e00-\\u9fa5]{1,}\\s*$";
	NSPredicate *cnNameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cnNameRegex];
	return [cnNameTest evaluateWithObject:string];
}

+ (NSArray *)getAStringOfChineseWord:(NSString *)string {
	if (string == nil || [string isEqual:@""]) {
		return nil;
	}
	NSMutableArray *arr = [[NSMutableArray alloc] init];
	for (int i = 0; i < string.length; i ++) {
		int a = [string characterAtIndex:i];
		if (a < 0x9fff && a > 0x4e00) {
			[arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
		}
	}
	return arr;
}

+ (NSArray *)getAStringOfChineseCharacters:(NSString *)string {
	if (string == nil || [string isEqual:@""]) {
		return nil;
	}
	NSMutableArray *arr = [[NSMutableArray alloc] init];
	for (int i = 0; i < string.length; i ++) {
		NSRange range = NSMakeRange(i, 1);
		NSString *subStr = [string substringWithRange:range];
		const char *c = [subStr UTF8String];
		if (strlen(c) == 3) {
			[arr addObject:subStr];
		}
	}
	return arr;
}

+ (NSArray *)getAStringOfChineseWordNumberEnglish:(NSString *)string {
	if (string == nil || [string isEqual:@""]) {
		return nil;
	}
	NSMutableArray *arr = [[NSMutableArray alloc] init];
	for (int i = 0; i < string.length; i ++) {
		int a = [string characterAtIndex:i];	// ASCII 码
		if (a < 0x9fff && a > 0x4e00) {	// 中文
			[arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
		}
		else if (48 <= a && a <= 57) {	// 数字
			[arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
		}
		else if ((65 <= a && a <= 90) || (97 <= a && a <= 122)) {	// 英文
			[arr addObject:[string substringWithRange:NSMakeRange(i, 1)]];
		}
	}
	return arr;
}

@end
