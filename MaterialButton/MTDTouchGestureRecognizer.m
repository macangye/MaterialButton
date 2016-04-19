//
//  MTDTouchGestureRecognizer.m
//  MaterialButton
//
//  Created by gaobo on 16/4/19.
//  Copyright © 2016年 mcy. All rights reserved.
//

#import "MTDTouchGestureRecognizer.h"

@implementation MTDTouchGestureRecognizer

-(instancetype)init
{
    if(self = [super init]){
        self.cancelsTouchesInView = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.state != UIGestureRecognizerStateBegan){
        self.state = UIGestureRecognizerStateBegan;
        [self.touchDelegate touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.state = UIGestureRecognizerStateChanged;
    [self.touchDelegate touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged){
        self.state = UIGestureRecognizerStateEnded;
    }
    [self.touchDelegate touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged){
        self.state = UIGestureRecognizerStateEnded;
    }
    [self.touchDelegate touchesEnded:touches withEvent:event];
}

@end
