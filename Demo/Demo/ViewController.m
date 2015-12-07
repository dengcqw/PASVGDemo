//
//  ViewController.m
//  test
//
//  Created by pahf on 15/12/2.
//  Copyright © 2015年 平安好房. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "CGPathReader.h"
#import "NSString+Path.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DrawView * showView = [[DrawView alloc]initWithFrame:CGRectMake(10, 100, 400, 600)];
    [showView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:showView];
    
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 10;
    pathAnimation.repeatCount = 10;
    pathAnimation.autoreverses = YES;
    
    const char *path = [NSString spiral].UTF8String;
    
    NSError *__autoreleasing *error;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:CGPathCreateFromSVG(path, error)];
    pathAnimation.path = [bezierPath bezierPathByReversingPath].CGPath;
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, 20, 20)];
    [imageView setBackgroundColor:[UIColor blackColor]];
    [showView addSubview:imageView];
    
    [imageView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
