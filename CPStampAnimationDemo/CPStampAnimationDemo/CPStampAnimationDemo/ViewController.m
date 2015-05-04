//
//  ViewController.m
//  CPStampAnimationDemo
//
//  Created by Florian Rath on 04.05.15.
//  Copyright (c) 2015 Codepool GmbH. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CPStampAnimation.h"
#import <AudioToolbox/AudioServices.h>


@interface ViewController ()

@end


@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup our touch recognizer
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDetected:)];
    [self.view addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (IBAction)touchDetected:(id)sender {
    UITapGestureRecognizer *recognizer = (UITapGestureRecognizer *)sender;
    CGPoint tapLocation = [recognizer locationInView:self.view];
    
    UIImage *image = [UIImage imageNamed:@"demo_stamp"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = (CGRect){ 0, 0, image.size.width, image.size.height };
    [self.view cpsa_stampWithStampView:imageView location:tapLocation overdrawKeyframeBlock:^{
        // Vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }];
}

@end
