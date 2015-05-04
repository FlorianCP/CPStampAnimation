//
//  UIView+CPStampAnimation.m
//  CPStampAnimationDemo
//
//  Created by Florian Rath on 04.05.15.
//  Copyright (c) 2015 Codepool GmbH. All rights reserved.
//

#import "UIView+CPStampAnimation.h"

#include <stdlib.h>



#define CPSA_RADIANS_FROM_DEGREE(angle) ((angle) / 180.0 * M_PI)

float kCPSA_MaximumRandomAngle = 12.0;
float kCPSA_StampDownAnimationDuration = 0.12;
float kCPSA_StampMoveBackUpAnimationDuration = 0.03;


@implementation UIView (CPStampAnimation)

#pragma mark - Public

- (void)cpsa_stampWithStampView:(UIView *)stampView location:(CGPoint)location {
    
    NSParameterAssert(stampView);
    
    [UIView cpsa_stampHostView:self withStampView:stampView location:location overdrawKeyframeBlock:nil];
}

static CGAffineTransform kCPSA_OriginalTransformIncludingRandomRotation;

+ (void)cpsa_stampHostView:(UIView *)hostView withStampView:(UIView *)stampView location:(CGPoint)location {
    
    NSParameterAssert(hostView);
    NSParameterAssert(stampView);
    
    [UIView cpsa_stampHostView:hostView withStampView:stampView location:location overdrawKeyframeBlock:nil];
}

- (void)cpsa_stampWithStampView:(UIView *)stampView location:(CGPoint)location overdrawKeyframeBlock:(CPSA_OverdrawKeyframeBlock)block {
    
    NSParameterAssert(stampView);
    
    [UIView cpsa_stampHostView:self withStampView:stampView location:location overdrawKeyframeBlock:block];
}

+ (void)cpsa_stampHostView:(UIView *)hostView withStampView:(UIView *)stampView location:(CGPoint)location overdrawKeyframeBlock:(CPSA_OverdrawKeyframeBlock)block {
    
    NSParameterAssert(hostView);
    NSParameterAssert(stampView);
    
    // Calculate destination frame for stamp view
    CGRect destinationFrame = (CGRect){
        location.x - (stampView.bounds.size.width / 2.0),
        location.y - (stampView.bounds.size.height / 2.0),
        stampView.bounds.size.width,
        stampView.bounds.size.height
    };
    
    // Set destination frame for stamp view
    stampView.frame = destinationFrame;
    
    // Turn opacity down
    stampView.alpha = 0.0;
    
    // Calculate our rotation transform and combine it with our original transform
    CGFloat degree = arc4random_uniform(kCPSA_MaximumRandomAngle * 2) - kCPSA_MaximumRandomAngle + 360;
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(CPSA_RADIANS_FROM_DEGREE(degree));
    kCPSA_OriginalTransformIncludingRandomRotation = CGAffineTransformConcat(stampView.transform, rotationTransform);
    
    // Make stamp bigger to have it appear like it's above our host view
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1.4, 1.4);
    stampView.transform = CGAffineTransformConcat(kCPSA_OriginalTransformIncludingRandomRotation, scaleTransform);
    
    // Add stamp view to host view
    [hostView addSubview:stampView];
    
    // Begin our stamp down animation
    [stampView cpsa_animateStampDownWithOverdrawBlock:block];
}

#pragma mark - Private

- (void)cpsa_animateStampDownWithOverdrawBlock:(CPSA_OverdrawKeyframeBlock)block {
    
    // Animate stamp down
    [UIView animateWithDuration:kCPSA_StampDownAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         // Scale our stamp to make it smaller (with a slight overdraw)
                         CGAffineTransform scaleTransform = CGAffineTransformMakeScale(0.95, 0.95);
                         self.transform = CGAffineTransformConcat(kCPSA_OriginalTransformIncludingRandomRotation, scaleTransform);
                         self.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         
                         // Call our block if set
                         if (block) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 block();
                             });
                         }
                         
                         // Animate move up slightly
                         [self cpsa_animateMoveBackUp];
                     }];
}

- (void)cpsa_animateMoveBackUp {
    // Animate stamp down
    [UIView animateWithDuration:kCPSA_StampMoveBackUpAnimationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         // Scale our stamp to our original transform including our random rotation
                         self.transform = kCPSA_OriginalTransformIncludingRandomRotation;
                     }
                     completion:^(BOOL finished) {
                     }];
}

@end
