import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class AnimatedRadialChartExample extends StatefulWidget {
  var value = 50;
  AnimatedRadialChartExample({this.value});
  

  @override
  AnimatedRadialChartExampleState createState() =>
      new AnimatedRadialChartExampleState();
  
}

class AnimatedRadialChartExampleState
    extends State<AnimatedRadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(74.0, 70.0);

  
  Color labelColor = Colors.white;



  void increment() {
    setState(() {
      widget.value += 10;
      List<CircularStackEntry> data = _generateChartData(widget.value.toDouble());
      _chartKey.currentState.updateData(data);
    });
  }

  void decrement() {
    setState(() {
      widget.value -= 10;
      List<CircularStackEntry> data = _generateChartData(widget.value.toDouble());
      _chartKey.currentState.updateData(data);
    });
  }

  List<CircularStackEntry> _generateChartData(double value) {
    Color dialColor = Colors.lightBlueAccent;//Colors.blue[200];
    if (value < 0) {
      dialColor = Colors.red[300];
    } else if (value < 50) {
      dialColor = Colors.yellow[800] ;
    }
    labelColor = dialColor;

    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value,
            dialColor,
            rankKey: 'percentage',
          )
        ],
        rankKey: 'percentage',
      ),
    ];

    if (value > 100) {
      labelColor = Colors.lightGreen;

      data.add(new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(
            value - 100,
            Colors.lightGreen,
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = Theme
        .of(context)
        .textTheme
        .title
        .merge(new TextStyle(
          color: labelColor,fontSize: 14.0,
          fontWeight: FontWeight.w700,
          decorationThickness: 12.85,
          
          
          
                   ));

    return new Center(
      child: new Container(
            child: new AnimatedCircularChart(
              key: _chartKey,
              size: _chartSize,
              initialChartData: _generateChartData(widget.value.toDouble()),
              chartType: CircularChartType.Radial,
              edgeStyle: SegmentEdgeStyle.round,
              percentageValues: true,
              holeLabel: widget.value.toString(),
              labelStyle: _labelStyle,
            ),
          ),/*
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new RaisedButton(
                onPressed: _decrement,
                child: const Icon(Icons.remove),
                shape: const CircleBorder(),
                color: Colors.red[200],
                textColor: Colors.white,
              ),
              new RaisedButton(
                onPressed: _increment,
                child: const Icon(Icons.add),
                shape: const CircleBorder(),
                color: Colors.blue[200],
                textColor: Colors.white,
              ),
            ],
          ),*/
    );
  }
}

