# ZSNavigationFilterMenuView
A kind of ``filter menu`` as ``navigationBar's titleView``. 
<br>
![](https://github.com/SeraZheng/ZSNavigationFilterMenuView/blob/master/ScreenShot/DisplayWithHide.gif)
![](https://github.com/SeraZheng/ZSNavigationFilterMenuView/blob/master/ScreenShot/Shake.gif)
<br>
Brief
====================================================================================================================================
The menu view is designed as ``titleView`` of ``navigationBar`` , the same as ``Sina Weibo``. You can use it as your UIViewController's ``titleView`` for filter data, such as ``Groups`` in ``Sina Weibo``.<br>
<br>
I use a ``table view`` for displaying data, and you can add ``icon image`` easily, just depends on you.<br>
<br>
Import
====================================================================================================================================
You can import the folder ``"ZSNavigationFilterMenuView"`` to your project.There are some files including ``UIViewAdditions`` as well as ``ZSStyleSheet`` which maybe are useful for you.<br>
Usage
====================================================================================================================================
>>##Initilize
>>ZSNavigationFilterMenuView provieds only a kind of way to initilize one instance, as following:<br>
```Objective-C
>>ZSNavigationFilterMenu *filterMenu = [[ZSNavigationFilterMenu alloc] initWithTitle:[titleItems objectAtIndex:0]];
```
>>##titleItems
>>You must provieds titleItems for ZSNavigationFilterMenuView.<br>
```Objective-C
>>NSArray *titleItems = @[@"12Test", @"1234Test", @"123456Test", @"12345678Test", @"1234567890Test"];
>>ZSNavigationFilterMenu *filterMenu = [[ZSNavigationFilterMenu alloc] initWithTitle:[titleItems objectAtIndex:0]];
>>[filterMenu setTitleItems:titleItems];
>>```
>>##titleView
>>Use ZSNavigationFilterMenuView as titleView of your UIViewController<br>
>>```Objective-C
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.titleView = filterMenu;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(33, 132, 214);
}
```
<br>
