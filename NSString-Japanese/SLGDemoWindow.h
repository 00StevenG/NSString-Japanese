//
//  SLGDemoWindow.h
//  NSString-Japanese
//
//  Created by Steven Grace on 8/28/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLGDemoWindow;

@protocol SLGDemoWindowDelegate <NSObject>

-(UIView*)viewForHitTest:(SLGDemoWindow*)window withPoint:(CGPoint)point event:(UIEvent*)event andOriginalView:(UIView*)originalView;



@end
@interface SLGDemoWindow : UIWindow

@property(nonatomic,readwrite,assign)id<SLGDemoWindowDelegate>hitTestDelegate;


@end
