import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:intl/intl.dart';

class TicketData extends StatelessWidget {
  TicketData({
    Key? key,
    required this.text,
    required this.ad, 
    required this.soyad,
  }) : super(key: key);
  final String text;
  final String soyad;
  final String ad;
  final String now = DateFormat("dd/MM/yyyy ").format(
      DateTime.now()); //ticket'ta bugünün tarihini vermek için kullandık

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120.0,
                height: 25.0,
              ),
              Row(
                children: const [
                  Text(
                    'KARACA',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0,),
                    child: Icon(
                      Icons.flight_takeoff,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ticketDetailsWidget('Ödül Sahibi', '$ad $soyad', 'Tarih', now),
              // Padding(
              //padding: const EdgeInsets.only(top: 12.0, right: 52.0),
              // child: ticketDetailsWidget('Flight', '76836A45', 'Gate', '66B'),
              // ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 80.0,
            left: 30.0,
            right: 30.0,
          ),
          child: Container(
            width: 250.0,
            height: 90.0,
            padding: EdgeInsets.only(left: 60),
            child: SfBarcodeGenerator(
              value: 'AFKH943G933GHK',
              symbology: Code93(),
              showValue: true,
            ),
          ),
        ),
        Center(
          child: const Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              left: 90.0,
              right: 75.0,
            ),
            child: Text(
              'Ödül Kodu',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}
