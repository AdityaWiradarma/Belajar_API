import 'package:flutter/material.dart';
import 'package:flutter_crud_api/repository.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({Key? key}) : super(key: key);

  @override
  _AddUsersState createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  Repository repository = Repository();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as
    List<String>;
    if (args[1].isNotEmpty) {
      _namaController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _alamatController.text = args[2];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Users"),
      ),
      body: Container(
        child: Column(children: [
          TextField(
            controller: _namaController,
            decoration: InputDecoration(
              hintText: 'Nama'
            ),
          ),
          TextField(
            controller: _alamatController,
            decoration: InputDecoration(
                hintText: 'Alamat'
            ),
          ),
          ElevatedButton(onPressed: () async{
            bool response = await repository.postData(_namaController.text, _alamatController.text);
            
            if(response){
              Navigator.of(context).popAndPushNamed('/home');
            }else{
              print('Post Data Gagal!');
            }
          }, child: Text('Submit')),
          ElevatedButton(onPressed: () async{
            bool response = await repository.putData(int.parse(args[0]), _namaController.text, _alamatController.text);
            if(response){
              Navigator.of(context).popAndPushNamed('/home');
            }else{
              print('Post Data Gagal!');
            }
          }, child: Text('Update'))
        ],),
      ),
    );
  }
}
