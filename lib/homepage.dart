import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/add_page.dart';
import 'package:todo/all_providers/database_provider.dart';
import 'package:todo/database/local/notes_local_database.dart';

class homepage extends StatelessWidget{

  List<Map<String , dynamic>> allNotes = [];


  @override
  Widget build(BuildContext context) {
    context.read<DB_provider>().getinitialNotes();
      return Scaffold(
        appBar: AppBar(),

        body: Consumer<DB_provider>(builder:(ctx, provider , __) {
          allNotes = provider.getallNotes();
          // allNotes = ctx.read<DB_provider>().getallNotes();
            return allNotes.isNotEmpty?ListView.builder(itemBuilder: (_, index) {
              return ListTile(
                leading: Text("$index"),
                title: Text(allNotes[index][LocalDB.NOTES_COLUMN_TITLE]),
                subtitle: Text(allNotes[index][LocalDB.NOTES_COLUMN_DESC]),
                trailing: SizedBox(
                  width: 50,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push((context), MaterialPageRoute(builder: (context)=>add_page(
                              isupdate: true,
                              title_text: allNotes[index][LocalDB.NOTES_COLUMN_TITLE],
                              title_desc: allNotes[index][LocalDB.NOTES_COLUMN_DESC],
                              sno: allNotes[index][LocalDB.NOTES_COLUMN_SNO],
                            )
                            ));
                          }, child: Icon(Icons.edit)),

                      InkWell(
                          onTap: () {
                            ctx.read<DB_provider>().deleteNotes(sno: allNotes[index][LocalDB.NOTES_COLUMN_SNO]);
                          },
                          child: Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            }, itemCount: allNotes.length,):Center(child: Text("no notes"));
        }),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push((context), MaterialPageRoute(builder: (context)=>add_page()));
          }, child: Icon(Icons.add),),
    );
  }

}