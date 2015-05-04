//
//  UIView+CPStampAnimation.h
//  CPStampAnimationDemo
//
//  Created by Florian Rath on 04.05.15.
//  Copyright (c) 2015 Codepool GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (CPStampAnimation)

/**
 *  Stamps the view with a given stamp view.
 *  A random rotation will be applied to the stamp view to give it a more natural effect.
 *  Also the stamp view will be added to the host view, so you shouldn't call addSubview in advance.
 *
 *  @param stampView The view that should be stamped on the host view.
 *  @param location  The location the stamp should be centered on.
 */
- (void)cpsa_stampWithStampView:(UIView *)stampView location:(CGPoint)location;

/**
 *  Stamps the view with a given stamp view.
 *  A random rotation will be applied to the stamp view to give it a more natural effect.
 *  Also the stamp view will be added to the host view, so you shouldn't call addSubview in advance.
 *
 *  @param hostView  The view that should receive the stamp.
 *  @param stampView The view that should be stamped on the host view.
 *  @param location  The location the stamp should be centered on.
 */
+ (void)cpsa_stampHostView:(UIView *)hostView withStampView:(UIView *)stampView location:(CGPoint)location;

typedef void (^CPSA_OverdrawKeyframeBlock)();

/**
 *  Stamps the view with a given stamp view.
 *  A random rotation will be applied to the stamp view to give it a more natural effect.
 *  Also the stamp view will be added to the host view, so you shouldn't call addSubview in advance.
 *
 *  @param stampView The view that should be stamped on the host view.
 *  @param location  The location the stamp should be centered on.
 *  @param block     The block that will be called when the stamp hits the host view. You can use this block to e.g. vibrate or play a sound.
 */
- (void)cpsa_stampWithStampView:(UIView *)stampView location:(CGPoint)location overdrawKeyframeBlock:(CPSA_OverdrawKeyframeBlock)block;

/**
 *  Stamps the view with a given stamp view.
 *  A random rotation will be applied to the stamp view to give it a more natural effect.
 *  Also the stamp view will be added to the host view, so you shouldn't call addSubview in advance.
 *
 *  @param hostView  The view that should receive the stamp.
 *  @param stampView The view that should be stamped on the host view.
 *  @param location  The location the stamp should be centered on.
 *  @param block     The block that will be called when the stamp hits the host view. You can use this block to e.g. vibrate or play a sound.
 */
+ (void)cpsa_stampHostView:(UIView *)hostView withStampView:(UIView *)stampView location:(CGPoint)location overdrawKeyframeBlock:(CPSA_OverdrawKeyframeBlock)block;

@end
