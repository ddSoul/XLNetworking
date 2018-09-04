//
//  XLBlock.m
//  XLNetworking
//
//  Created by ddSoul on 2018/8/31.
//  Copyright © 2018年 dxl. All rights reserved.
//

#import "XLBlock.h"

@implementation XLBlock


- (void)xl_oneTestBlock:(void (^)(NSString *string))block {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"____1:Block____%@",[NSThread currentThread]);
        !block?:block(@"1");
    });
}
- (void)xl_twoTestBlock:(void (^)(NSString *string))block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"____2:Block____%@",[NSThread currentThread]);
        !block?:block(@"2");
    });
}
- (void)xl_thrTestBlock:(void (^)(NSString *string))block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"____3:Block____%@",[NSThread currentThread]);
        !block?:block(@"3");
    });
}
- (void)xl_fouTestBlock:(void (^)(NSString *string))block {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"____4:Block____%@",[NSThread currentThread]);
        !block?:block(@"4");
    });
}

@end
