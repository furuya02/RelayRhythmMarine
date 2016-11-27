//
//  UIColor+ColorExtensions.m
//  RelayRhythmMarine
//
//  Created by hirauchi.shinichi on 2016/11/26.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+ColorExtensions.h"

@implementation UIColor (ColorExtensions)

+ (UIColor *) lightColor
{
    return [UIColor colorWithRed:0.91 green:0.11 blue:0.38 alpha:1.0];
}

+ (UIColor *) darkColor
{
    return [UIColor colorWithRed:0.21 green:0.24 blue:0.28 alpha:1.0];
}

+ (UIColor *) activeColor
{
    return [UIColor colorWithRed:0.95 green:0.26 blue:0.21 alpha:0.4];
}

+ (UIColor *) darkBlinkColor
{
    return [UIColor colorWithRed:0.41 green:0.44 blue:0.48 alpha:1.0];
}

+ (UIColor *) activeBlinkColor
{
    return [UIColor colorWithRed:0.95 green:0.26 blue:0.21 alpha:1.0];
}

@end

