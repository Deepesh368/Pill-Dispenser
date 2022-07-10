import 'package:flutter/material.dart';
import 'package:pill_dispenser/provider/google_sheets.dart';
import 'package:provider/provider.dart';

class EditSchedule extends StatefulWidget {
  static const routeName = '/edit_schedule';
  const EditSchedule({Key? key}) : super(key: key);

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class Value {
  static int value = 2;
  static void setString(int newValue) {
    value = newValue;
  }

  static int getString() {
    return value;
  }
}

List<List<String>> list = [
  ['1']
];

class _EditScheduleState extends State<EditSchedule> {
  @override
  Widget build(BuildContext context) {
    list = Provider.of<GoogleSheetsProvider>(context).data;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Edit Entry'),
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: _getEntries,
        ));
  }

  Widget _getEntries(BuildContext context, int index) {
    return ListTile(
      leading: CircleAvatar(
          child: Text(list[index][0].toString().substring(10, 15))),
      title: Text(list[index][1]),
      subtitle: Text(list[index][2]),
      trailing: Text(list[index][3]),
      onTap: () {
        Value.setString(index + 2);
        Navigator.popAndPushNamed(context, '/edit_sheet');
      },
    );
  }
}
