TSHTabStripView
===============

An iOS scrollable or static tab view inspired by iOS 7 and the toptable application.

#### Static Tab View
![An example of a static tab view](http://i.imgur.com/ocE7d75.png)

#### Scrolling Tab View
![An example of a scrolling tab view](http://i.imgur.com/4FSHVaz.png)

Sample Code
------------

To get started with the tab view, add the following to your viewDidLoad method. If you're using a Storyboard or xib create the view there, and just setup the tabs in your viewDidLoad using `addTabWithTitle`, `addTabsWithTitles`, `addTabs` or `addTab`.

```objectivec
TSHTabStripView *tabStripView = [[TSHTabStripView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
[tabStripView addTabWithTitle:@"Tab 1"];
[tabStripView addTabWithTitle:@"Tab 2"];
[tabStripView addTabWithTitle:@"Tab 3"];

tabStripView.delegate = self;

[self.view addSubview:tabStripView];
```

To be notified when a user selects a tab, implement the delegate method `didSelectTab` in your view controller, e.g.

```objectivec
- (void)didSelectTab:(TSHTab *)tab atIndex:(NSUInteger)index
{
  // do something
}
```

Scrolling View
--------------

The project supports either a scrolling tab view, or set width tabs. To allow scrolling simply set the `allowScroll` property on the TSHTabStripView class to 'YES', and optionally set the `tabWidth` property.

Appearance
----------

The appearance of the tab view can be set using the [UIApperance](https://developer.apple.com/library/iOS/documentation/UIKit/Reference/UIAppearance_Protocol/Reference/Reference.html) protocol on the TSHTabStripView and TSHTabView classes.

Installing
----------
Simply copy the files into your project and you're ready to go. The project has no external dependencies.

License
----------
The project is licensed under an [MIT license](http://opensource.org/licenses/MIT).
