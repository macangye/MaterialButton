//
//  UIColor+HexColor.h
//  MaterialButton
//
//  Created by gaobo on 16/4/19.
//  Copyright © 2016年 mcy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MTDHexColor)


+ (UIColor *)colorHexRGBA:(NSString *)rgba;

+ (UIColor *)colorHexRGB:(NSString *)rgb withAlpha:(float)alpha;


@end
