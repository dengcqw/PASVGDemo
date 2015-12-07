//
//  NSString+Path.m
//  test
//
//  Created by DengJinlong on 12/7/15.
//  Copyright © 2015 平安好房. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

+ (NSString *)svgDescForFile:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    
    NSString *pathSvgDesc = [NSString stringWithContentsOfFile:filePath encoding:(NSUTF8StringEncoding) error:nil];
    NSAssert(pathSvgDesc.length,@"read path error");
    return pathSvgDesc;
}

+ (NSString *)customeSvgPath {
    return [[self class] svgDescForFile:@"custom_path"];
}

+ (NSString *)spiral {
    return [[self class] svgDescForFile:@"svg_path_spiral"];
}

@end
