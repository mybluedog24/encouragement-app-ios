//
//  AutoResizeUITextView.h
//  Encouragement
//
//  Created by Frank Chen on 2014-11-30.
//  Copyright (c) 2014 Frank Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoResizeUITextView : UITextView {
    NSString *inputText;
}
-(id)initWithFrame:(CGRect)frame String:(NSString *)str;
@end
