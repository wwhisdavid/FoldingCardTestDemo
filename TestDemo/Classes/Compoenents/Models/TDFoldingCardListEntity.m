//
//  TDFoldingCardListEntity.m
//  TestDemo
//
//  Created by guoran on 2018/3/8.
//

#import "TDFoldingCardListEntity.h"
#import "MJExtension.h"

@implementation TDFoldingCardListEntity

+ (void)load{
    [TDFoldingCardListEntity mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":@"TDFoldingCardItemEntity"
                 };
    }];
}

@end
