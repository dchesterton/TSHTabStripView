//
// TSHTabView.h
//
// Copyright (c) 2013 Chesterton Software Development Ltd. All rights reserved.
// http://www.chestertondevelopment.com
//

#import <UIKit/UIKit.h>

#import "TSHTab.h"

@interface TSHTabView : UIButton

// the tab which this view will display
@property (nonatomic, strong) TSHTab *tab;

// color of the tab's title when it's selected, defaults to [UIColor blackColor]
@property (nonatomic, strong) UIColor *selectedTitleColor UI_APPEARANCE_SELECTOR;

// color of the tab's title when it's not selected, defaults to [UIColor lightGrayColor]
@property (nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;

// font of the tab's title, defaults to Helvetica Neue Light at 13.0f
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;

// color of the tab when it's highlighted, defaults to a very light gray
@property (nonatomic, strong) UIColor *highlightedBackgroundColor UI_APPEARANCE_SELECTOR;

@end
