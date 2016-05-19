//
//  ViewController.m
//  Encouragement
//
//  Created by Frank Chen on 2014-11-26.
//  Copyright (c) 2014 Frank Chen. All rights reserved.
//

#import "ViewController.h"
#import "AutoResizeUITextView.h"

@interface ViewController ()

-(UIImage *)scaleImage:(UIImage *)image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //random seed
    srand((unsigned)time(0));
    //update string and pic by day
    [self update];
    //reading string and pic
    int num = [self loadIntWithKey:@"dailyNumber"];
    int num2 = [self loadIntWithKey:@"dailyStringNumber"];
    NSString *dailyString = [self readList:num2];
    NSString *imageName = [NSString stringWithFormat:@"baobao (%d).JPG", num];
    
    UIImage *testImage = [UIImage imageNamed:imageName];
    
    if (!testImage) {
        imageName = [NSString stringWithFormat:@"baobao (%d).jpg", num];
    }
    
    //setup pic
    UIImage *tempImage = [self scaleImage:[UIImage imageNamed:imageName]];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:tempImage];
    backgroundView.frame = CGRectMake(0,0,320,480);
    backgroundView.contentMode = UIViewContentModeCenter;
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:backgroundView];
    
    UITextView *textView = [[AutoResizeUITextView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) String:dailyString];
    [self.view addSubview:textView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)scaleImage:(UIImage *)image
{
    float scaleSize;
    if (480.0 / image.size.height > 320.0 / image.size.width) {
        scaleSize = 480.0 / image.size.height;
    }else{
        scaleSize = 320.0 / image.size.width;
    }
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
                                
    return scaledImage;
}


-(void)update
{
    int num = (int)(1 + (arc4random() % (410 - 1 + 1)));
    int num2 = (int)(0 + (arc4random() % (231 - 0 + 1)));
    NSInteger day = [self loadIntWithKey:@"day"];
    if (day) {
        if ((int)day != self.getCurrentDay) {
            [self saveInt:num key:@"dailyNumber"];
            [self saveInt:num2 key:@"dailyStringNumber"];
            [self saveInt:self.getCurrentDay key:@"day"];
        }
    }else{
        [self saveInt:self.getCurrentDay key:@"day"];
        [self saveInt:num key:@"dailyNumber"];
        [self saveInt:num2 key:@"dailyStringNumber"];
    }
}

- (NSInteger)getCurrentDay
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    //NSInteger month = [components month];
    //NSInteger year = [components year];
    return day;
}

#pragma mark -
#pragma mark === Save/Load Data ===

- (void)saveInt:(int)aNumber key:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setInteger:aNumber forKey:key];
    
}

- (int)loadIntWithKey:(NSString *)key {
    NSInteger aNumber = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    return aNumber;
}

#pragma mark -
#pragma mark === Load From Plist ===

-(NSString *)readList:(int)index
{
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"LIZHI" ofType:@"plist"];
    
    // Build the array from the plist
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSString *temp = [data objectAtIndex:index];
    return temp;
}

@end
