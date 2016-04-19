//
//  MTDRippleLayer.h
//  MaterialButton
//
//  Created by gaobo on 16/4/19.
//  Copyright © 2016年 mcy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface MTDRippleLayer : CALayer

@property(nonatomic) BOOL enableRipple;

@property(nonatomic,strong) UIColor *rippleColor;

- (instancetype)initWithSuperLayer:(CALayer *)superLayer;

- (instancetype)initWithSuperView:(UIView *)superView;

@end
NS_ASSUME_NONNULL_END
