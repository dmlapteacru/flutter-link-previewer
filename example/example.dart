import 'package:flutter/material.dart';
import 'package:link_previewer/link_previewer.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            LinkPreviewer(link: "https://www.youtube.com/watch?v=a9_oMNSgX2g", direction: ContentDirection.horizontal,),
            LinkPreviewer(link: "https://www.youtube.com/watch?v=a9_oMNSgX2g", direction: ContentDirection.vertical,),
            LinkPreviewer(link: "https://www.linkedin.com/", direction: ContentDirection.horizontal,),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
