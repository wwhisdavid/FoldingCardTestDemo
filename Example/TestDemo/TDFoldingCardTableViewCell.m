//
//  TDFoldingCardTableViewCell.m
//  TestDemo_Example
//
//  Created by guoran on 2018/3/8.
//  Copyright © 2018年 wwhisdavid. All rights reserved.
//

#import "TDFoldingCardTableViewCell.h"
#import "TDFoldingCardCompoment.h"
#import "Masonry.h"
#import "TDMacro.h"

@interface TDFoldingCardTableViewCell()

@property (nonatomic, strong) TDFoldingCardCompoment *cardComponent;

@end

@implementation TDFoldingCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _initAllViews];
    }
    return self;
}

- (void)_initAllViews{
    TDFoldingCardCompoment *cardComponent = [TDFoldingCardCompoment defaultComponent];
    [self.contentView addSubview:cardComponent];
    self.cardComponent = cardComponent;
}

- (void)setEntity:(TDFoldingCardItemEntity *)entity{
    _entity = entity;
    self.cardComponent
        .componentFrame(CGRectMake(100, 50, 200, 100))
        .cardColor([UIColor colorWithRed:249/255.f green:209/255.f blue:210/255.f alpha:1])
        .cardBorderColor([UIColor redColor])
        .horizontalRatio(entity.hFoldRatio)
        .verticalRatio(entity.vFoldRatio)
        .entity(entity)
    .build();
}



@end
