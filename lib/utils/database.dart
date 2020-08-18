
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler{
  static final _databaseName='myDatabase';
  static final _databaseVersion=1;

  static final table='myTable';

  static final column_id='id';
  static final column_header='header';
  static final column_note='note';
  static final column_date='date';

  static DatabaseHandler instance;

  static DatabaseHandler getInstance(){
    if(instance==null)
      instance=new DatabaseHandler();
    return instance;
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE $table (
    $column_id INTEGER PRIMARY KEY,
    $column_header TEXT NOT NULL,
    $column_note TEXT NOT NULL,
    $column_date TEXT NOT NULL
    )
    ''');
  }

   _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  static Database _database;
  Future<Database> get database async{
    if(_database==null)
      _database= await _initDatabase();
    return _database;
  }

  Future insert(String header, String note, String date) async{
    Database db=await getInstance().database;
    Map<String,dynamic> map=Map();
    map['header']=header;
    map['note']=note;
    map['date']=date;
    await db.insert(table, map);
  }
  
  Future<List> getAllTheData() async{
    Database db=await getInstance().database;
    String rawQuery='SELECT * FROM $table';
    List list= await db.rawQuery(rawQuery);
    return list;
  }

  Future delete(int i) async{
    Database db=await getInstance().database;
    String delete='DELETE FROM $table WHERE $column_id=$i';
    await db.rawDelete(delete);
  }

  Future update(int id, String after) async{
    Database db=await getInstance().database;
    String update='UPDATE $table SET $column_note=? WHERE $column_id=?';
    db.rawUpdate(update,[after,id]);
  }
  Future getIds() async{
    Database db=await getInstance().database;
    String rawQuery='SELECT $column_id FROM $table';
    List list= await db.rawQuery(rawQuery);
    return list;
  }
}