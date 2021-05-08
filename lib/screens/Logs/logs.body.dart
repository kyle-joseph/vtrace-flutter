import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vtraceflutter/services/logs_fetch.dart';

class LogsBody extends StatefulWidget {
  @override
  _LogsBodyState createState() => _LogsBodyState();
}

class _LogsBodyState extends State<LogsBody> {
  EstablishmentLogs _estLogs = new EstablishmentLogs();
  DateTime _fromDate = DateTime.now();
  List customerLogs = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    fetchLogs();
  }

  fetchLogs() async {
    customerLogs = [];
    setState(() => loading = true);
    var logs = await _estLogs.logsByDate(isoStringDate);
    setState(() => loading = false);
    if (logs['success']) {
      setState(() => customerLogs = logs['establishmentLogs']);
    }
  }

  String get wordedDate {
    return DateFormat.yMMMd().format(_fromDate);
  }

  String get isoStringDate {
    return _fromDate.toIso8601String() + 'Z';
  }

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fromDate,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _fromDate) {
      setState(() => _fromDate = picked);
      fetchLogs();
    }
  }

  Widget getLog(int idx) {
    List log = customerLogs;
    return ListTile(
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rowData(
                "Name:", "${log[idx]['firstname']} ${log[idx]['lastname']}"),
            rowData("Address:", log[idx]['address']),
            rowData("Gender:", log[idx]['gender']),
            rowData("Contact #:", log[idx]['contactNumber']),
            rowData("Date/Time:", "${log[idx]['date']} / ${log[idx]['time']}"),
          ],
        ),
      ),
    );
  }

  Widget rowData(String title, String data) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: Color(0xff5253ED),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              data,
              style: GoogleFonts.nunito(
                textStyle: TextStyle(
                  color: Color(0xff5253ED),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffECECEC),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xff5253ED),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  wordedDate,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.date_range_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    _showDatePicker();
                  },
                )
              ],
            ),
          ),
          loading
              ? Expanded(
                  child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: ListView.builder(
                      itemCount: customerLogs.length,
                      itemBuilder: (BuildContext context, int idx) {
                        return getLog(idx);
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
