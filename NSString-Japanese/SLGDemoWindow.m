//
//  SLGDemoWindow.m
//  NSString-Japanese
//
//  Created by Steven Grace on 8/28/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "SLGDemoWindow.h"

@implementation SLGDemoWindow


-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
 
    UIView* original = [super hitTest:point withEvent:event];
    
    if([self.hitTestDelegate respondsToSelector:@selector(viewForHitTest:withPoint:event:andOriginalView:)])
        return [self.hitTestDelegate viewForHitTest:self withPoint:point event:event andOriginalView:original];
    
    
    return original;
}
@end
