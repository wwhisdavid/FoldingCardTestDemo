//
//  TDFoldingCardCompoment.m
//  TestDemo
//
//  Created by guoran on 2018/3/7.
//

#import "TDFoldingCardCompoment.h"
#import "Masonry.h"
#import "TDMacro.h"

#define TDFoldingCardCeilingRatio 0.5f
#define TDFoldingCardBorderW 2.0f

@interface TDFoldingCardCompoment()
{
    CGFloat p_hRatio;
    CGFloat p_vRatio;
    UIColor *p_cardColor;
    UIColor *p_cardBorderColor;
}

@property (nonatomic, copy, readwrite) TDFoldingCardCompoment* (^componentFrame)(CGRect frame);
@property (nonatomic, copy, readwrite) TDFoldingCardCompoment* (^horizontalRatio)(CGFloat hRatio);
@property (nonatomic, copy, readwrite) TDFoldingCardCompoment* (^verticalRatio)(CGFloat vRatio);
@property (nonatomic, copy, readwrite) TDFoldingCardCompoment* (^cardColor)(UIColor *cardColor);
@property (nonatomic, copy, readwrite) TDFoldingCardCompoment* (^cardBorderColor)(UIColor *cardBorderColor);
@property (nonatomic, copy, readwrite) TDFoldingCardCompoment* (^build)();

@property (nonatomic, strong) UILabel *titleLabel;      // 主标题
@property (nonatomic, strong) UILabel *subtitleLabel;   // 副标题

@end

@implementation TDFoldingCardCompoment

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self _initAll];
        [self _initConstrains];
    }
    return self;
}

+ (instancetype)defaultComponent{
    return [[TDFoldingCardCompoment alloc] init];
}

#pragma mark - Private
- (void)_initAll{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    p_vRatio = 1;
    p_hRatio = 1;
}

- (void)_initConstrains{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(SuitLength(20.f));
        make.right.right.equalTo(self).offset(- SuitLength(40.f));
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(SuitLength(5));
        make.right.right.equalTo(self).offset(- SuitLength(40.f));
    }];
    
}

#pragma mark - Draw
/**
 *  绘制折叠效果，通过三角函数计算得出，较直接进行仿射变换，性能稍好。计算原理见："TestDemo/folding_principle.jpg"
 */
- (void)drawRect:(CGRect)rect{
    NSCAssert(p_hRatio >= TDFoldingCardCeilingRatio, @"最大只支持折叠一半！");
    NSCAssert(p_vRatio >= TDFoldingCardCeilingRatio, @"最大只支持折叠一半！");
    NSCAssert(p_hRatio <= 1, @"水平方向达到折叠下限！");
    NSCAssert(p_vRatio <= 1, @"垂直方向达到折叠下限！");
    
    if (p_hRatio > 1 || p_vRatio > 1) {
        p_hRatio = 1;
        p_vRatio = 1;
    }
    
    p_hRatio = p_hRatio < TDFoldingCardCeilingRatio ? TDFoldingCardCeilingRatio : p_hRatio ;
    p_vRatio = p_vRatio < TDFoldingCardCeilingRatio ? TDFoldingCardCeilingRatio : p_vRatio ;
    
    CGFloat hRatio = p_hRatio; // 水平方向
    CGFloat vRatio = p_vRatio; // 垂直方向
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    // 主题部分
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(width, 0)];
    [path addLineToPoint: CGPointMake(width,  height * vRatio)];
    [path addLineToPoint: CGPointMake(width * hRatio, height)];
    [path addLineToPoint: CGPointMake(0, height)];
    path.lineWidth = TDFoldingCardBorderW;
    
    [path closePath];
    
    [p_cardColor set];
    [path fill];
    
    [[UIColor redColor] set];
    [path stroke];
    
    
    if (p_vRatio == 1 || p_hRatio == 1) {
        return;
    }
    
    // 折叠部分
    CGFloat triangleW = width * (1 - hRatio);
    CGFloat triangleH = height * (1 - vRatio);
    
    CGFloat arctan = atan(triangleW / triangleH);
    
    CGFloat offsetY = triangleW * sin(arctan * 2);
    CGFloat offsetX = offsetY * tan(arctan * 2);
    
    CGFloat y = height - offsetY;
    CGFloat x = width - triangleH * tan(arctan * 2) + offsetX;
    
    UIBezierPath *pathPatch = [UIBezierPath bezierPath];
    [pathPatch moveToPoint: CGPointMake(width,  height * vRatio)];
    [pathPatch addLineToPoint: CGPointMake(x, y)];
    [pathPatch addLineToPoint: CGPointMake(width * hRatio, height)];
    
    [pathPatch closePath];
    [p_cardBorderColor set];
    [pathPatch fill];
}

#pragma mark - Lazy Load
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:SuitLength(15.f)];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.textColor = [UIColor grayColor];
        _subtitleLabel.font = [UIFont systemFontOfSize:SuitLength(12.f)];
    }
    return _subtitleLabel;
}

- (TDFoldingCardCompoment *(^)(CGRect))componentFrame{
    return ^TDFoldingCardCompoment *(CGRect frame){
        self.frame = frame;
        return self;
    };
}

- (TDFoldingCardCompoment *(^)(CGFloat))horizontalRatio{
    return ^TDFoldingCardCompoment *(CGFloat hRatio){
        p_hRatio = hRatio;
        return self;
    };
}

- (TDFoldingCardCompoment *(^)(CGFloat))verticalRatio{
    return ^TDFoldingCardCompoment *(CGFloat vRatio){
        p_vRatio = vRatio;
        return self;
    };
}

- (TDFoldingCardCompoment *(^)(UIColor *))cardColor{
    return ^TDFoldingCardCompoment *(UIColor *cardColor){
        p_cardColor = cardColor ?: [UIColor whiteColor];
        return self;
    };
}

- (TDFoldingCardCompoment *(^)(UIColor *))cardBorderColor{
    return ^TDFoldingCardCompoment *(UIColor *cardBorderColor){
        p_cardBorderColor = cardBorderColor?: [UIColor clearColor];
        self.layer.borderColor = p_cardBorderColor.CGColor;
        return self;
    };
}

- (TDFoldingCardCompoment *(^)())build{
    return ^TDFoldingCardCompoment *(void){
        [self setNeedsDisplay];
        return self;
    };
}

- (TDFoldingCardCompoment *(^)(TDFoldingCardItemEntity *))entity{
    return ^TDFoldingCardCompoment *(TDFoldingCardItemEntity *entity){
        self.titleLabel.text = entity.title;
        self.subtitleLabel.text = entity.subtitle;
        self.titleLabel.numberOfLines = entity.titleLineCount > 3 ? 3 : entity.titleLineCount;
        return self;
    };
}

@end
