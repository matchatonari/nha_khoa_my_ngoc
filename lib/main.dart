import 'package:flutter/material.dart';
import 'khach_hang.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nha khoa Mỹ Ngọc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Listener for tab changes
    _tabController.addListener(() {
      setState(() {}); // Rebuild to update FAB visibility
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Nha khoa Mỹ Ngọc"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: "HOẠT ĐỘNG"),
            Tab(icon: Icon(Icons.local_grocery_store), text: "KHO HÀNG"),
            Tab(icon: Icon(Icons.monetization_on), text: "THU CHI"),
          ],
        ),
        actions: <Widget>[
          if (_tabController.index == 1 || _tabController.index == 2)
            IconButton(
              icon: const Icon(
                Icons.filter_list,
              ),
              onPressed: () {},
            )
        ],
      ),
      body: TabBarView(
        controller: _tabController, // Use the custom TabController
        children: [
          KhachHang(),
          const Placeholder(),
          const Placeholder(),
        ],
      ),
      floatingActionButton:
          (_tabController.index == 1 || _tabController.index == 2)
              ? FloatingActionButton(
                  onPressed: () {
                    print(_tabController.index);
                  },
                  child: const Icon(Icons.add),
                )
              : null,
    );
  }
}
