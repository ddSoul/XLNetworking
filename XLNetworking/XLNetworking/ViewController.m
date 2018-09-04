//
//  ViewController.m
//  XLNetworking
//
//  Created by ddSoul on 2018/8/31.
//  Copyright © 2018年 dxl. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "XLBlock.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self xl_blockTest];
    [self addOperations];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addOperations {
    //利用线程依赖关系测试

    NSLog(@"_______go_________");
    XLBlock *blcok = [[XLBlock alloc] init];
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [blcok xl_oneTestBlock:^(NSString *string) {
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [blcok xl_twoTestBlock:^(NSString *string) {
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [blcok xl_thrTestBlock:^(NSString *string) {
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
    
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        [blcok xl_fouTestBlock:^(NSString *string) {
            dispatch_semaphore_signal(sema);
        }];
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }];
    
    [operation2 addDependency:operation1];
    [operation3 addDependency:operation2];
    [operation4 addDependency:operation3];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[operation1,operation2,operation3,operation4] waitUntilFinished:NO];
}

- (void)xl_blockTest {
    
    NSLog(@"______go______");
    dispatch_group_t groupQueue = dispatch_group_create();
    XLBlock *blcok = [[XLBlock alloc] init];
    
    dispatch_group_enter(groupQueue);
    [blcok xl_fouTestBlock:^(NSString *string) {
        dispatch_group_leave(groupQueue);
    }];
    
    dispatch_group_enter(groupQueue);
    [blcok xl_oneTestBlock:^(NSString *string) {
        dispatch_group_leave(groupQueue);
    }];
    
    dispatch_group_enter(groupQueue);
    [blcok xl_thrTestBlock:^(NSString *string) {
        dispatch_group_leave(groupQueue);
    }];
    
    dispatch_group_enter(groupQueue);
    [blcok xl_twoTestBlock:^(NSString *string) {
        dispatch_group_leave(groupQueue);
    }];
    
//    dispatch_group_notify(groupQueue, dispatch_get_main_queue(), ^{
        NSLog(@"___hello");
//    });
}

- (void)xl_testGroupQueue {
    dispatch_group_t groupQueue = dispatch_group_create();
    dispatch_group_enter(groupQueue);
    
    
    dispatch_group_leave(groupQueue);
    dispatch_group_notify(groupQueue, dispatch_get_main_queue(), ^{

    });
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
