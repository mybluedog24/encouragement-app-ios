//
//  AutoResizeUITextView.m
//  Encouragement
//
//  Created by Frank Chen on 2014-11-30.
//  Copyright (c) 2014 Frank Chen. All rights reserved.
//

#import "AutoResizeUITextView.h"

@implementation AutoResizeUITextView

-(id)initWithFrame:(CGRect)frame String:(NSString *)str
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
        inputText = str;
        [self initialize];
        [self resize];
    }
    return self;
}

-(void)initialize {
    
    //setup text
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6f];
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 10.0f;
    self.font = [UIFont boldSystemFontOfSize:14];
    self.text = inputText;
}

// auto height, fixed at buttom
-(void)resize {
    //auto resize UITextView
    CGSize constraintSize;
    constraintSize.width = 280;
    constraintSize.height = MAXFLOAT;
    CGSize sizeFrame =[inputText sizeWithFont:self.font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    self.frame = CGRectMake(20,480-40-sizeFrame.height,280,sizeFrame.height+20);
}

@end
