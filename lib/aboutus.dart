import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: AboutUs()));

final List<Widget> entries = [
  Container(
    child: Image(
      height: 120,
      image: AssetImage('assets/enact.JPG'),
    ),
  ),
  Container(
    padding: EdgeInsets.all(15.0),
    color: Colors.blue[800],
    child: Text(
      'ENACT',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
  ),
  Container(
    padding: EdgeInsets.all(15.0),
    child: Text(
      'ENACT Stands for Electronic Nutrition Approaches for Cancer-'
          'related Topics. ENACT strives to aid Cancer patients with '
          'nutrition topics using eHealth tools',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),
    ),
  ),
  Container(
    padding: EdgeInsets.all(15.0),
    color: Colors.blue[800],
    child: Text(
      'Members',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
  ),
  Container(
    padding: EdgeInsets.all(15.0),

    child: Text(
      'ENACT is made up of Benedictine University Research Students and'
          ' teachers. They hope to provide factual information about '
          'nutrition along with hopes of aiding survivors with keeping'
          ' track of goals and progress towards their nutritional needs.',
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),
    ),
  ),
  Container(
    child: Image(
      height: 250,
      image: AssetImage('assets/enact_group_members_2021.png'),
    ),
  ),
];

final List<int> colorCodes = <int>[600, 500, 100];

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'About Us',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue[800],
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: entries[index]);
            }));
  }
}
