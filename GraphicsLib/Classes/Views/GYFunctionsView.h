//
//  GYFunctionsView.h
//  Timer
//
//  Created by myuon on 2014/12/31.
//  Copyright (c) 2014年 yasu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GYFunctionsViewPosition) {
    GYFunctionsViewPositionDefault = 0,
    GYFunctionsViewPositionRight  = 1 << 0,
    GYFunctionsViewPositionBottom = 1 << 1,
    GYFunctionsViewPositionLeft   = 1 << 2,
    GYFunctionsViewPositionTop    = 1 << 3,
    GYFunctionsViewPositionHorizontal = ((1 << 0) | (1 << 2)),//GYFunctionsViewPositionLeft | GYFunctionsViewPositionRight,
    GYFunctionsViewPositionVertical   = ((1 << 1) | (1 << 3)),//GYFunctionsViewPositionBottom | GYFunctionsViewPositionTop,

    GYFunctionsViewPositionCenter = 1 << 4,
};

@class GYFunctionsView;

typedef void (^GYFunctionsViewSelectedBlock)(GYFunctionsView *functionsView, UIButton *sender, NSUInteger index);
typedef void (^GYFunctionsViewVisualizeBlock)(GYFunctionsView *functionsView, UIView *view, UIButton *button, NSString *title, NSUInteger index);

@interface GYFunctionsView : UIView

@property (assign) CGFloat visibleAlpha;
@property (assign) NSTimeInterval animationDuration;

+ (GYFunctionsView *)functionsViewFrom:(GYFunctionsViewPosition)position titles:(NSArray *)titles selected:(GYFunctionsViewSelectedBlock)selectedBlock;
+ (GYFunctionsView *)functionsViewFrom:(GYFunctionsViewPosition)position titles:(NSArray *)titles visualize:(GYFunctionsViewVisualizeBlock)visualizeBlock selected:(GYFunctionsViewSelectedBlock)selectedBlock;

- (void)setPosition:(GYFunctionsViewPosition)position;

- (void)show;
- (void)hide;

@end
