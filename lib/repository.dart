import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud_api/model.dart';
import 'package:http/http.dart' as http;

class Repository{
  final _baseUrl = 'https://627d0b32bf2deb7174e646c3.mockapi.io';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl+'/users'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Users> users = it.map((e) => Users.fromJson(e)).toList();
        return users;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String nama, String alamat) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl+'/users'),
          body: {"nama": nama, "alamat": alamat});

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(int id, String nama, String alamat) async{
    try {
      final response = await http.put(Uri.parse(_baseUrl + '/users/' + id.toString()),
      body: {
        'nama': nama,
        'alamat': alamat
      });
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse(_baseUrl + '/users/' + id));
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}