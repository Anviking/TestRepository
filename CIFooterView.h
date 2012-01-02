//
//  CIFooterViewController.h
//  iGitpad
//
//  Created by Johannes Lund on 2011-11-20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CIPopupView.h"
#import "SettingsController.h"



@interface CIFooterView : UIView <UITableViewDataSource, UITableViewDelegate> { 
    

}

@property (nonatomic, strong) UIButton * UserButton;
@property (nonatomic, strong) UIButton * ArrowButton;
@property (nonatomic, strong) UITableView *settingsPanel;
@property (nonatomic, strong) CIPopupView *settingsPopup;
@property (nonatomic, strong) UIButton *settingsButton; 
@property (nonatomic, assign) BOOL popupIsVisible;
@property (nonatomic, strong) SettingsController*ST;
@end
