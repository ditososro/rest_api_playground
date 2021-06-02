import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  var _body ;
  var _title ;
  var _jsonQuery;
  String url = "";
  var data;
  final String token = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2N2U4MzVjNmFmMGU2MTN'
      'kM2NlYzc4M2Y5YzZmZjZiYiIsInN1YiI6IjYwYTczZDE5MTY4OTM1MDA1ODM5MDYxMiIsInN'
      'jb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6XX38r34HCYIHhYIG1NhvY6VwGyrmy0EEmXeJvdiXz8';

  getData() async {
    var apiUrl = Uri.parse(_controller.text);
    var response = await http.get(
        apiUrl,
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        }
    );
    print(response.statusCode);
    setState(() {
      data = json.decode(response.body);
      _jsonQuery = json.decode(response.body).toString();
      _body  = data["original_title"];
      _title = data["overview"];

    });
  }

  @override
  void dispose(){
    _jsonQuery = "Please insert URL and press the GET button";
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 12));

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("HTTP Request"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Insert URL here',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                'Response Status : ',
              ),
                Text(
                  '',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
        ElevatedButton(
          style: style,
          onPressed: getData,
          child: const Text('GET'),
        ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (_jsonQuery != null) ? _jsonQuery : 'No Data',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 20,
                  ),
                ),
              ),
            Text("Title: ",
                style: TextStyle(fontWeight: FontWeight.bold)
            ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  (_body != null) ? _body : 'No Data',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 20,
                ),
              ),
            Text(
                "Overview: ",
                style: TextStyle(fontWeight: FontWeight.bold)
                ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  (_title != null) ? _title : 'No Data',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 20,
                ),
              ),
            )
        ],
    ),
      ),
    );
  }
}
