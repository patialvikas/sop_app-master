import 'package:flutter/material.dart';
import '../parts/footer.dart';
import '../parts/appBar.dart';
import '../parts/drawer.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sop_app/models/SopModel.dart';
import 'package:flutter_html/flutter_html.dart';

class Sop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SopPage();
  }
}

class SopPage extends StatefulWidget {
  @override
  _SopPageState createState() => _SopPageState();
}

class _SopPageState extends State<SopPage> {
  Future<SopModel> futureloinlevel;
  var id;
  @override
  void didChangeDependencies() {
    final Map<String, String> argss = ModalRoute.of(context).settings.arguments;
    id = int.parse(argss['id']);
    futureloinlevel = fetchSopModel(id, context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: Sidebar(),
        bottomNavigationBar: BottomBar(),
      body: Container(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Header(), 
            Container( 
              child: FutureBuilder<SopModel>(
                future: futureloinlevel,
                builder: (context, snapshot) {
                  if (snapshot.hasData){
                    return Column(
                      children: <Widget>[

                        Container (
                            decoration: new BoxDecoration ( 
                                color: Color.fromRGBO(234, 112, 12, 1),
                                border: Border( bottom: BorderSide( color: Color.fromRGBO(255, 255, 255, 1), width: 2.0 ) )
                            ),
                            child: new ListTile( title: Text( snapshot.data.name +'-'+ snapshot.data.id.toString(), textAlign: TextAlign.center, style: TextStyle( color: Colors.white, ), )), 
                        ),
                        Center(
                          child: SingleChildScrollView(
                            child: Html( data: snapshot.data.sop != null ? snapshot.data.sop.sop: 'No Sop yet' , padding: EdgeInsets.all(8.0), ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          child: Text('Further Prcesses under '+ snapshot.data.name, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0), ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.child.length,
                          itemBuilder: (_, index) =>
                          Container (
                            decoration: new BoxDecoration (
                                color: Color.fromRGBO(234, 112, 12, 1),
                                border: Border( bottom: BorderSide( color: Color.fromRGBO(255, 255, 255, 1), width: 2.0 ) )
                            ),
                            child: new ListTile(
                              title: Text( snapshot.data.child[index].name, textAlign: TextAlign.center, style: TextStyle( color: Colors.white, ), ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/sop', arguments: { 'id': snapshot.data.child[index].id.toString(), },);
                                 },
                             ),
                           )
                         )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                        alignment: Alignment.center,
                        height: 300,
                        margin: EdgeInsets.all(10),
                        child:Text('No processes for this Yet !!!', style: TextStyle( color: Color.fromRGBO(0,66,96, 1), fontWeight: FontWeight.bold ) , )
                    );
                  }
                  return ( Center ( child: CircularProgressIndicator(), ));
                })
            ),

          ]
        )
      )
    );
  }
  Future<SopModel> fetchSopModel (int i, BuildContext context)async{
    Map bodyr;
    var res = await http.get("http://akkdev.in/api/sop/$id");



    print("checking"+res.body.toString());
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      try {

        
        bodyr = json.decode(res.body)[0] as Map;
      } on Exception catch (e) {
       print('error caught: $e');
      }
    }
    return SopModel.fromJson(bodyr);
  }  
}