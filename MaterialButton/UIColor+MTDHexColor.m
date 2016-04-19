//
//  UIColor+HexColor.m
//  MaterialButton
//
//  Created by gaobo on 16/4/19.
//  Copyright © 2016年 mcy. All rights reserved.
//

#import "UIColor+MTDHexColor.h"

@implementation UIColor (MTDHexColor)

+ (UIColor *)colorHexRGBA:(NSString *)rgba {
    float red = 0.0;
    float green = 0.0;
    float blue = 0.0;
    float alpha = 1.0;
    
    if ([rgba hasPrefix:@"#"]) {
        NSString *hex = [rgba substringFromIndex:1];
        NSScanner *scanner = [NSScanner scannerWithString:hex];
        unsigned long long hexValue = 0;
        if ([scanner scanHexLongLong:&hexValue]) {
            switch (hex.length) {
                case 3:
                    red = ((hexValue & 0xF00) >> 8) / 15.0;
                    green = ((hexValue & 0x0F0) >> 4) / 15.0;
                    blue = (hexValue & 0x00F) / 15.0;
                    break;
                case 4:
                    red = ((hexValue & 0xF000) >> 12) / 15.0;
                    green = ((hexValue & 0x0F00) >> 8) / 15.0;
                    blue = ((hexValue & 0x00F0) >> 4) / 15.0;
                    alpha = (hexValue & 0x000F) / 15.0;
                    break;
                case 6:
                    red = ((hexValue & 0xFF0000) >> 16) / 255.0;
                    green = ((hexValue & 0x00FF00) >> 8) / 255.0;
                    blue = (hexValue & 0x0000FF) / 255.0;
                    break;
                case 8:
                    red = ((hexValue & 0xFF000000) >> 24) / 255.0;
                    green = ((hexValue & 0x00FF0000) >> 16) / 255.0;
                    blue = ((hexValue & 0x0000FF00) >> 8) / 255.0;
                    alpha = (hexValue & 0x000000FF) / 255.0;
                    break;
                default:
                    NSLog(
                          @"Invalid RGB string: '%@', number of characters after '#' should "
                          @"be " @"either 3, 4, 6 or 8",
                          rgba);
            }
        } else {
            NSLog(@"Scan hex error");
        }
    } else {
        NSLog(@"Invalid RGB string: '%@', missing '#' as prefix", rgba);
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorHexRGB:(NSString *)rgb withAlpha:(float)alpha {
    return [[self colorHexRGBA:rgb] colorWithAlphaComponent:alpha];
}


@end
