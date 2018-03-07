//
//  TDFoldingCartViewModel.m
//  TestDemo
//
//  Created by guoran on 2018/3/7.
//

#import "TDFoldingCardViewModel.h"

@interface TDFoldingCardViewModel()

@property (nonatomic, strong, readwrite) TDCommand *cardCommand;

@end

@implementation TDFoldingCardViewModel

- (instancetype)init{
    if (self = [super init]) {
        [self _initCommands];
    }
    return self;
}

#pragma mark - Private
- (void)_initCommands{
    _cardCommand = [[TDCommand<NSDictionary *, NSDictionary *> alloc] initWithConsumeHandler:^(NSDictionary *input, TDCommandCompletionBlock completionHandler) {
        NSCParameterAssert(input);
        NSCParameterAssert(completionHandler);
        
        // 入参处理
        NSString *fileName = input[@"fileName"];
        if (!fileName) {
            // TODO: throw error.
            completionHandler(nil, nil);
        }
        // 读文件
        NSDictionary *result = nil;
        NSString *name = fileName.stringByDeletingPathExtension;
        NSString *ext = fileName.pathExtension;
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:ext];
        if(path){
            NSData *data = [[NSData alloc] initWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:NULL];
            if (data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    result = dict[@"data"];
                }
            }
        }
        
        completionHandler(nil, result);
    }];
}

@end
