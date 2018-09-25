//
//  NSString+QdtVerificationMethods.m
//  Pointer
//
//  Created by Qin Yuxiang on 3/15/16.
//  Copyright © 2016 GM. All rights reserved.
//

#import "NSString+QdtVerificationMethods.h"

@implementation NSString (QdtVerificationMethods)

+ (BOOL)isEmptyOrNull:(NSString *)str {
    if ((NSNull *) str == [NSNull null]) {
        return YES;
    }
    if (str == nil) {
        return YES;
    } else if ([str length] == 0) {
        return YES;
    } else {
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([str length] == 0) {
            return YES;
        }
    }
    return NO;
}



@end
