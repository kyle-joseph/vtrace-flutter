import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:vtraceflutter/services/connection.dart';
import 'package:vtraceflutter/services/logs_fetch.dart';

class ScanBody extends StatefulWidget {
  @override
  _ScanBodyState createState() => _ScanBodyState();
}

class _ScanBodyState extends State<ScanBody> {
  EstablishmentLogs _establishmentLogs = new EstablishmentLogs();
  String _scanBarcode = 'Unknown';
  String error = '';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    if (_scanBarcode != '-1') {
      var userExist = await _establishmentLogs.userExist(_scanBarcode);

      if (userExist['success']) {
        var createLog = await _establishmentLogs.createLog(_scanBarcode);
        if (createLog['success']) {
          Toast.show('Individual log saved.', context,
              duration: 5, gravity: Toast.BOTTOM);
        } else {
          setState(() => error = createLog['message']);
          Toast.show(error, context, duration: 5, gravity: Toast.BOTTOM);
        }
      } else {
        setState(() => error = userExist['message']);
        Toast.show(error, context, duration: 5, gravity: Toast.BOTTOM);
      }
    }
  }

  //See assets/images for a sample qrcode containing firsname*lastname*address*birtdate
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: Image.asset(
                'assets/images/qr.jpg',
                filterQuality: FilterQuality.high,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(
            //     vertical: 5,
            //   ),
            //   child: Text(
            //     error,
            //     style: TextStyle(
            //       color: Colors.redAccent,
            //     ),
            //   ),
            // ),
            Container(
              height: 50,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                color: Colors.white,
                onPressed: () async {
                  bool connection = await Connection().checkConnection();
                  if (connection) {
                    await scanQR();
                    // await Navigator.popAndPushNamed(context, "/scan");
                  } else {
                    Toast.show('No internet connection.', context,
                        duration: 5, gravity: Toast.BOTTOM);
                  }
                },
                icon: Icon(
                  Icons.qr_code,
                  size: 40,
                  color: Color(0xff5253ED),
                ),
                label: Text(
                  "Scan Now",
                  style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                      color: Color(0xff5253ED),
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
