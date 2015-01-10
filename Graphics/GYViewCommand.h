//
//  GYViewCommand.h
//  Graphics
//
//  Created by myuon on 2015/01/10.
//  Copyright (c) 2015年 yasu. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class GYViewCommand
 */
@interface GYViewCommand : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) SEL showSelector;
@property (nonatomic, assign) SEL hideSelector;

+ (instancetype)commandWithName:(NSString *)name target:(UIView *)target showSelector:(SEL)showSelector hideSelector:(SEL)hideSelector;
+ (instancetype)commandWithTarget:(UIView *)target showSelector:(SEL)showSelector hideSelector:(SEL)hideSelector;

- (void)perform;

@end
