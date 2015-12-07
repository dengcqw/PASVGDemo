//
//  DrawView.m
//  test
//
//  Created by pahf on 15/12/4.
//  Copyright © 2015年 平安好房. All rights reserved.
//

#import "DrawView.h"
#import "CGPathReader.h"
#import "NSString+Path.h"


@implementation DrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    
    UIColor * color = [UIColor redColor];
    
    [color set];
    
    const char *path = [NSString spiral].UTF8String;
    NSError *__autoreleasing *error;
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
    
    UIBezierPath * bezierPth = [UIBezierPath bezierPathWithCGPath:CGPathCreateMutableCopyByTransformingPath(CGPathCreateFromSVG(path, error), &transform)];
    bezierPth.lineWidth = 2.0;
    [bezierPth stroke];
    
    UIBezierPath * pointPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, 20, 20)];
    pointPath.lineWidth = 5.0;
    [pointPath fill];
}


@end
