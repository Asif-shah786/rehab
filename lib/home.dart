import 'package:flutter/cupertino.dart';
import 'package:rehab/views/home_view.dart';
import 'package:rehab/views/practice_view.dart';
import 'package:rehab/views/profile_view.dart';
import 'package:rehab/views/rehab_view.dart';
import 'package:rehab/common_widgets/tab_item.dart';
import 'common_widgets/cupertino_home_scaffold.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TabItem _currentTab = TabItem.home;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.rehab: GlobalKey<NavigatorState>(),
    TabItem.practice: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),

  };
  Map<TabItem, WidgetBuilder> get widgetBuilder {
    return {
      TabItem.home: (_) => HomeView(),
      TabItem.rehab: (context) => RehabView(),
      TabItem.practice: (context) => PracticeView(),
      TabItem.profile: (context) => ProfileView(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]!
          .currentState!
          .popUntil((route) => route.isFirst);
    } else {
      setState(
        () => _currentTab = tabItem,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilder: widgetBuilder,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
