import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nha khoa Mỹ Ngọc',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 16.0),
            bodyMedium: TextStyle(fontSize: 16.0),
          )),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _formKey = GlobalKey<FormState>();
  bool isFemale = false;
  DateTime birthdate = DateTime.now();
  String birthDateString = DateFormat("dd/MM/yyyy").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != birthdate) {
      setState(() {
        birthdate = picked;
        birthDateString = DateFormat("dd/MM/yyyy").format(birthdate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.local_grocery_store)),
                  Tab(icon: Icon(Icons.monetization_on))
                ],
              ),
              title: const Text("Nha khoa Mỹ Ngọc"),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: TabBarView(
              children: [
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Họ và tên',
                              ),
                            ),
                            CheckboxListTile(
                              title: const Text('Nữ'),
                              value: isFemale,
                              onChanged: (bool? value) {
                                setState(() {
                                  isFemale = value!;
                                });
                              },
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Ngày sinh"),
                                TextButton(
                                    child: Text(birthDateString),
                                    onPressed: () {
                                      _selectDate(context);
                                    })
                              ],
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  labelText: 'Căn cước công dân'),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Địa chỉ',
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  labelText: 'Số điện thoại'),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                  }
                                },
                                child: const Text('Tìm')),
                          ],
                        ))),
                const Placeholder(),
                const Placeholder(),
              ],
            )));
  }
}
