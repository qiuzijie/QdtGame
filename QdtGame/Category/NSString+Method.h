//
//  NSString+Method.h
//  Pointer
//
//  Created by Qin Yuxiang on 8/16/13.
//  Copyright (c) 2013 GM. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  字符串扩展
 */
@interface NSString(Method)

/**
 *  判断字符串是否为Empty或Null
 *
 *  @param str 要判断的字符串
 *
 *  @return 判断结果
 */
+ (BOOL)isEmptyOrNull:(NSString*)str;

/**
 *  格式化数字
 *
 *  @return 显示结果 123,456,789
 */
- (NSString*)toFormatNumberString;

- (NSString*)trim;
@end
