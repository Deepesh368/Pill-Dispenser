import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gsheets/gsheets.dart';

const _credentials = r'''
{
  
}
''';

const _spreadsheetId = '1RL1YHCezLD67jhFrzK1R9we1Oc7mqeYWCoU7vjYXuNg';

class GoogleSheetsProvider extends ChangeNotifier {
  final gsheets = GSheets(_credentials);
  final user = FirebaseAuth.instance.currentUser;
  late List<List<String>> data;

  GoogleSheetsProvider() {
    init();
  }

  void init() async {
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet = ss.worksheetByTitle(user!.displayName.toString());
    sheet ??= await ss.addWorksheet(user!.displayName.toString());
    final firstRow = ['Time', 'Tablet', 'Type', 'Quantity'];
    await sheet.values.insertRow(1, firstRow);
  }

  void update(data) async {
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet = ss.worksheetByTitle(user!.displayName.toString());
    sheet ??= await ss.addWorksheet(user!.displayName.toString());
    await sheet.values.map.appendRow(data);
  }

  Future<void> insert(data, index) async {
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet = ss.worksheetByTitle(user!.displayName.toString());
    sheet ??= await ss.addWorksheet(user!.displayName.toString());
    await sheet.values.map.insertRow(index, data);
  }

  Future<void> fetch() async {
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    var sheet = ss.worksheetByTitle(user?.displayName ?? 'default'.toString());
    sheet ??= await ss.addWorksheet(user?.displayName ?? 'default'.toString());
    data = await sheet.values.allRows();
    data.removeAt(0);
  }
}
