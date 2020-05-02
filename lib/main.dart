import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(new MaterialApp(
    title: "Biodata Mahasiswa",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataJSON;
  Future<String> ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("https://api.npoint.io/0fa485c4c98e2974b7fc"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      dataJSON = jsonDecode(hasil.body);
    });
  }

  @override
  void initState() {
    this.ambildata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Biodata Mahasiswa"),
      ),
      body: new ListView.builder(
        itemCount: dataJSON == null ? 0 : dataJSON.length,
        itemBuilder: (context, i) {
          return new Card(
          child: new Container(
            child: new Row(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Image.network(
                      dataJSON[i]['img'],
                      width: 100,
                    )
                  ],
                ),
                new Padding(padding: new EdgeInsets.only(right: 10.0)),
                new Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    
                    new Text("NIM \t:" + dataJSON[i]['NIM'].toString(), style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                    new Text("NAMA\t: "+dataJSON[i]['Nama Lengkap']),
                    new Text("KONTAK\t: "+dataJSON[i]['Nomor HP'].toString()),
                    new Text("JURUSAN\t: "+dataJSON[i]['Jurusan']),
                  ],
                )
              ],
            ),
          ));
        },
      ),
    );
  }
}
