//
//  TimePickerView.m
//  LGM Solution
//
//  Created by Phan Minh Tam on 5/6/15.
//  Copyright (c) 2015 Phan Minh Tam. All rights reserved.
//

#import "DatePickerView.h"
#import "Define.h"
#import "ActionSheetDatePicker.h"

@implementation DatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithRect:(CGRect)rect label:(NSString*)label{
    if (self = [super initWithFrame:rect]){
        [self setFrame:rect];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        lbel = label;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
        dateSelected = [dateFormatter stringFromDate:[NSDate date]];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(alignLeft, 0, rect.size.width-2*alignLeft, heightOfTextField)];
        [lb setText:label];
        
        UIFont *font = lb.font;
        UIFontDescriptor * fontD = [font.fontDescriptor
                                    fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
        font = [UIFont fontWithDescriptor:fontD size:15];
        [lb setFont:font];
        [lb setTextColor:colorLabel];
        [self addSubview:lb];
        
        lbValue = [[UILabel alloc] initWithFrame:CGRectMake(alignLeft, lb.frame.size.height+5, rect.size.width-100, heightOfTextField)];
        [lbValue setText:@"No date available"];
        UIFont *f = lbValue.font;
        f = [UIFont fontWithName:f.fontName size:14];
        [lbValue setFont:f];
        [lbValue setTextColor:[UIColor redColor]];
        [self addSubview:lbValue];
        
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(lbValue.frame.origin.x+lbValue.frame.size.width+10, lbValue.frame.origin.y, 50, heightOfTextField)];
        [bt setTitle:@"SET" forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bt setBackgroundImage:[UIImage imageNamed:@"bt_reset.png"] forState:UIControlStateNormal];
        [bt addTarget:self  action:@selector(myAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bt];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(2*alignLeft, lbValue.frame.origin.y+lbValue.frame.size.height + alignBottom*2, rect.size.width-4*alignLeft, 1.5)];
        [line setBackgroundColor:[UIColor blueColor]];
        [line setAlpha:0.5];
        [self addSubview:line];
    }
    return  self;
}
-(void)myAction{
    [self.superview endEditing:YES];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy";
    [ActionSheetDatePicker showPickerWithTitle:lbel datePickerMode:UIDatePickerModeDate selectedDate:[dateFormatter dateFromString:dateSelected] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        [lbValue setText:[dateFormatter stringFromDate:selectedDate]];
        dateSelected = [dateFormatter stringFromDate:selectedDate];
        [_delegate clickSetDate:[dateFormatter stringFromDate:selectedDate] view:self];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:self];
}
@end
