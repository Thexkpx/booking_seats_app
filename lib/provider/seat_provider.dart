// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_final_fields, unused_local_variable, unused_field
import 'dart:convert';
import 'package:booking_seats_app/constants/index.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SeatProvider with ChangeNotifier {
  var _data = {};
  List _seatBookingList = [];
  bool _isLoading = false;

  fetchData() async {
    _isLoading = true;
    try {
      var request = http.Request('GET', Uri.parse(END_POINT));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var responseJson = json.decode(result);
        _data = {
          "rows": _generateRows(responseJson['seatLayout']['rows']),
          "columns": _generateColumns(responseJson['seatLayout']['columns']),
          "seats": responseJson['seatLayout']['seats'],
        };
        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      _isLoading = false;
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

  //  _generateRows
  List<int> _generateRows(int numRows) {
    return List.generate(numRows, (index) => index + 1);
  }

  /// _generateColumns
  List<String> _generateColumns(int numColumns) {
    return List.generate(
        numColumns, (index) => String.fromCharCode(65 + index));
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  get data => _data;
  get seatBookingList => _seatBookingList;
  bool get isLoading => _isLoading;
}
