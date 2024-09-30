import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: _TabsNonScrollableDemo(),
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
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
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
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  ThemeMode _themeMode = ThemeMode.system;
  Color textColor = Colors.grey;

  void changeTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      textColor = Colors.grey;
    }
    if (themeMode == ThemeMode.dark) {
      textColor = Colors.white;
    }
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Main Screen', 'Settings Screen'];
    List<Widget> childWidgets = [];

    for (var tab in tabs) {
      switch (tab) {
        case "Main Screen":
          childWidgets.add(Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "Mobile App Development Testing",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.blue,
                        ),
                      )),
                ),
              ]));

          break;

        case "Settings Screen":
          childWidgets.add(
            MaterialApp(
              theme: ThemeData(primarySwatch: Colors.blueGrey),
              darkTheme: ThemeData.dark(),
              themeMode: _themeMode,
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Switch Theme:'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => changeTheme(ThemeMode.light),
                            child: const Text('Light Theme'),
                          ),
                          ElevatedButton(
                            onPressed: () => changeTheme(ThemeMode.dark),
                            child: const Text('Dark Theme'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

          break;
        default:
      }
    }

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Classwork Activity',
            ),
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
          children: childWidgets,
        ),
      ),
    );
  }
}
