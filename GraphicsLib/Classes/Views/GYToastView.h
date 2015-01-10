//
//  GYToastView.h
//  Timer
//
//  Created by myuon on 2014/12/26.
//  Copyright (c) 2014年 yasu. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSTimeInterval const GYToastViewDurationShort;
extern NSTimeInterval const GYToastViewDurationLong;

@interface GYToastView : UIView

@property (nonatomic, strong) NSString *message;
@property (assign) NSTimeInterval duration;
@property (assign) NSTimeInterval animationDuration;
@property (assign) CGFloat maximumAlpha;

+ (instancetype)toastViewWithMessage:(NSString *)message duration:(NSTimeInterval)duration;

+ (void)showToastViewWithMessage:(NSString *)message duration:(NSTimeInterval)duration;

- (void)show;
- (void)hide;

@end
