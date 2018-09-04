//
//  XLBlock.h
//  XLNetworking
//
//  Created by ddSoul on 2018/8/31.
//  Copyright © 2018年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLBlock : NSObject

- (void)xl_oneTestBlock:(void (^)(NSString *string))block;
- (void)xl_twoTestBlock:(void (^)(NSString *string))block;
- (void)xl_thrTestBlock:(void (^)(NSString *string))block2;
- (void)xl_fouTestBlock:(void (^)(NSString *string))block3;

@end
