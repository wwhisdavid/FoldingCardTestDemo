//
//  TDFoldingCardItemEntity.h
//  TestDemo
//
//  Created by guoran on 2018/3/8.
//

#import <Foundation/Foundation.h>

@interface TDFoldingCardItemEntity : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) NSInteger titleLineCount;
@property (nonatomic, assign) CGFloat vFoldRatio;
@property (nonatomic, assign) CGFloat hFoldRatio;

@end
