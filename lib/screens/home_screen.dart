// ignore_for_file: prefer_typing_uninitialized_variables, prefer_final_fields, unused_field, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_import

import 'dart:convert';
import 'dart:developer';
import 'package:booking_seats_app/provider/seat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var _dataSeat = context.watch<SeatProvider>();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text(
            "เลือกที่นั่ง",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
        body: _dataSeat.data == null || _dataSeat.data.length <= 0
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  AlignedGridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 15,
                      itemCount: _dataSeat.data[0]['rows'].length,
                      itemBuilder: (context, rowsIndex) {
                        return Center(
                          child: Text(
                            "${_dataSeat.data[0]['rows'][rowsIndex]}",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children:
                            List.generate(_dataSeat.data[0]['columns'].length,
                                ((columnsIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "${_dataSeat.data[0]['columns'][columnsIndex]}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        })),
                      ),
                      Expanded(
                        child: AlignedGridView.count(
                            crossAxisCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(left: 20, right: 70),
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 15,
                            itemCount: _dataSeat.data[0]['seats'].length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  _dataSeat.selected(
                                      _dataSeat.data[0]['seats'][index]);
                                },
                                child: Container(
                                  width: 35,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: _dataSeat.seatBookingList.contains(
                                              _dataSeat.data[0]['seats'][index])
                                          ? Colors.orange
                                          : Colors.grey[400],
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  const Divider(
                    thickness: 1,
                    height: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "ที่นั่ง",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: AlignedGridView.count(
                        crossAxisCount: 5,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 20, right: 70),
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 15,
                        itemCount: _dataSeat.seatBookingList.length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: 50,
                            height: 22,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${_dataSeat.seatBookingList[i]['seatNumber']}",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                InkWell(
                                  onTap: () {
                                    _dataSeat.selected(
                                        _dataSeat.seatBookingList[i]);
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ));
  }
}
