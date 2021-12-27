import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/model/model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String qrdata = "No data found!";
var data;
bool hasdata = false;

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "Scan QR",
        child: Scaffold(
          appBar: AppBar(
            title: Text("QR Scanner"),
          ),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "Raw Data: ${(qrdata)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.launch_outlined),
                      onPressed: hasdata
                          ? () async {
                              if (await canLaunch(qrdata)) {
                                await canLaunch(qrdata);
                              } else {
                                throw "Could not launch";
                              }
                            }
                          : null,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: ((MediaQuery.of(context).size.width) / 2) - 45,
                  height: 50,
                  child: OutlineButton(
                    focusColor: Colors.red,
                    highlightColor: Colors.blue,
                    hoverColor: Colors.lightBlue[100],
                    splashColor: Colors.blue,
                    borderSide: BorderSide(width: 3, color: Colors.blue),
                    shape: StadiumBorder(),
                    child: Text(
                      "Scan QR",
                      style: TextStyle(fontSize: 17),
                    ),
                    onPressed: () async {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => ScanQR()));

                      //Scan function

                      var option = ScanOptions(autoEnableFlash: true);
                      data = await BarcodeScanner.scan(options: option);

                      setState(() {
                        qrdata = data.rawContent.toString();
                        hasdata = true;
                      });
                      Navigator.pop(context, qrdata);
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
