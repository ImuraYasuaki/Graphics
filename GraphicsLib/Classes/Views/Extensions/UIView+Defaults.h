//
//  UIView+Defaults.h
//  Timer
//
//  Created by myuon on 2015/01/01.
//  Copyright (c) 2015年 yasu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SizeDefaults)

+ (CGFloat)defaultControlHeight;

@end

@interface UIView (DurationDefaults)

+ (NSTimeInterval)defaultAnimationDuration;
+ (NSTimeInterval)defaultFastAnimationDuration;

@end

@interface UIColor (ColorDefaults)

+ (CGFloat)defaultStrongAlpha;
+ (CGFloat)defaultMiddleAlpha;
+ (CGFloat)defaultWeakAlpha;
+ (UIColor *)defaultOverlayBackgroundColor;

@end