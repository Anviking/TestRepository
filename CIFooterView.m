//
//  CIFooterViewController.m
//  iGitpad
//
//  Created by Johannes Lund on 2011-11-20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//Test test 4

#import "CIFooterView.h"
#import "SettingsTableController.h"
#import <QuartzCore/QuartzCore.h>
#import "CIStepperTableViewCell.h"
#import "AppDelegate.h"

@interface CIFooterView (private)
@end
    
@implementation CIFooterView
@synthesize settingsPanel = _settingsPanel;
@synthesize settingsPopup = _settingsPopup;
@synthesize popupIsVisible = _popupIsVisible;
@synthesize ArrowButton = _ArrowButton;
@synthesize UserButton = _UserButton;
@synthesize settingsButton = _settingsButton;
@synthesize ST = _ST;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"footer.png"]];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.settingsButton.frame = CGRectMake(909, 8, 95, 40);
        [self.settingsButton setBackgroundImage:[UIImage imageNamed:@"settingsbutton.png"] forState:UIControlStateNormal];
        [self.settingsButton setBackgroundImage:[UIImage imageNamed:@"settingsbuttondown.png"] forState:UIControlStateHighlighted];
        [self.settingsButton addTarget:self action:@selector(settingButtonWasPushed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.settingsButton];
        [self UserButton];
        [self ArrowButton];
        
        
    }
    return self;
}

- (SettingsController *)ST {
    
    if (!_ST) _ST = [(AppDelegate *)[[UIApplication sharedApplication] delegate] settingsController];
    
    return _ST;
}


- (UIButton *)UserButton {
    if (!_UserButton) {
        _UserButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _UserButton.frame = CGRectMake(8, 10, 138, 39);
        [_UserButton setBackgroundImage:[UIImage imageNamed:@"User"] forState:UIControlStateNormal];
        [_UserButton setBackgroundImage:[UIImage imageNamed:@"UserDown"] forState:UIControlStateHighlighted];
        [self addSubview:_UserButton];
    }
    return _UserButton;
}

- (UIButton *)ArrowButton {
    if (!_ArrowButton) {
        _ArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _ArrowButton.frame = CGRectMake(8+138, 12, 35, 36);
        [_ArrowButton setBackgroundImage:[UIImage imageNamed:@"Arrow"] forState:UIControlStateNormal];
        [_ArrowButton setBackgroundImage:[UIImage imageNamed:@"Arrow"] forState:UIControlStateHighlighted];
        [self addSubview:_ArrowButton];
    }
    return _ArrowButton;
}

- (void)settingButtonWasPushed {
    
    if (self.settingsPanel == nil) {
        self.settingsPanel = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[SettingsControllerStorageObject numberChangableInSettingsWithKey:@"SettingsPopupWidth" title:@"SWidth" startValueIfNoOtherIsStored:300 maxValue:1000 MinValue:0 stepValue:10 andTarget:self readonly:NO] floatValue], [[SettingsControllerStorageObject numberChangableInSettingsWithKey:@"SettingsPopupHeight" title:@"SHeight" startValueIfNoOtherIsStored:400 maxValue:1000 MinValue:0 stepValue:10 andTarget:self readonly:NO] floatValue]) style:UITableViewStylePlain];
        
        //SettingsTableController*controller = [[SettingsTableController alloc] init];
                
        self.settingsPanel.layer.cornerRadius = 3;
        self.settingsPanel.layer.borderWidth = 1;
        self.settingsPanel.delegate = self;
        self.settingsPanel.dataSource = self;
        self.settingsPanel.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    }
    if (self.settingsPopup == nil) { 
        self.settingsPopup = [[CIPopupView alloc] initWithCustomView:self.settingsPanel];
        self.settingsPopup.arrowAdjustmentPosition = [[SettingsControllerStorageObject numberChangableInSettingsWithKey:@"Arrow_X_Adjustment" title:@"ArrowX" startValueIfNoOtherIsStored:116 maxValue:300 MinValue:-300 stepValue:1 andTarget:self readonly:NO] floatValue];
        
        CGRect rect = self.settingsPopup.frame;
        rect.origin.x = 1020-self.settingsPopup.frame.size.width;
        rect.origin.y = 700-self.settingsPopup.frame.size.height;
        
        self.settingsPopup.frame = rect;
        [self.superview addSubview:self.settingsPopup];
        self.settingsPopup.hidden = TRUE;
    }
    
    if (self.popupIsVisible == FALSE) {
        self.settingsPopup.hidden = FALSE;
        self.popupIsVisible = YES;
    }
    else {
        self.settingsPopup.hidden = TRUE;
        self.popupIsVisible = FALSE;
    }
    
    
}

- (void)valueFromSettingsControllerHasChanged {
    
    self.settingsPopup.arrowAdjustmentPosition = [[SettingsControllerStorageObject numberChangableInSettingsWithKey:@"Arrow_X_Adjustment" title:@"ArrowX" startValueIfNoOtherIsStored:116 maxValue:300 MinValue:-300 stepValue:1 andTarget:self readonly:TRUE] floatValue];
    
    self.settingsPanel.frame = CGRectMake(0, 0, [[SettingsControllerStorageObject numberChangableInSettingsWithKey:@"SettingsPopupWidth" title:@"SWidth" startValueIfNoOtherIsStored:300 maxValue:1000 MinValue:300 stepValue:10 andTarget:self readonly:TRUE] floatValue], [[SettingsControllerStorageObject numberChangableInSettingsWithKey:@"SettingsPopupHeight" title:@"SHeight" startValueIfNoOtherIsStored:400 maxValue:1000 MinValue:0 stepValue:10 andTarget:self readonly:TRUE] floatValue]);
    
    NSLog(@"Height: 670 - %f = %f",self.settingsPopup.frame.size.height, 670-self.settingsPopup.frame.size.height);
    CGRect rect = self.settingsPopup.frame;
    rect.origin.x = 1020-self.settingsPopup.frame.size.width;
    rect.origin.y = 700-self.settingsPopup.frame.size.height;
    
    self.settingsPopup.frame = rect;
                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                   
    
    [self.settingsPopup setNeedsDisplay];
    [self.settingsPopup layoutSubviews];
}
#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.ST.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CIStepperTableViewCell *cell = (CIStepperTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CIStepperTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SettingsControllerStorageObject*SO = [self.ST.dataArray objectAtIndex:indexPath.row];
        cell.userDefaultsPropertyName = SO.key;
        cell.reloadObjectOnValueChange = SO.target;
        cell.key = SO.title;
        cell.stepper.maximumValue = SO.maxValue;
        cell.stepper.minimumValue = SO.minValue;
        cell.stepper.value = SO.value;
        cell.stepper.stepValue = SO.stepValue;
    }
    
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end