# ZSNavigationFilterMenuView
A kind of ``filter menu`` as ``navigationBar's titleView``, including titles as well as icons. 
<br>
![](https://github.com/SeraZheng/ZSNavigationFilterMenuView/blob/master/ScreenShot/displayAndHide.gif)
![](https://github.com/SeraZheng/ZSNavigationFilterMenuView/blob/master/ScreenShot/TitlesOnly.gif)
![](https://github.com/SeraZheng/ZSNavigationFilterMenuView/blob/master/ScreenShot/Shake.gif)
<br>
Brief
====================================================================================================================================
The menu view is designed as ``titleView`` of ``navigationBar`` , the same as ``Sina Weibo``. You can use it as your UIViewController's ``titleView`` for filter data, such as ``Groups`` in ``Sina Weibo``.<br>
<br>
I use a ``table view`` for displaying data, so you can add ``icon image`` easily, just depends on you.<br>
<br>
Import
====================================================================================================================================
You can import the folder ``"ZSNavigationFilterMenuView"`` to your project.There are some profiles including ``UIViewAdditions`` as well as ``ZSStyleSheet`` which maybe be useful for you.<br>
Usage
====================================================================================================================================
>>##Initilize
>>####titles with icons
>>ZSNavigationFilterMenuView provieds a kind of way to initilize one instance useing titles with icons, as following.You don't have to care ``ZSNavigationFilterMenuView's frame``, it can be size of its needs<br>
```Objective-C
>>// Use titles with icons
    NSArray *titleItems = @[@"12Test", @"1234Test", @"123456Test", @"12345678Test", @"1234567890Test"];
    NSArray *iconItems = @[[UIImage imageNamed:@"numbers"],
                           [UIImage imageNamed:@"offline_files"],
                           [UIImage imageNamed:@"ok"],
                           [UIImage imageNamed:@"pages"],
                           [UIImage imageNamed:@"pdf"]];
    ZSNavigationFilterMenu *filterMenu = [[ZSNavigationFilterMenu alloc] initWithTitleItems:titleItems iconItems:iconItems];
```
>>####titles only
>>ZSNavigationFilterMenuView provieds another way to initilize one instance useing titles only, as following.You don't have to care ``ZSNavigationFilterMenuView's frame``, it can be size of its needs<br>
```Objective-C
>>// Use titles only, set selectRow necessarily
    NSArray *titleItems = @[@"12Test", @"1234Test", @"123456Test", @"12345678Test", @"1234567890Test"];
    ZSNavigationFilterMenu *filterMenu = [[ZSNavigationFilterMenu alloc] init];
    [filterMenu setTitleItems:titleItems];
    [filterMenu setSelectRow:0];
```
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
