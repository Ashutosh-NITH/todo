import 'package:flutter/cupertino.dart';
import 'package:todo/database/local/notes_local_database.dart';

class DB_provider extends ChangeNotifier{
  LocalDB mydb;

  DB_provider({required this.mydb});

  List<Map<String , dynamic>> Notes =[];
  List<Map<String , dynamic>> getallNotes ()=> Notes;

  Future<void> addNotes({required String mtitle , required String mdesc}) async {
    bool check = await mydb.add(title: mtitle, desc: mdesc);
    if(check){
      Notes = await mydb.getNotes();
      notifyListeners();
    }
  }
  Future<void> updateNotes({required String mtitle , required String mdesc, required int sno}) async {
    bool check = await mydb.update(title: mtitle, desc: mdesc, sno: sno);
    if(check){
      Notes = await mydb.getNotes();
      notifyListeners();
    }
  }
  Future<void> deleteNotes({ required int sno}) async {
    bool check = await mydb.delete(sno: sno);
    if(check){
      Notes = await mydb.getNotes();
      notifyListeners();
    }
  }
  Future<void> getinitialNotes() async {
    Notes = await mydb.getNotes();
    notifyListeners();
  }
  void showmessage(){
    notifyListeners();
  }
}