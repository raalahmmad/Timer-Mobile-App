import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import './timermodel.dart';
import './widgets.dart';
import './timer.dart';
import './settings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CountDownTimer>(
      create: (_) => CountDownTimer(),
      child: MaterialApp(
          title: 'My Work Timer',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          home: TimerHomePage()),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  //final CountDownTimer timer = CountDownTimer();
  CountDownTimer timer;

  final double defaultPadding = 5.0;
  emptyMethod() {}

  TimerHomePage() {
    print('******CONSTRUCTURE ');
  }

  void _startWork(BuildContext context) {
    Provider.of<CountDownTimer>(context, listen: false).startWork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Work Timer'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    ));
              })
        ],
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
                        onPressed: () =>
                            Provider.of<CountDownTimer>(context, listen: false)
                                .startBreak(true))),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        color: Color(0xff455A64),
                        text: "Long Break",
                        onPressed: () => timer.startBreak(false))),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
              ],
            ),
            Consumer<CountDownTimer>(
              child: Text('Go Go'),
              builder: (context, value, child) => Expanded(
                child: CircularPercentIndicator(
                  radius: availableWith / 2,
                  lineWidth: 10,
                  percent: value.getTimer?.percent,
                  center: Text(
                    value.getTimer?.time,
                    style: Theme.of(context).textTheme.display1,
                  ),
                  progressColor: Color(0xff009688),
                ),
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
                        onPressed: emptyMethod())),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                        color: Color(0xff009688),
                        text: 'Restart',
                        onPressed: () => _startWork(context))),
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
