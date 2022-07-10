import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pill_dispenser/provider/google_sheets.dart';
import 'package:provider/provider.dart';

class SetUpSchedule extends StatefulWidget {
  static const routeName = '/setup_schedule';

  const SetUpSchedule({Key? key}) : super(key: key);

  @override
  State<SetUpSchedule> createState() => _SetUpScheduleState();
}

class _SetUpScheduleState extends State<SetUpSchedule> {
  final tablets = [
    'Paracetamol',
    'levocetrizen',
    'Vicodin',
    'Zincovit',
    'Others'
  ];
  final types = ['Type - A', 'Type - B', 'Others'];
  final url = 'http://192.168.137.134/';
  String? tablet;
  String? type;
  int? number;
  TimeOfDay selectedTime = TimeOfDay.now();

  void addSchedule(
    String? postType,
    String? Tablet,
    String? Type,
    int? Number,
    TimeOfDay SelectedTime,
  ) async {
    // final response = await post(Uri.parse(url), body: {
    //   "type": postType,
    //   "tablet": Tablet,
    //   "tabletType": Type,
    //   "number": Number.toString(),
    //   "time": SelectedTime.toString()
    // });
    // debugPrint(response.toString());
    Provider.of<GoogleSheetsProvider>(context, listen: false).update({
      'Time': selectedTime.toString(),
      'Tablet': Tablet,
      'Type': Type,
      'Quantity': Number.toString(),
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Schedule Entry',
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black, width: 4)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Select Tablet'),
                    value: tablet,
                    isExpanded: true,
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: tablets.map(buildMenuitem).toList(),
                    onChanged: (value) =>
                        setState(() => this.tablet = value as String?),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.black, width: 4)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Select Tablet Type'),
                    value: type,
                    isExpanded: true,
                    iconSize: 36,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: types.map(buildMenuitem).toList(),
                    onChanged: (value) => setState(() => type = value),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: const Text("Choose Time"),
              ),
              Text("${selectedTime.hour}:${selectedTime.minute}"),
              Container(
                margin: const EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextField(
                  decoration:
                      const InputDecoration(labelText: 'Enter quantity'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (text) {
                    number = int.parse(text);
                  },
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.all(15.0),
                color: Colors.greenAccent,
                onPressed: () {
                  addSchedule(
                    "add_schedule",
                    tablet,
                    type,
                    number,
                    selectedTime,
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 180.0,
              )
            ],
          ),
        ),
      );

  DropdownMenuItem<String> buildMenuitem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      );

  String? numberValidator(String value) {
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
