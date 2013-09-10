//
//  SLGDemoLoupeView.m
//  NSString-Japanese
//
//  Created by Steven Grace on 8/28/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "SLGDemoLoupeView.h"

@implementation SLGDemoLoupeView{
    
    UIImageView* _glassView;
        
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        _glassView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loupeGlass"]];
        _glassView.contentMode = UIViewContentModeTopLeft;
        [self addSubview:_glassView];
    }
    return self;
}
-(CGSize)glassSize{
    return _glassView.image.size;
}
-(void)layoutSubviews{

    [super layoutSubviews];
    _glassView.frame= self.bounds;
}
- (void)drawRect:(CGRect)rect {
    
    if(!_loupeContentView)
        return;

	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context,rect);

    UIBezierPath* bPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect,7,7)];

	CGContextAddPath(context,bPath.CGPath);
    CGContextClip(context);
    
	CGContextTranslateCTM(context, -_loupeContentRect.origin.x, -_loupeContentRect.origin.y);
    
	[_loupeContentView.layer renderInContext:context];
    
}

@end
