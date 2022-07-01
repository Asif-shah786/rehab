import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rehab/common_widgets/tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.widgetBuilder,
    required this.navigatorKeys,
  }) : super(key: key);
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilder;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItems(TabItem.home),
          _buildItems(TabItem.rehab),
          _buildItems(TabItem.practice),
          _buildItems(TabItem.profile)
        ],
        activeColor: Colors.black,
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (BuildContext context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (BuildContext context) => widgetBuilder[item]!(context),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItems(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = tabItem == currentTab ? Colors.black : Colors.grey;
    return BottomNavigationBarItem(
      label: itemData?.title,
      backgroundColor: color,
      icon: Icon(
        itemData?.icon,
        color: color,
      ),
    );
  }
}
