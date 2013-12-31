//
// TSHTabStripView.h
//
// Copyright (c) 2013 Chesterton Software Development Ltd. All rights reserved.
// http://www.chestertondevelopment.com
//

#import <UIKit/UIKit.h>

#import "TSHTabView.h"
#import "TSHTab.h"

@protocol TSHTabStripViewDelegate

// called when the user selects a tab
- (void)didSelectTab:(TSHTab *)tab atIndex:(NSUInteger)index;

@end

@interface TSHTabStripView : UIView

// get or set the tab strip delegate
@property (nonatomic, weak) IBOutlet id <TSHTabStripViewDelegate> delegate;

// get the index of the selected tab
@property (nonatomic, readonly) NSInteger selectedIndex;

// set whether to allow the tab strip to scroll or not
@property (nonatomic) BOOL allowScroll;

// get or set the selected bar color, can be set using UIAppearance
@property (nonatomic, strong) UIColor *selectedBarColor UI_APPEARANCE_SELECTOR;

// specify the width of the tabs. It's only used if allowScroll is set to YES, otherwise
// tab width is calculated automatically based on available space
@property (nonatomic) float tabWidth UI_APPEARANCE_SELECTOR;

// convenience method to add a tab with a title
// equivalent to calling [self addTab:[[TSHTab alloc] initWithTitle:title]];
- (TSHTab *)addTabWithTitle:(NSString *)title;

// convenience method to quickly add multiple tabs
- (void)addTabsWithTitles:(NSArray *)titles;

// add a tab
- (void)addTab:(TSHTab *)tab;

// add multiple tabs, array members should be TSHTab objects.
- (void)addTabs:(NSArray *)tabs;

// get the tab view object at the given index
- (TSHTabView *)tabViewAtIndex:(NSUInteger)index;

// get the tab object at the given index
- (TSHTab *)tabAtIndex:(NSUInteger)index;

// get the tab view responsible for rendering the given tab
- (TSHTabView *)tabViewForTab:(TSHTab *)tab;

@end
