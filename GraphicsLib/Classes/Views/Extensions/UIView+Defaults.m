//
//  UIView+Defaults.m
//  Timer
//
//  Created by myuon on 2015/01/01.
//  Copyright (c) 2015年 yasu. All rights reserved.
//

#import "UIView+Defaults.h"

@implementation UIView (SizeDefaults)

+ (CGFloat)defaultControlHeight {
    return 44.0f;
}

@end

@implementation UIView (DurationDefaults)

+ (NSTimeInterval)defaultAnimationDuration {
    return 0.8f;
}

+ (NSTimeInterval)defaultFastAnimationDuration {
    return [self defaultAnimationDuration] * 0.5f;
}

@end

@implementation UIColor (ColorDefaults)

+ (CGFloat)defaultStrongAlpha {
    return 0.8f;
}

+ (CGFloat)defaultMiddleAlpha {
    return 0.5f;
}

+ (CGFloat)defaultWeakAlpha {
    return 0.25f;
}

+ (UIColor *)defaultOverlayBackgroundColor {
    static UIColor *c = nil;
    if (!c) {
        c = [[UIColor blackColor] colorWithAlphaComponent:[self defaultMiddleAlpha]];
    }
    return c;
}

@end
