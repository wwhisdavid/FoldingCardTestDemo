//
//  TDCommand.h
//  TestDemo
//
//  Created by guoran on 2018/3/7.
//

#import <Foundation/Foundation.h>

typedef void (^TDCommandCompletionBlock)(id error, id content);

/**
 * input 是外部入参
 * 当拿到数据后，调用下 completionHandler，这样 `result` 属性就会变化
 */
typedef void (^TDCommandConsumeBlock)(id input, TDCommandCompletionBlock completionHandler);

/**
 *  有些操作，如 http 请求，需要手动取消
 */
typedef void (^TDCommandCancelBlock)();

@interface TDCommandResult <__covariant T> : NSObject
@property (nonatomic) NSError *error;
@property (nonatomic) T content;
@end

@interface TDCommand <__covariant inputType, __covariant outputType> : NSObject

/**
 *  外部可以对这两个 property 进行 KVO
 */
@property (nonatomic, readonly) BOOL executing;
@property (nonatomic, readonly) TDCommandResult<outputType> *result;

- (instancetype)initWithConsumeHandler:(void (^)(inputType input, TDCommandCompletionBlock completionHandler))consumeHandler;
- (instancetype)initWithConsumeHandler:(void (^)(inputType input, TDCommandCompletionBlock completionHandler))consumeHandler cancelHandler:(TDCommandCancelBlock)cancelHandler;

- (void)execute:(inputType)input;
- (void)cancel;

@end
