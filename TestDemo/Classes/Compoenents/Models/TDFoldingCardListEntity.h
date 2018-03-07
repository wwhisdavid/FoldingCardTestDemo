//
//  TDFoldingCardListEntity.h
//  TestDemo
//
//  Created by guoran on 2018/3/8.
//

#import <Foundation/Foundation.h>
#import "TDFoldingCardItemEntity.h"
@interface TDFoldingCardListEntity : NSObject

@property (nonatomic, strong) NSArray<TDFoldingCardItemEntity *> *list;

@end
