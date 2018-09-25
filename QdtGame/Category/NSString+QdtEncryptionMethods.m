//
//  NSString+QdtEncryptionMethods.m
//  Pointer
//
//  Created by Qin Yuxiang on 3/15/16.
//  Copyright © 2016 GM. All rights reserved.
//

#import "NSString+QdtEncryptionMethods.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (QdtEncryptionMethods)

- (NSString*)toMd5HexDigest {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        
        [hash appendFormat:@"%02X", result[i]];
    }
    
    NSString *mdfiveString = [hash lowercaseString];
    
    return mdfiveString;
}

@end
