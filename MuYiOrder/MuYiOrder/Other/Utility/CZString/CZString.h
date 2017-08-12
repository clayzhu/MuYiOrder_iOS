//
//  CZString.h
//  EnjoyiOS
//
//  Created by Ug's iMac on 2016/12/14.
//  Copyright © 2016年 Ugood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZString : NSObject

#pragma mark - 判断空字符串
/** 判断一个对象是否为空的字符串或是否全为空格 */
+ (BOOL)isEmpty:(id)object;
/** 判断一个对象是否为空的字符串 */
+ (BOOL)isNil:(id)object;

/**
 *  格式化字符串，防止纯数字时字符串自动转换为 NSNumber 类型，同时防止空值
 *
 *  @param object 字符串或 NSNull 等空值
 *
 *  @return 格式化后的字符串，空时返回【@""】
 */
+ (NSString *)formatString:(id)object;

/**
 *  切割字符串到指定的字符长度
 *
 *  @param string 要切割的原字符串
 *  @param limit  指定的字符数
 *
 *  @return 返回一个最大长度为 limit 的字符串
 */
+ (NSString *)trimString:(NSString *)string limit:(NSInteger)limit;

/**
 *  根据不同语言切割字符串到指定的字节长度，即若切割英文字符串8个字节（字符数），则中文字符串为4个字符
 *
 *  @param string 要切割的原字符串
 *  @param limit  指定的字节长度
 *
 *  @return 返回一个最大长度为 limit 的字符串，中文字符串比英文的少一半字符
 */
+ (NSString *)trimMixString:(NSString *)string limit:(NSInteger)limit;

/** 十六进制字符串转换为十进制 */
+ (NSString *)stringFromHexString:(NSString *)hexString;

#pragma mark - 获取字符串中的有效字符
/** 验证字符串是否为中文 */
+ (BOOL)isValidateChineseString:(NSString *)string;
/** 获取一段字符串中的中文字 */
+ (NSArray *)getAStringOfChineseWord:(NSString *)string;
/** 获取一段字符串中的中文字和中文字符 */
+ (NSArray *)getAStringOfChineseCharacters:(NSString *)string;
/** 获取一段字符串中的中文字、数字、英文 */
+ (NSArray *)getAStringOfChineseWordNumberEnglish:(NSString *)string;

@end
