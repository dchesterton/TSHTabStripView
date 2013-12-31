//
// The MIT License (MIT)
//
// Copyright (c) 2013 Chesterton Software Development Ltd.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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
