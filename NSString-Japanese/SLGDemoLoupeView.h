//
//  SLGDemoLoupeView.h
//  NSString-Japanese
//
//  Created by Steven Grace on 8/28/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLGDemoLoupeView : UIView

@property(nonatomic,readwrite,weak)UIView* loupeContentView;
@property(nonatomic,readwrite,assign)CGRect loupeContentRect;
@property(nonatomic,readonly)CGSize glassSize;


@end
