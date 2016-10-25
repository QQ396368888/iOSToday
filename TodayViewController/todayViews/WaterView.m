//
//  WaterView.m
//  ecmc
//
//  Created by 王文杰 on 16/10/10.
//  Copyright © 2016年 cp9. All rights reserved.
//

#import "WaterView.h"
//屏幕宽高
#define XWSCREENW [UIScreen mainScreen].bounds.size.width
#define XWSCREENH [UIScreen mainScreen].bounds.size.height
@implementation WaterView{

    UIColor *_currentWaterColor;
    
    float _currentLinePointY;
    
    float a;
    float b;
    
    BOOL jia;

}

- (void)drawRect:(CGRect)rect {

    [self Createwater:rect];

}
- (id)initWithFrame:(CGRect)frame withHigh:(NSInteger)high
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0]];
        
        a = 1.5;
        b = 0;
        jia = NO;
        
        _currentWaterColor = [UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
        _currentLinePointY = high;
        _percent = 0.0;
        
        [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        
    }
    return self;
}
-(void)animateWave
{
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    
    b+=0.1;
    
    [self setNeedsDisplay];
}

- (void)Createwater:(CGRect)rect
{
    UIColor *blue = [UIColor colorWithRed:35/255.0 green:168/255.0 blue:254/255.0 alpha:1];//水的颜色
    
    UIColor *blueother =[UIColor colorWithRed:35/255.0 green:168/255.0 blue:254/255.0 alpha:0.5];//水面的颜色，请无视命名！！
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    
    [path moveToPoint:CGPointMake(0, _currentLinePointY)];
    _currentLinePointY = rect.size.height * (1 - _percent);
    float y=_currentLinePointY;
    if (isopen == YES) {
        
        [blue set];
        
        for(float x=0;x<=rect.size.width;x++){
            y= a * sin( x/180*M_PI + 4*b/M_PI ) * 3 + _currentLinePointY;
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }else{
        [blueother set];
        for(float x=0;x<=rect.size.width;x++){
            y= a * cos( x/180*M_PI + 4*b/M_PI ) * 3 + _currentLinePointY;
            [path addLineToPoint:CGPointMake(x, y )];
        }
    }
    
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [path addLineToPoint:CGPointMake(0, rect.size.height)];
    
    [path addLineToPoint:CGPointMake(0, _currentLinePointY)];
    
    [path fill];
}
- (void)setPercent:(float)percent
{
    _percent = percent;
    [self setNeedsDisplay];
}


@end
