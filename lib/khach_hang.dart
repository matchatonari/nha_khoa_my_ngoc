import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class KhachHang extends StatefulWidget {
  @override
  State<KhachHang> createState() => _KhachHangState();
}

class _KhachHangState extends State<KhachHang> {
  final _formKey = GlobalKey<FormState>();
  bool isFemale = false;
  DateTime birthdate = DateTime.now();
  final TextEditingController _birthdateController = TextEditingController();

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
        _birthdateController.text = DateFormat("dd/MM/yyyy").format(birthdate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _birthdateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Họ và tên',
                    icon: Icon(Icons.person),
                  ),
                ),
                CheckboxListTile(
                  title: const Text('Nữ'),
                  value: isFemale,
                  secondary: const Icon(Icons.female),
                  onChanged: (bool? value) {
                    setState(() {
                      isFemale = value!;
                    });
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                ),
                TextFormField(
                  controller: _birthdateController,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  decoration: const InputDecoration(
                      labelText: 'Ngày sinh', icon: Icon(Icons.cake)),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Căn cước công dân',
                    icon: Icon(Icons.badge),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Địa chỉ',
                    icon: Icon(Icons.house),
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Số điện thoại',
                    icon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(36),
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    icon: const Icon(Icons.search),
                    label: const Text("TÌM")),
              ],
            )));
  }
}
