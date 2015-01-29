//
//  NSString+encode.m
//  TestScheme
//
//  Created by xiaohuihu on 14-10-13.
//  Copyright (c) 2014年 hxh. All rights reserved.
//

#import "NSString+encode.h"

@implementation NSString (encode)

- (NSString *)encodeChinese{
   return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL,  CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//    return strWithUTF8;
}

@end
