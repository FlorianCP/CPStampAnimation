//
//  UIView+CPStampAnimation.h
//  CPStampAnimationDemo
//
//  Created by Florian Rath on 04.05.15.
//  Copyright (c) 2015 Codepool GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (CPStampAnimation)

- (void)cpsa_stampWithStampView:(UIView *)stampView location:(CGPoint)location;
+ (void)cpsa_stampHostView:(UIView *)hostView withStampView:(UIView *)stampView location:(CGPoint)location;

typedef void (^CPSA_OverdrawKeyframeBlock)();
- (void)cpsa_stampWithStampView:(UIView *)stampView location:(CGPoint)location overdrawKeyframeBlock:(CPSA_OverdrawKeyframeBlock)block;
+ (void)cpsa_stampHostView:(UIView *)hostView withStampView:(UIView *)stampView location:(CGPoint)location overdrawKeyframeBlock:(CPSA_OverdrawKeyframeBlock)block;

@end
