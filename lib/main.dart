import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './widgets.dart';
import './timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Work Timer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();
  final double defaultPadding = 5.0;
  emptyMethod() {}

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Work Timer'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double availableWith = constraints.maxWidth;
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        color: Color(0xff009688),
                        text: "Work",
                        onPressed: emptyMethod)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        color: Color(0xff607D8B),
                        text: "Short Break",
                        onPressed: emptyMethod)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        color: Color(0xff455A64),
                        text: "Long Break",
                        onPressed: emptyMethod)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            Expanded(
              child: CircularPercentIndicator(
                radius: availableWith / 2,
                lineWidth: 10,
                percent: 0.7,
                center: Text(
                  '30:00',
                  style: Theme.of(context).textTheme.display1,
                ),
                progressColor: Color(0xff009688),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        color: Color(0xff212121),
                        text: 'Stop',
                        onPressed: emptyMethod)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        color: Color(0xff009688),
                        text: 'Restart',
                        onPressed: emptyMethod)),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
