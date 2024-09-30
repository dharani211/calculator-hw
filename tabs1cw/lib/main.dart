import 'package:flutter/material.dart'; //imports all the necessary packages

void main() {
  //entry point of a flutter app
  runApp(const MyApp()); //main is used to call this to start the program
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //MyApp class is a stateless widget or simply a root that returns material app widget.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //has basic function such as navigation, themeing. This is coming from the inpout
      home: DefaultTabController(
        //all the materialapp has been set to default. This is used to coordinate the tab bars
        length:
            3, //number of tabs, also used for restore when app is being built
        child:
            _TabsNonScrollableDemo(), //a stateful widget, tied to the tab interface
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController
      _tabController; //can take you the required tab number, simple controllable
  final RestorableInt tabIndex = RestorableInt(0);
  @override
  String get restorationId => 'tab_non_scrollable_demo';
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    //restores to the original state/ initial
    registerForRestoration(
        tabIndex, 'tab_index'); //tab index to take back to required tab
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    //to initialise the tab controller that has event lister
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    //to get rid of previous tabs(example index pages)
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// For the ToDo task hint: consider defining the widget and name of the tabs here
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3'];
    return Scaffold(
      //this has the whole UI, gives you basic app structure
      appBar: AppBar(
        // this is app title
        automaticallyImplyLeading: false,
        title: const Text(
          'Tabs Demo',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
// hint for the to do task:Considering creating the different for different tabs
          for (final tab in tabs)
            Center(
              child: Text(tab),
            ),
        ],
      ),
    );
  }
}
