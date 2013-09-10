//
//  SLGViewController.m
//  NSString-Japanese
//
//  Created by Steven Grace on 4/19/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "SLGViewController.h"
#import "NSString+Japanese.h"
#import "SLGDemoWindow.h"
#import "SLGDemoLoupeView.h"

@interface SLGViewController ()<UITextViewDelegate,SLGDemoWindowDelegate,UIGestureRecognizerDelegate>

@end

@implementation SLGViewController{
    
    SLGDemoLoupeView* _loupeView;
    
    CAShapeLayer* _textViewSelectionLayer;
    CAShapeLayer* _outputSelectionLayer;
}

#pragma mark - Rotation
-(BOOL)shouldAutorotate{
    return NO;
}
#pragma mark - View Lifecycle
//
//
//
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    _textViewSelectionLayer = [CAShapeLayer layer];
    _textViewSelectionLayer.backgroundColor = [UIColor clearColor].CGColor;
    _textViewSelectionLayer.fillColor = [UIColor colorWithRed:0.788 green:0.867 blue:0.937 alpha:.75].CGColor;
    [self.visibleTextView.layer addSublayer:_textViewSelectionLayer];
    
    
    _outputSelectionLayer = [CAShapeLayer layer];
    _outputSelectionLayer.backgroundColor = [UIColor clearColor].CGColor;
    _outputSelectionLayer.fillColor = [UIColor colorWithRed:0.788 green:0.867 blue:0.937 alpha:.75].CGColor;
    [self.secretTextView.layer addSublayer:_outputSelectionLayer];
    
    _loupeView = [[SLGDemoLoupeView alloc]initWithFrame:CGRectZero];
    _loupeView.hidden = YES;
    _loupeView.loupeContentView = self.secretTextView;
    [self.view addSubview:_loupeView];
    
    UILongPressGestureRecognizer* press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(_handlePress:)];
    press.delegate = self;
    [self.view addGestureRecognizer:press];
    
    self.visibleTextView.editable = NO;
    self.editableSwitch.on = NO;
    
    self.visibleTextView.delegate = self;
    
    NSString *jaText = @"『もののけ姫』（もののけひめ）は、宮崎駿によるスタジオジブリの長編アニメーション映画作品。1997年（平成9年）7月12日公開。森を侵す人間たちとあらぶる神々との対立を背景として、狼に育てられた「もののけ姫」と呼ばれる少女サンとアシタカとの出会いを描く。宮崎が構想16年、制作に3年をかけた大作であり、興行収入193億円を記録し当時の日本映画の興行記録を塗り替えた";

    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc]initWithString:jaText];
    
    NSParagraphStyle* style = [NSParagraphStyle defaultParagraphStyle];
    
    [attString addAttribute:NSParagraphStyleAttributeName
                      value:style
                      range:NSMakeRange(0,[attString length])];
    

    NSMutableAttributedString* convertedAttString =
    [[NSMutableAttributedString alloc]initWithString:[jaText stringByReplacingJapaneseKanjiWithHiragana]];
    
    [convertedAttString addAttribute:NSParagraphStyleAttributeName
                      value:style
                      range:NSMakeRange(0,[convertedAttString length])];
    
    self.visibleTextView.attributedText = attString;

    self.secretTextView.attributedText =convertedAttString;
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [(SLGDemoWindow*)self.view.window setHitTestDelegate:self];
    
}
#pragma mark - Actions
-(IBAction)editableSwitchAction:(UISwitch*)sender{
    
    self.visibleTextView.editable = sender.on;
    
    if(sender.on)
        [_languageLoupeSwitch setOn:NO animated:YES];
    
}
-(IBAction)languageLoupeSwitchAction:(UISwitch*)sender{
    
    _segementedControl.enabled = sender.on;
    
    
    if(sender.on)
        [self.visibleTextView setSelectedRange:NSMakeRange(0,0)];
    
    
}
#pragma mark - Window HitTestDelegate

-(UIView*)viewForHitTest:(SLGDemoWindow*)window withPoint:(CGPoint)point event:(UIEvent*)event andOriginalView:(UIView*)originalView{
    
    if(self.visibleTextView.editable)
        return originalView;
    
    if(!_languageLoupeSwitch.on)
        return originalView;
    
    if([originalView isDescendantOfView:self.visibleTextView]){
        return self.view;
    }
    return originalView;
}

#pragma mark - Gesture Recognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return _languageLoupeSwitch.on;
    
}
#pragma mark - Gesture Handler
-(void)_handlePress:(UILongPressGestureRecognizer*)press{
    
  //  NSLog(@"%s",__PRETTY_FUNCTION__);
    CGPoint point = [press locationInView:self.visibleTextView];
    point.y  = point.y -40;
    
    switch (press.state) {
        case UIGestureRecognizerStateBegan:
            [self _presentLoupeAtPoint:point];
            break;
        case UIGestureRecognizerStateChanged:
            [self _updateLoupeWithPoint:point];
            break;
        case UIGestureRecognizerStateEnded:
            [self _dismissLoupe];
            break;
        default:
            break;
    }

}
#pragma mark - Language Conversion
-(void)_updateSecretTextViewTextWithRange:(NSRange)range convertedRange:(NSRange*)convertedRange{
    
    
    NSString* selectedString = [self.visibleTextView.text substringWithRange:range];
    NSString* convertedString = nil;
    
    
    switch ([self.segementedControl selectedSegmentIndex]) {
        case 0:
            convertedString = [selectedString stringByTransliteratingJapaneseToRomajiWithWordSeperator:@" "];
            break;
        case 1:
            convertedString= [selectedString stringByReplacingJapaneseKanjiWithHiragana];
            break;
        default:{
            [NSException raise:NSInternalInconsistencyException
                        format:@"Unhandled case in %s",__PRETTY_FUNCTION__];
        }
            break;
    }
    
    NSMutableAttributedString* mString = [[NSMutableAttributedString alloc]initWithAttributedString:self.visibleTextView.attributedText];
    [mString replaceCharactersInRange:range withString:convertedString];
    
    self.secretTextView.attributedText = mString;
    
    
    
    SLGJapaneseStringType type = [NSString japaneseStringTypeForString:selectedString];
    
    switch (type) {
        case SLGJapaneseStringTypeHiragana:
            self.selectedTextLabel.text = @"Hiragana";
            break;
        case SLGJapaneseStringTypeKanji:
            self.selectedTextLabel.text = @"Kanji";
            break;
        case SLGJapaneseStringTypeKatakana:
            self.selectedTextLabel.text = @"Katakana";
            break;
        case SLGJapaneseStringTypeCompound:
            self.selectedTextLabel.text = @"Compound";
            break;
        case SLGJapaneseStringTypeOther:
            self.selectedTextLabel.text = @"Other";
            break;
            
        default:{
            [NSException raise:NSGenericException
                        format:@"Unhandled case in :%s",__PRETTY_FUNCTION__];
        }
            break;
    }
    
    convertedRange->location = range.location;
    convertedRange->length = [convertedString length];
    
}
#pragma mark Loupe
-(void)_presentLoupeAtPoint:(CGPoint)point{

    _loupeView.hidden =NO;
    _textViewSelectionLayer.frame = self.visibleTextView.bounds;
    _outputSelectionLayer.frame = self.secretTextView.bounds;
    
    
    [self _updateLoupeWithPoint:point];

    _outputSelectionLayer.hidden = NO;
    _textViewSelectionLayer.hidden = NO;
    [self.visibleTextView.layer insertSublayer:_textViewSelectionLayer atIndex:0];
    [self.secretTextView.layer insertSublayer:_outputSelectionLayer atIndex:0];


}
-(void)_updateLoupeWithPoint:(CGPoint)point{

    
    UITextPosition* pos = [self.visibleTextView closestPositionToPoint:point];
    
    id<UITextInputTokenizer> tokenizer =self.visibleTextView.tokenizer;
    UITextRange* textRange =
    [tokenizer rangeEnclosingPosition:pos
                      withGranularity:UITextGranularityWord
                          inDirection:UITextWritingDirectionLeftToRight];
    
    if(!textRange)
        return;
    
    NSRange wordRange = [[self class] rangeForTextRange:textRange inTextView:self.visibleTextView];
    


    CGRect caretRect= [self.visibleTextView caretRectForPosition:pos];
    
    CGRect loupeFrame;
    loupeFrame.size = _loupeView.glassSize;
    loupeFrame.origin = [self.view convertPoint:caretRect.origin fromView:self.visibleTextView];
    loupeFrame = CGRectOffset(loupeFrame,-loupeFrame.size.width/2,(-loupeFrame.size.height+10));
    

    
    NSRange convertedRange;
    [self _updateSecretTextViewTextWithRange:wordRange convertedRange:&convertedRange];
    
    
    UIBezierPath* magnifyPath = [[self class]pathForRange:convertedRange inTextView:self.secretTextView];
    CGRect rectToMagnify;
    rectToMagnify.size =_loupeView.glassSize;
    rectToMagnify.origin = CGPathGetBoundingBox(magnifyPath.CGPath).origin;
    rectToMagnify  = CGRectOffset(rectToMagnify,-rectToMagnify.size.width/2,(-rectToMagnify.size.height/2.5));
    

    [CATransaction setDisableActions:YES];
    _textViewSelectionLayer.path = [[self class]pathForRange:wordRange inTextView:self.visibleTextView].CGPath;
    _outputSelectionLayer.path = magnifyPath.CGPath;
    [CATransaction commit];


    _loupeView.loupeContentRect = rectToMagnify;
    _loupeView.frame =loupeFrame;
    [_loupeView setNeedsDisplay];
    

    
}
-(void)_dismissLoupe{
    
    _loupeView.hidden = YES;
    _outputSelectionLayer.hidden = YES;
    _textViewSelectionLayer.hidden = YES;

    self.secretTextView.attributedText = self.visibleTextView.attributedText;
    
}
#pragma mark - Text Conversions and Paths
+(NSRange)rangeForTextRange:(UITextRange*)textRange inTextView:(UITextView*)textView{
    
    NSUInteger location =[textView offsetFromPosition:textView.beginningOfDocument
                                       toPosition:textRange.start];
    
    NSUInteger length = [textView offsetFromPosition:textRange.start toPosition:textRange.end];
    return NSMakeRange(location,length);
}
+(UITextRange*)textRangeForRange:(NSRange)range inTextView:(UITextView*)textView{
        
    UITextPosition* startPos = [textView positionFromPosition:textView.beginningOfDocument
                                              inDirection:UITextLayoutDirectionRight
                                                   offset:range.location];
    
    UITextPosition* endPos = [textView positionFromPosition:textView.beginningOfDocument
                                            inDirection:UITextLayoutDirectionRight
                                                 offset:(range.location+range.length)];
    
    UITextRange* textRange = [textView textRangeFromPosition:startPos toPosition:endPos];
    return textRange;
}
+(CGRect)rectForWordRange:(NSRange)range inTextView:(UITextView*)textView{
    
    NSArray* selectionRects = [textView selectionRectsForRange:[self textRangeForRange:range inTextView:textView]];
    UIBezierPath* bPath = [UIBezierPath bezierPath];
    for(UITextSelectionRect* aRect in selectionRects){
        [bPath appendPath:[UIBezierPath bezierPathWithRect:aRect.rect]];
    }
    return CGPathGetBoundingBox(bPath.CGPath);
}
+(UIBezierPath*)pathForRange:(NSRange)range inTextView:(UITextView*)textView{
    
    NSArray* selectionRects = [textView selectionRectsForRange:[self textRangeForRange:range inTextView:textView]];
    UIBezierPath* bPath = [UIBezierPath bezierPath];
    for(UITextSelectionRect* aRect in selectionRects){        
        [bPath appendPath:[UIBezierPath bezierPathWithRect:aRect.rect]];
    }
    return bPath;
}
+(NSRange)rangeOfSubstringRangeBoundByRect:(CGRect)rect inTextView:(UITextView*)textView{
    
    
    UITextPosition* start = [textView closestPositionToPoint:rect.origin];
    UITextPosition* end =
    [textView closestPositionToPoint:CGPointMake(CGRectGetMaxX(rect),CGRectGetMaxY(rect))];
    
    NSRange  range =
     NSMakeRange([textView offsetFromPosition:textView.beginningOfDocument toPosition:start],
                       [textView offsetFromPosition:start toPosition:end]);
    
    return range;
    
}

@end
