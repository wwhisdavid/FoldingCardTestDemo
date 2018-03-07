//
//  TDCommand.m
//  TestDemo
//
//  Created by guoran on 2018/3/7.
//

#import "TDCommand.h"
@implementation TDCommandResult
@end

@interface TDCommand ()
@property (nonatomic, copy) TDCommandConsumeBlock consumeHandler;
@property (nonatomic, copy) TDCommandCancelBlock cancelHandler;

@property (nonatomic, readwrite) TDCommandResult *result;
@property (nonatomic, readwrite) BOOL executing;
@end

@implementation TDCommand

- (instancetype)initWithConsumeHandler:(TDCommandConsumeBlock)consumeHandler
{
    return [self initWithConsumeHandler:consumeHandler cancelHandler:nil];
}

- (instancetype)initWithConsumeHandler:(TDCommandConsumeBlock)consumeHandler cancelHandler:(TDCommandCancelBlock)cancelHandler
{
    if (self = [super init]) {
        NSAssert(consumeHandler, @"consumeHandler can't be nil");
        self.consumeHandler = consumeHandler;
        self.cancelHandler = cancelHandler;
    }
    return self;
}

- (void)execute:(id)input
{
    if (!self.executing) {
        self.executing = YES;
        TDCommandCompletionBlock completionHandler = ^(id error, id content) {
            TDCommandResult *result = [[TDCommandResult alloc] init];
            result.error = error;
            result.content = content;
            // 触发 KVO，回调到监听方。
            self.result = result;
            self.executing = NO;
        };
        self.consumeHandler(input, completionHandler);
    }
}

- (void)cancel
{
    self.cancelHandler ? self.cancelHandler() : nil;
    self.executing = NO;
}

@end
