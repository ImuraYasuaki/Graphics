//
//  GYViewCommand.m
//  Graphics
//
//  Created by myuon on 2015/01/10.
//  Copyright (c) 2015年 yasu. All rights reserved.
//

#import "GYViewCommand.h"

/*!
 @class GYViewInstanceCommand
 @abstract ビューインスタンスと、コマンドを保持するクラス
 */
@interface GYViewInstanceCommand : GYViewCommand

@property (nonatomic, strong) UIView *target;

+ (instancetype)commandWithTarget:(UIView *)target showSelector:(SEL)showSelector hideSelector:(SEL)hideSelector;

@end

/*!
 @class GYViewClassCommand
 @abstract ビュークラスと、コマンドを保持するクラス
 @interface GYViewClassCommand : GYViewInstanceCommand
 
 @property (nonatomic, assign) Class targetClass;
 
 + (instancetype)commandWithTargetClass:(Class)target showSelector:(SEL)showSelector hideSelector:(SEL)hideSelector;
 
 @end
 */

@interface GYViewCommand ()
@property (assign, getter=isShowing) BOOL showing;
+ (instancetype)commandWithShowSelector:(SEL)showSelector hideSelector:(SEL)hideSelector;
- (void)show;
- (void)hide;
@end

@implementation GYViewCommand

+ (instancetype)commandWithName:(NSString *)name target:(UIView *)target showSelector:(SEL)showSelector hideSelector:(SEL)hideSelector {
    GYViewInstanceCommand *command = [GYViewInstanceCommand commandWithTarget:target showSelector:showSelector hideSelector:hideSelector];
    [command setName:name];

    return command;
}

+ (instancetype)commandWithTarget:(UIView *)target showSelector:(SEL)showSelector hideSelector:(SEL)hideSelector {
    return [self commandWithName:nil target:target showSelector:showSelector hideSelector:hideSelector];
}

+ (instancetype)commandWithShowSelector:(SEL)showSelector hideSelector:(SEL)hideSelector {
    GYViewCommand *command = [[GYViewCommand alloc] init];
    if (command) {
        [command setShowSelector:showSelector];
        [command setHideSelector:hideSelector];
        [command setShowing:NO];
    }
    return command;
}

- (void)perform {
    [self setShowing:![self isShowing]];

    if ([self isShowing]) {
        [self show];
    } else {
        [self hide];
    }
}

- (void)show {
    NSAssert(NO, @"cannot perform!");
}

- (void)hide {
    NSAssert(NO, @"cannot perform!");
}

@end

@implementation GYViewInstanceCommand
+ (instancetype)commandWithTarget:(UIView *)target showSelector:(SEL)showSelector hideSelector:(SEL)hideSelector {
    GYViewInstanceCommand *command = [[GYViewInstanceCommand alloc] init];
    if (command) {
        [command setTarget:target];
        [command setShowSelector:showSelector];
        [command setHideSelector:hideSelector];
    }
    return command;
}

- (NSString *)name {
    NSString *name = [super name];
    return name.length > 0 ? name : NSStringFromClass([self.target class]);
}

- (void)show {
    [self.target performSelector:self.showSelector onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
}

- (void)hide {
    [self.target performSelector:self.hideSelector onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
}

@end

/*!
@implementation GYViewClassCommand
+ (instancetype)commandWithTargetClass:(Class)target showSelector:(SEL)showSelector hideSelector:(SEL)hideSelector {
    GYViewClassCommand *command = [[GYViewClassCommand alloc] init];
    if (command) {
        [command setTargetClass:target];
        [command setShowSelector:showSelector];
        [command setHideSelector:hideSelector];
    }
    return command;
}

- (NSString *)name {
    NSString *name = [super name];
    return name.length > 0 ? name : NSStringFromClass(self.targetClass);
}

@end
*/
