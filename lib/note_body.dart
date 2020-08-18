
import 'package:NoteApp/main.dart';
import 'package:NoteApp/utils/database.dart';
import 'package:flutter/material.dart';

class NoteBody extends StatefulWidget{
  final int i;
  final int id;
  NoteBody({Key key, @required this.i, @required this.id}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NoteBodyState();
  }
}
class _NoteBodyState extends State<NoteBody>{
  final controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NoteApp')),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot){
          int i=widget.i;
          if(snapshot.hasData){
            controller.text='${snapshot.data[i]['note']}';
          }
          return Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(8),
            color: Colors.lightBlueAccent.withOpacity(0.2),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLengthEnforced: true,
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          );
        },
      ),
    );
  }
  @override
  void dispose() {
    String after=controller.text;
    update(widget.id, after);
    super.dispose();
  }
}
update(int id, String after) async{
  DatabaseHandler db=DatabaseHandler.getInstance();
  await db.update(id, after);
}
