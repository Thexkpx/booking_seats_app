// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_local_variable, unused_field
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SeatProvider with ChangeNotifier {
  var _data = [];
  var _seatBookingList = [];

  fetchData() async {
    try {
      var request = http.Request(
          'GET', Uri.parse('https://xokthilat.github.io/json/seating.json'));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var responseJson = json.decode(result);
        var _row = [];
        var _column = [];
        for (int j = 0; j < responseJson['seatLayout']['columns']; j++) {
          _column.add(String.fromCharCode(65 + j));
        }
        for (int i = 0; i < responseJson['seatLayout']['rows']; i++) {
          _row.add(i + 1);
        }
        data.add({
          "rows": _row,
          "columns": _column,
          "seats": responseJson['seatLayout']['seats']
        });
        notifyListeners();
      } else {
        notifyListeners();
        print(response.reasonPhrase);
      }
    } catch (error) {
      notifyListeners();
      if (kDebugMode) {
        print(error);
      }
    }
  }

  void selected(data) {
    if (_seatBookingList.contains(data)) {
      _seatBookingList.remove(data);
    } else {
      _seatBookingList.add(data);
    }
    notifyListeners();
  }

  get data => _data;
  get seatBookingList => _seatBookingList;
}
