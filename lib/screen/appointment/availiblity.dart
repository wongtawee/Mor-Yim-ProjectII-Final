import 'package:moryim/screen/Service/availablityService.dart';
import 'package:moryim/screen/utilities/decoration.dart';
import 'package:moryim/widgets/appbarsWidget.dart';
import 'package:moryim/widgets/errorWidget.dart';
import 'package:moryim/widgets/loadingIndicator.dart';
import 'package:moryim/widgets/noDataWidget.dart';
import 'package:flutter/material.dart';
import 'package:moryim/screen/Choosedoctor/choosedoctor.dart';

class AvailabilityPage extends StatefulWidget {
  AvailabilityPage({Key key}) : super(key: key);

  @override
  _AvailabilityPageState createState() => _AvailabilityPageState();
}

class _AvailabilityPageState extends State<AvailabilityPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Color(0xFF7369FF),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: IBoxDecoration.upperBoxDecoration(),
              child: FutureBuilder(
                  future:
                      AvailabilityService.getAvailability(), //fetch all times
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return snapshot.data.length == 0
                          ? NoDataWidget()
                          : _buildContent(snapshot);
                    else if (snapshot.hasError)
                      return IErrorWidget(); //if any error then you can also use any other widget here
                    else
                      return LoadingIndicatorWidget();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Text("Dibuk Hospital",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans-Bold',
                  fontSize: 15.0,
                ))),
        Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: buildTable(snapshot.data[0])),
        RaisedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Choosedoctor()),
            );
          },
          color: Colors.blue,
          child: Text(
            'Choosedoctor',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget buildTable(day) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          rowContent("Day", "Time"),
          Divider(),
          rowContent("Monday", "${day.mon}"),
          Divider(),
          rowContent("Tuesday", "${day.tue}"),
          Divider(),
          rowContent("Wednesday", "${day.wed}"),
          Divider(),
          rowContent("Thursday", "${day.thu}"),
          Divider(),
          rowContent("Friday", "${day.fri}"),
          Divider(),
          rowContent("Saturday", "${day.sat}"),
          Divider(),
          rowContent("Sunday", "${day.sun}"),
          Divider(),
        ],
      ),
    );
  }

  Widget rowContent(String first, String last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(first,
            style: TextStyle(
              fontFamily: 'OpenSans-SemiBold',
              fontSize: 14.0,
            )),
        Text(
          last,
          style: TextStyle(
            fontFamily: 'OpenSans-SemiBold',
            fontSize: 14.0,
          ),
        )
      ],
    );
  }
}
