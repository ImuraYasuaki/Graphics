//
//  GYFunctionsView.m
//  Timer
//
//  Created by myuon on 2014/12/31.
//  Copyright (c) 2014年 yasu. All rights reserved.
//

#import "GYFunctionsView.h"
#import "UIView+Defaults.h"

@interface GYFunctionsView ()
@property (nonatomic, assign) CGPoint hiddenPosition;
@property (nonatomic, assign) CGPoint shownPosition;
@property (nonatomic, strong) GYFunctionsViewSelectedBlock selectedBlock;
+ (UIWindow *)targetWindow;
+ (CGRect)targetWindowBounds;
+ (NSInteger)functionTagWithIndex:(NSInteger)tag;
+ (NSInteger)indexWithFunctionTag:(NSInteger)tag;
+ (GYFunctionsViewPosition)positionOfHorizontalWithPosition:(GYFunctionsViewPosition)position;
+ (GYFunctionsViewPosition)positionOfVerticalWithPosition:(GYFunctionsViewPosition)position;
+ (CGPoint)shownPointWithPosition:(GYFunctionsViewPosition)position size:(const CGSize)size;
+ (CGPoint)hiddenPointWithPosition:(GYFunctionsViewPosition)position size:(const CGSize)size;
@end

@interface GYFunctionsView (Action)
- (void)didTapFunctionButton:(UIButton *)sender;
@end

@implementation GYFunctionsView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setVisibleAlpha:[UIColor defaultStrongAlpha]];
        [self setAnimationDuration:[UIView defaultAnimationDuration]];
    }
    return self;
}

- (void)removeFromSuperview {
    [self setSelectedBlock:nil];

    [super removeFromSuperview];
}

+ (GYFunctionsView *)functionsViewFrom:(GYFunctionsViewPosition)position titles:(NSArray *)titles selected:(GYFunctionsViewSelectedBlock)selectedBlock {
    return [self functionsViewFrom:position titles:titles visualize:nil selected:selectedBlock];
}

+ (GYFunctionsView *)functionsViewFrom:(GYFunctionsViewPosition)position titles:(NSArray *)titles visualize:(GYFunctionsViewVisualizeBlock)visualizeBlock selected:(GYFunctionsViewSelectedBlock)selectedBlock {
    GYFunctionsView *functionsView = [[GYFunctionsView alloc] init];
    [functionsView setSelectedBlock:selectedBlock];
    [functionsView setAlpha:0.0f];

    UIWindow *targetWindow = [self targetWindow];
    [targetWindow addSubview:functionsView];

    GYFunctionsViewPosition horizontalPosition = [self.class positionOfHorizontalWithPosition:position];
    CGSize size = CGSizeZero;
    NSInteger index = 0;
    for (NSString *title in titles) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:functionsView action:@selector(didTapFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTag:[self.class functionTagWithIndex:index]];
        [button setBackgroundColor:[UIColor clearColor]];
        switch (horizontalPosition) {
            case GYFunctionsViewPositionLeft:     [button.titleLabel setTextAlignment:NSTextAlignmentLeft]; break;
            case GYFunctionsViewPositionRight:    [button.titleLabel setTextAlignment:NSTextAlignmentRight]; break;
            case GYFunctionsViewPositionCenter:
            default: [button.titleLabel setTextAlignment:NSTextAlignmentCenter]; break;
        }
        [button sizeToFit];
        
        CGRect buttonFrame = button.bounds;
        buttonFrame.size.width += 8.0f * 2.0f;
        buttonFrame.size.height = [UIView defaultControlHeight];
        buttonFrame.origin.x = 0.0f;
        [button setFrame:buttonFrame];

        UIView *view = [[UIView alloc] initWithFrame:button.bounds];
        [view setBackgroundColor:[UIColor defaultOverlayBackgroundColor]];
        [view addSubview:button];
        [view sizeToFit];

        if (visualizeBlock) {
            visualizeBlock(functionsView, view, button, title, index);
        }
        [functionsView addSubview:view];
        
        index++;
        
        size.width = MAX(size.width, CGRectGetWidth([button bounds]));
        size.height += CGRectGetHeight([button bounds]);
    }
    CGRect frame = CGRectZero;
    frame.size = size;
    [functionsView setFrame:frame];
    [functionsView setPosition:position];
    [functionsView hide];

    return functionsView;
}

- (void)setPosition:(GYFunctionsViewPosition)position {
    GYFunctionsViewPosition horizontalPosition = [self.class positionOfHorizontalWithPosition:position];

    CGRect functionsViewFrame = self.frame;
    functionsViewFrame.origin = [self.class hiddenPointWithPosition:position size:functionsViewFrame.size];
    [self setHiddenPosition:functionsViewFrame.origin];
    [self setShownPosition:[self.class shownPointWithPosition:position size:functionsViewFrame.size]];

    CGFloat y = 0.0f;
    CGFloat functionsViewWidth = CGRectGetWidth(functionsViewFrame);
    for (UIView *subview in [self subviews]) {
        CGRect subviewFrame = subview.frame;
        CGFloat x = 0.0f;
        switch (horizontalPosition) {
            case GYFunctionsViewPositionLeft:     x = 0.0f; break;
            case GYFunctionsViewPositionRight:    x = functionsViewWidth - CGRectGetWidth(subview.frame); break;
            case GYFunctionsViewPositionCenter:
            default: x = (functionsViewWidth - CGRectGetWidth(subview.frame)) * 0.5f; break;
        }
        subviewFrame.origin = CGPointMake(x, y);
        [subview setFrame:subviewFrame];

        y += CGRectGetHeight(subviewFrame);
    }
}

- (void)show {
    if (!self.superview) {
        [[self.class targetWindow] addSubview:self];
    }
    [[self.class targetWindow] bringSubviewToFront:self];

    CGRect frame = [self frame];
    frame.origin = [self hiddenPosition];
    [self setFrame:frame];

    CGRect functionsViewFrame = self.bounds;
    functionsViewFrame.origin = self.shownPosition;
    [UIView animateWithDuration:self.animationDuration animations:^{
        [self setFrame:functionsViewFrame];
        [self setAlpha:self.visibleAlpha];
    } completion:^(BOOL finished) {
        // nothing to do ...
    }];
}

- (void)hide {
    CGRect frame = self.frame;
    frame.origin = self.hiddenPosition;
    [UIView animateWithDuration:self.animationDuration animations:^{
        [self setFrame:frame];
        [self setAlpha:0.2f];
    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
    }];
}

+ (UIWindow *)targetWindow {
    return [[[UIApplication sharedApplication] delegate] window];
}

+ (CGRect)targetWindowBounds {
    return [[self targetWindow] bounds];
}

+ (NSInteger)functionTagWithIndex:(NSInteger)tag {
    return tag + 1000;
}

+ (NSInteger)indexWithFunctionTag:(NSInteger)tag {
    return tag - 1000;
}

+ (GYFunctionsViewPosition)positionOfHorizontalWithPosition:(GYFunctionsViewPosition)position {
    if (position & GYFunctionsViewPositionLeft) {
        return GYFunctionsViewPositionLeft;
    }
    if (position & GYFunctionsViewPositionRight) {
        return GYFunctionsViewPositionRight;
    }
    return GYFunctionsViewPositionCenter;
}

+ (GYFunctionsViewPosition)positionOfVerticalWithPosition:(GYFunctionsViewPosition)position {
    if (position & GYFunctionsViewPositionTop) {
        return GYFunctionsViewPositionTop;
    }
    if (position & GYFunctionsViewPositionBottom) {
        return GYFunctionsViewPositionBottom;
    }
    return GYFunctionsViewPositionCenter;
}

+ (CGPoint)shownPointWithPosition:(GYFunctionsViewPosition)position size:(const CGSize)size {
    CGRect baseFrame = [self targetWindowBounds];

    CGFloat x = 0.0f;
    GYFunctionsViewPosition horizontalPosition = [self.class positionOfHorizontalWithPosition:position];
    switch (horizontalPosition) {
        case GYFunctionsViewPositionLeft:     x = 0.0f; break;
        case GYFunctionsViewPositionRight:    x = CGRectGetWidth(baseFrame) - size.width; break;
        case GYFunctionsViewPositionCenter:
        default:                            x = (CGRectGetWidth(baseFrame) - size.width) * 0.5f; break;
    }
    CGFloat y = 0.0f;
    GYFunctionsViewPosition verticalPosition = [self.class positionOfVerticalWithPosition:position];
    switch (verticalPosition) {
        case GYFunctionsViewPositionTop:      y = 0.0f; break;
        case GYFunctionsViewPositionBottom:   y = CGRectGetHeight(baseFrame) - size.height; break;
        case GYFunctionsViewPositionCenter:
        default:                            y = (CGRectGetHeight(baseFrame) - size.height) * 0.5f; break;
    }
    return CGPointMake(x, y);
}

+ (CGPoint)hiddenPointWithPosition:(GYFunctionsViewPosition)position size:(const CGSize)size {
    CGRect baseFrame = [self targetWindowBounds];

    CGFloat x = 0.0f;
    GYFunctionsViewPosition horizontalPosition = [self.class positionOfHorizontalWithPosition:position];
    switch (horizontalPosition) {
        case GYFunctionsViewPositionLeft:     x = -size.width; break;
        case GYFunctionsViewPositionRight:    x = CGRectGetWidth(baseFrame); break;
        case GYFunctionsViewPositionCenter:
        default:                            x = (CGRectGetWidth(baseFrame) - size.width) * 0.5f; break;
    }
    CGFloat y = 0.0f;
    GYFunctionsViewPosition verticalPosition = [self.class positionOfVerticalWithPosition:position];
    switch (verticalPosition) {
        case GYFunctionsViewPositionTop:      y = -size.height; break;
        case GYFunctionsViewPositionBottom:   y = CGRectGetHeight(baseFrame); break;
        case GYFunctionsViewPositionCenter:
        default:                            y = (CGRectGetHeight(baseFrame) - size.height) * 0.5f; break;
    }
    return CGPointMake(x, y);
}

@end

////////////////////////////////////////////////////////////////////////////////

@implementation GYFunctionsView (Action)

- (void)didTapFunctionButton:(UIButton *)sender {
    NSInteger tag = [self.class indexWithFunctionTag:[sender tag]];
    if (self.selectedBlock) {
        self.selectedBlock(self, sender, tag);
    }
}

@end
