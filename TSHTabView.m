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

#import "TSHTabView.h"

@implementation TSHTabView

#pragma mark - Init

- (id)init
{
    self = [super init];
    if (self) {
        // set appearance defaults
        _selectedTitleColor = [UIColor blackColor];
        _titleColor = [UIColor lightGrayColor];
        _font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
        _highlightedBackgroundColor = [UIColor colorWithWhite:0.98f alpha:1.0f];
    }
    return self;
}

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.highlighted = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.highlighted = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.highlighted = NO;
}

#pragma mark - UIView

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateBackgroundColor];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateBackgroundColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    UIColor *titleColor = (self.selected)? self.selectedTitleColor: self.titleColor;
    [self setTitleColor:titleColor forState: UIControlStateNormal];
    [self setTitle:self.tab.title forState:UIControlStateNormal];

    self.titleLabel.font = self.font;

    [self updateBackgroundColor];
}

#pragma mark - Background Color

- (void)updateBackgroundColor
{
    if (self.selected == NO && self.highlighted) {
        self.backgroundColor = (self.highlighted)? self.highlightedBackgroundColor: [UIColor clearColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
