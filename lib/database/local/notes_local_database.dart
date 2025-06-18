import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {

  ///constructor
  LocalDB._();

  /// sinngleton instance
  static final LocalDB getInstance = LocalDB._();

  /// variable => database
  Database? mylocalDB;

  static final TABLE_NAME = "table1";
  static final NOTES_COLUMN_SNO = "notes_sno";
  static final NOTES_COLUMN_TITLE = "notes_title";
  static final NOTES_COLUMN_DESC = "notes_desc";
  Future<Database> getDB ()async{

    mylocalDB ??= await createDB();
    return mylocalDB!;


  }

  Future<Database> createDB() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    var apppath = join(appdir.path , "notes.db");
    return await openDatabase(apppath , onCreate: (db, version){
      db.execute("create table $TABLE_NAME($NOTES_COLUMN_SNO integer primary key autoincrement , $NOTES_COLUMN_TITLE text , $NOTES_COLUMN_DESC text)");
      //
    }, version:  1);
  }
  Future<bool> add({required String title , required String desc})async{
    var DB = await getDB();
    int rowsaffected = await DB.insert(TABLE_NAME, {
        NOTES_COLUMN_TITLE : title,
        NOTES_COLUMN_DESC : desc,
    });
    return rowsaffected>0;
  }
  Future<bool> update({required String title , required String desc, required int sno})async{
    var DB = await getDB();
    int rowsaffected = await DB.update(TABLE_NAME, {
      NOTES_COLUMN_TITLE : title,
      NOTES_COLUMN_DESC : desc,
    }, where: "$NOTES_COLUMN_SNO = $sno"  );
    return rowsaffected>0;
  }
  Future<bool> delete( {required int sno})async{
    var DB = await getDB();
    int rowsaffected = await DB.delete(TABLE_NAME, where: "$NOTES_COLUMN_SNO = $sno");
    return rowsaffected>0;
  }
  Future<List<Map<String, dynamic>>> getNotes()async {
    var DB = await getDB();
    return await DB.query(TABLE_NAME);
  }

}