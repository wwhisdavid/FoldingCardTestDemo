//
//  TDFoldingCardCompoment.h
//  TestDemo
//
//  Created by guoran on 2018/3/7.
//

#import <UIKit/UIKit.h>
#import "TDFoldingCardItemEntity.h"
// TODO:组件暴露的统一接口。
@interface TDFoldingCardCompoment : UIView
// 由于对构造的要求比较复杂和灵活，选择链式构造器，易于拓展和参数的事务设置。

@property (nonatomic, copy, readonly) TDFoldingCardCompoment* (^componentFrame)(CGRect frame);

// 设置水平和垂直方向折叠点位置（若设置为 0.6、0.8，则在水平方向 0.6 分位点，垂直方向 0.8 分位点两点为折叠点，进行折叠）
// Warning: 分位点系数不能超过 1（超出范围无法折叠），不能小于 0.5（折叠范围太大，影响正常展示，容错）。
@property (nonatomic, copy, readonly) TDFoldingCardCompoment* (^horizontalRatio)(CGFloat hRatio);
@property (nonatomic, copy, readonly) TDFoldingCardCompoment* (^verticalRatio)(CGFloat vRatio);

@property (nonatomic, copy, readonly) TDFoldingCardCompoment* (^cardColor)(UIColor *cardColor);
@property (nonatomic, copy, readonly) TDFoldingCardCompoment* (^cardBorderColor)(UIColor *cardBorderColor);
@property (nonatomic, copy, readonly) TDFoldingCardCompoment* (^entity)(TDFoldingCardItemEntity *entity);

// 构造至此，view 构造完成。
@property (nonatomic, copy, readonly) TDFoldingCardCompoment* (^build)();

+ (instancetype)defaultComponent;

@end
