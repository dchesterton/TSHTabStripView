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

#import "TSHTabStripView.h"

@interface TSHTabStripView ()

// an array of all tab views
@property (nonatomic, strong) NSMutableArray *tabViews;

// the background scroll view to hold the tabs
@property (nonatomic, strong) UIScrollView *scrollView;

// the selected bar which moves underneath the tab
@property (nonatomic, strong) UIView *selectedView;

// an array of all the tabs
@property (nonatomic, strong) NSMutableArray *tabs;

@end

@implementation TSHTabStripView

#pragma mark - Init

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self = [self initWithFrame:self.frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.tabs = [[NSMutableArray alloc] init];
        self.tabViews = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        _allowScroll = YES;
        _tabWidth = 100.0f;

        self.selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 3.0f, self.tabWidth, 3.0f)];
        self.selectedView.backgroundColor = [UIColor blackColor];

        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 1.0f)];
        scrollView.scrollsToTop = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.directionalLockEnabled = YES;
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [scrollView addSubview:self.selectedView];
        [self addSubview:scrollView];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];

        [self addConstraint:[NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f]];

        self.scrollView = scrollView;

        // add thin bottom border to separate tabs from other content
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - 1.0f, self.frame.size.width, 1.0f)];
        bottomBorder.backgroundColor = [UIColor veryLightGrayColor];
        bottomBorder.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:bottomBorder];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:bottomBorder attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:bottomBorder attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:bottomBorder attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:bottomBorder attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0f constant:1.0f]];
    }
    return self;
}

#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];

    if (!self.allowScroll) {
        _tabWidth = self.frame.size.width / (float)self.tabs.count;
    }

    // layout individual tabs
    for (int i = 0; i < self.tabs.count; i++) {
        TSHTabView *tabView = self.tabViews[i];

        tabView.frame = CGRectMake(i * self.tabWidth, 0, self.tabWidth, self.frame.size.height);

        // initially set the first tab as selected
        if (tabView.superview == nil) {
            [tabView addTarget:self action:@selector(tabTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

            if (i == 0) {
                tabView.selected = YES;
            }

            [self.scrollView addSubview:tabView];
        }
    }

    // adjust content size
    if (self.allowScroll) {
        self.scrollView.contentSize = CGSizeMake(self.tabWidth * self.tabs.count, self.frame.size.height);
    } else {
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }
    
    CGRect frame = self.selectedView.frame;
    frame.size.width = self.tabWidth;
    frame.origin.x = self.tabWidth * self.selectedIndex;
    
    self.selectedView.frame = frame;
}

#pragma mark - Add Tabs

- (TSHTab *)addTabWithTitle:(NSString *)title
{
    TSHTab *tab = [[TSHTab alloc] initWithTitle:title];
    [self addTab:tab];
    return tab;
}

- (void)addTabsWithTitles:(NSArray *)titles
{
    for (NSString *title in titles) {
        [self addTabWithTitle:title];
    }
}

- (void)addTab:(TSHTab *)tab
{
    UIView *tabView = [self createViewForTab:tab];

    [self.tabViews addObject:tabView];
    [self.tabs addObject:tab];
    [self layoutSubviews];
}

- (void)addTabs:(NSArray *)tabs
{
    for (TSHTab *tab in tabs) {
        [self addTab:tab];
    }
}

#pragma mark - Tab and Tab View Getters

- (TSHTabView *)tabViewForTab:(TSHTab *)tab
{
    NSUInteger index = [self.tabs indexOfObject:tab];
    return self.tabViews[index];
}

- (TSHTabView *)tabViewAtIndex:(NSUInteger)index
{
    return self.tabViews[index];
}

- (TSHTab *)tabAtIndex:(NSUInteger)index
{
    return self.tabs[index];
}

#pragma mark - Internal methods

// internal method to create a view for a given tab
- (UIView *)createViewForTab:(TSHTab *)tab
{
    TSHTabView *tabView = [[TSHTabView alloc] init];
    tabView.tab = tab;
    
    return tabView;
}

#pragma mark - Event Listener

- (void)tabTouchUpInside:(id)sender
{
    TSHTab *selectedTab = self.tabs[self.selectedIndex];

    TSHTabView *tabView = sender;
    TSHTab *tab = tabView.tab;
    
    if (selectedTab == tab) {
        return; // already on this tab
    }

    // deselect current tab
    [self tabViewAtIndex:self.selectedIndex].selected = NO;

    // update current tab selected state
    tabView.selected = YES;
    
    // move the selected bar to the new tab
    NSInteger index = [self.tabs indexOfObject:tab];
    
    CGRect frame = self.selectedView.frame;
    frame.origin.x = self.tabWidth * index;

    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.selectedView.frame = frame;
    } completion:nil];

    // call delegate
    [self.delegate didSelectTab:tab atIndex:index];
}

#pragma mark - Selected Tab

- (NSInteger)selectedIndex
{
    NSInteger i = 0;

    for (UIView *tabView in self.scrollView.subviews) {
        if ([tabView isKindOfClass:[TSHTabView class]]) {
            if (((TSHTabView *)tabView).selected == YES) {
                return i;
            }
            i++;
        }
    }
    return -1;
}

#pragma mark - tabWidth property

- (void)setTabWidth:(float)tabWidth
{
    _tabWidth = tabWidth;
    
    CGRect frame = self.selectedView.frame;
    frame.size.width = tabWidth;
    
    self.selectedView.frame = frame;
}

#pragma mark - selectedBarColor property

- (void)setSelectedBarColor:(UIColor *)selectedBarColor
{
    self.selectedView.backgroundColor = selectedBarColor;
}

- (UIColor *)selectedBarColor
{
    return self.selectedView.backgroundColor;
}

@end
