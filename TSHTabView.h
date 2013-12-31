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
