//
//  MTDRippleLayer.m
//  MaterialButton
//
//  Created by gaobo on 16/4/19.
//  Copyright © 2016年 mcy. All rights reserved.
//

#import "MTDRippleLayer.h"
#import "MTDTouchGestureRecognizer.h"

#define kMDScaleAnimationKey @"scale"
#define kMDPositionAnimationKey @"position"
#define kMDShadowAnimationKey @"shadow"

#define kMDRippleTransparent 0.5f
#define kMDBackgroundTransparent 0.3f
#define kMDElevationOffset 6
#define kMDClearEffectDuration .5f;

@interface MTDRippleLayer()<MTDTouchGestureRecognizerDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,weak) CALayer *superLayer;
@property(nonatomic,weak) UIView *superView;

@property(nonatomic,strong) CAShapeLayer *rippleLayer;
@property(nonatomic,strong) CAShapeLayer *backgroundLayer;
@property(nonatomic,strong) CAShapeLayer *maskLayer;

@end

@implementation MTDRippleLayer


- (instancetype)initWithSuperLayer:(CALayer *)superLayer
{
    if(self = [super init]){
        _superLayer = superLayer;
        [self initContents];
    }
    return self;
}

- (instancetype)initWithSuperView:(UIView *)superView
{
    if(self = [super init]){
        _superView = superView;
        _superLayer = superView.layer;
        MTDTouchGestureRecognizer *gr = [[MTDTouchGestureRecognizer alloc] init];
        gr.delegate = self;
        gr.touchDelegate = self;
        [superView addGestureRecognizer:gr];
        [self initContents];
    }
    return self;
}

- (void)initContents
{
    _rippleLayer = [[CAShapeLayer alloc] init];
    _rippleLayer.opacity = 0;
    [self addSublayer:_rippleLayer];
    
    _backgroundLayer = [[CAShapeLayer alloc] init];
    _backgroundLayer.opacity = 0;
    [self addSublayer:_backgroundLayer];
    
    _maskLayer = [[CAShapeLayer alloc] init];
    self.mask = _maskLayer;
    
    [_superLayer addSublayer:self];
    
    [self configContents];
}

- (void)setMaskLayerCornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    _maskLayer.path = path.CGPath;
    _backgroundLayer.path = path.CGPath;
//    _backgroundLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
}


- (void)configContents
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.frame = _superLayer.bounds;
    [self setMaskLayerCornerRadius:_superLayer.cornerRadius];
    [self configRippleLayer];
    [CATransaction commit];
}


- (void)configRippleLayer
{
    CGRect frame = _superLayer.bounds;
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    CGFloat diamater = sqrtf(width * width + height * height);
    
    _rippleLayer.bounds = CGRectMake(0, 0, diamater, diamater);
    _rippleLayer.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    NSLog(@" point :  %@",NSStringFromCGPoint(_rippleLayer.position));
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_rippleLayer.bounds];
    _rippleLayer.path = path.CGPath;
}


- (void)setRippleColor:(UIColor *)rippleColor
{
    _rippleColor = rippleColor;
    _rippleLayer.fillColor = [[rippleColor colorWithAlphaComponent:kMDRippleTransparent] CGColor];
    _backgroundLayer.fillColor = [[rippleColor colorWithAlphaComponent:kMDBackgroundTransparent] CGColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.allObjects[0] locationInView:_superView]; 
    [self startAnimAtLocation:point];
}

- (CGPoint)nearestInnerPoint:(CGPoint)point {
    CGFloat centerX = CGRectGetMidX(self.bounds);
    CGFloat centerY = CGRectGetMidY(self.bounds);
    double dx = (point.x - centerX);
    double dy = (point.y - centerY);
    double dist = sqrt(dx * dx + dy * dy);
    if (dist <= _rippleLayer.bounds.size.width / 2) {
        return point;
    } else {
        CGFloat d = _rippleLayer.bounds.size.width / (2 * dist);
        CGFloat x = centerX + d * (point.x - centerX);
        CGFloat y = centerY + d * (point.y - centerY);
        return CGPointMake(x, y);
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self stopAnim];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self stopAnim];
}


- (void)startAnimAtLocation:(CGPoint)point
{
    _rippleLayer.timeOffset = 0;
    _rippleLayer.speed = 1;
    
    self.opacity = 1;
    [self removeAllAnimations];
    [_rippleLayer removeAllAnimations];
    [_backgroundLayer removeAllAnimations];
    _rippleLayer.opacity = 1;
    _backgroundLayer.opacity = 1;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnim.fromValue = @(0);
    scaleAnim.toValue = @(1);
    scaleAnim.duration = 1;
    scaleAnim.delegate = self;
    
    ///是否从点击点开始动画，默认从中心开始
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _rippleLayer.position = point;
    [CATransaction commit];
    
    [_rippleLayer addAnimation:scaleAnim forKey:@"scale"];
}

- (void)stopAnim
{
    _rippleLayer.timeOffset = [_rippleLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    _rippleLayer.beginTime = CACurrentMediaTime();
    _rippleLayer.speed = 4;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(anim == [self animationForKey:@"opacityAnim"]){
        self.opacity = 0;
    }
    else if(flag){
        _rippleLayer.timeOffset = 0;
        _rippleLayer.speed = 1;
        
        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnim.fromValue = @(1.0f);
        opacityAnim.toValue = @(0.0f);
        opacityAnim.duration = kMDClearEffectDuration;
        opacityAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        opacityAnim.removedOnCompletion = false;
        opacityAnim.fillMode = kCAFillModeForwards;
        opacityAnim.delegate = self;
        
        [self addAnimation:opacityAnim forKey:@"opacityAnim"];
    }
}


@end
