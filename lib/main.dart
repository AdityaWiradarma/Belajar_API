import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_api/add-users.dart';
import 'package:flutter_crud_api/model.dart';
import 'package:flutter_crud_api/repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => MyHomePage(title: 'Flutter Demo'),
        '/add-users': (context) => AddUsers(),
      },
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Daftar Identitas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Users> listUsers = [];
  Repository repository = Repository();

  getData() async{
    listUsers = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: ()=> Navigator.of(context).popAndPushNamed('/add-users'),)
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).popAndPushNamed('/add-users', arguments: [listUsers[index].id, listUsers[index].nama, listUsers[index].alamat]),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listUsers[index].nama,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(listUsers[index].alamat),
                      ],
                    ),
                  ),
                ),
                IconButton(onPressed: () async {
                  bool response = await repository.deleteData(listUsers[index].id);
                  if(response) {
                    print('Delete Data Success');
                  }else{
                    print('Delete Data Failed');
                  }
                  getData();
                }, icon: Icon(Icons.delete))
              ],
            );
          },
          separatorBuilder: (context, index){
            return Divider();
          },
          itemCount: listUsers.length),
    );
  }
}
