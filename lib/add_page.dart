import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/all_providers/database_provider.dart';

class add_page extends StatelessWidget{
  bool isupdate = false;
  String title_text ;
  String title_desc;
  int sno;
  add_page({
    this.isupdate = false ,
    this.title_text = "",
    this.title_desc = "",
    this.sno = 0,
  });

  TextEditingController input_title = TextEditingController();
  TextEditingController input_desc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var message = "";
    if(isupdate){
      input_title.text = title_text;
      input_desc.text = title_desc;
    }
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Text("add Notes"),
          TextField(
            controller: input_title,
            decoration: InputDecoration(
              label: Text("Enter Title"),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide:  BorderSide(
                  color: Colors.greenAccent,
                  width: 2,
                )
              ),
               enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide:  BorderSide(
                      color: Colors.greenAccent,
                      width: 2,
                    )
                )
            ),
          ),
          SizedBox(height: 50,),
          TextField(
            controller: input_desc,
            decoration: InputDecoration(
                label: Text("Enter Description"),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide:  BorderSide(
                      color: Colors.greenAccent,
                      width: 2,
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide:  BorderSide(
                      color: Colors.greenAccent,
                      width: 2,
                    )
                )
            ),
          ),
          ElevatedButton(onPressed: (){
            var mytitle = input_title.text;
            var mydesc = input_desc.text;

            if(mydesc.isNotEmpty && mytitle.isNotEmpty){
              if(isupdate){
                context.read<DB_provider>().updateNotes(mtitle: mytitle, mdesc: mydesc, sno: sno);
              }else{
                context.read<DB_provider>().addNotes(mtitle: mytitle, mdesc: mydesc);
              }
              Navigator.pop(context);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please fill all the required blanks!!'),
                  duration: Duration(seconds: 1),
                ),
              );
            }

          }, child: Text("Submit")),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
            input_title.clear();
            input_desc.clear();
          }, child: Text("cancel")),

        ],
      ),
    );
  }

}