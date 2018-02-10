//
//  CustomLineView.m
//  Zdaly
//
//  Created by AAA on 2017. 9. 30..
//  Copyright © 2017년 com. All rights reserved.
//

#import "CustomLineView.h"

@implementation CustomLineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    NSValue *startPointVal = [self.pointArr objectAtIndex:1];
    CGPoint startPoint = [startPointVal CGPointValue];
    [path moveToPoint:startPoint];
    
    for(int i = 2; i < self.pointArr.count - 1; i++) {
        NSValue *pointValue = [self.pointArr objectAtIndex:i];
        CGPoint point = [pointValue CGPointValue];
        [path addLineToPoint:point];
    }
    UIColor *lineColor = [self.color colorWithAlphaComponent:self.lineAlpha];
    [lineColor setStroke];
    [path stroke];
    
    NSValue *lastPointValue = [self.pointArr lastObject];
    [path addLineToPoint: [lastPointValue CGPointValue]];
    
    NSValue *firstPointValue = [self.pointArr firstObject];
    [path addLineToPoint: [firstPointValue CGPointValue]];
    
    UIColor *fillColor = [self.color colorWithAlphaComponent:self.fillAlpha * self.fillAlpha * self.fillAlpha];
    [fillColor setFill];
    [path fill];
}

- (id) initWithPointArrayAndFrame: (NSMutableArray *)pointArr frame:(CGRect)rect color:(UIColor*)color lineAlpha:(CGFloat)lineAlpha fillAlpha:(CGFloat)fillAlpha {
    _pointArr = pointArr;
    _color = color;
    _lineAlpha = lineAlpha;
    _fillAlpha = fillAlpha;
    
    self = [super initWithFrame:rect];
    if(!self) {
        return nil;
    }
    
    return self;
}
@end
