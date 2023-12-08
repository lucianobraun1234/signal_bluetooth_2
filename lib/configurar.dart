import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '/Background/Widget.dart';
import 'criar.dart';

class Configurar extends  StatefulWidget  {
  @override
  State<Configurar> createState() => _Configurar();
}
//pagina 171 pegar a listview
class _Configurar extends State<Configurar> {

  final cima= TextEditingController();
  final baixo = TextEditingController();

String decisao="";


  void initState () {
    super.initState();

    _asyncMethod();


  }

  _asyncMethod() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //prefs.setString('credenciais',resultado2);
    var cima1=prefs.getString('cima');
   var baixo1= prefs.getString('baixo');
   var esquerda1= prefs.getString('esquerda');
   var direita1= prefs.getString('direita');
   if(cima1!=null){
     cima.text=cima1;
   }
   else{
     cima.text='';
   }
    if(baixo1!=null){
      baixo.text=baixo1;
    }
    else{
      baixo.text='';
    }
    var des= prefs.getString('decisao');
    if(des==null){
     setState(() {
       decisao="bluetooth";
     });
     prefs.setString('decisao',decisao);
    }
    else{
      setState(() {
        decisao=des;
      });
    }


  }













  _start(){
    return Container();
  }



  @override
  Widget build(BuildContext context) {


    return Stack(children: [
      //BackgroundImage1(),
      // BackgroundImage(),

      Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,

        //backgroundColor: Colors.white,
        body:
        Container(

            child:
            SingleChildScrollView(

              child:
              Center(

                child:
                Column(
                    children: [
                      SizedBox(height:100),
                      //definindo a margem superior do apk
                      Container(
                        //password


                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child:
                        TextButton(onPressed: () {
                          //função do botão
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>Inicio()));


                        }

                            , child: Text('Retornar', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.8)))


                        ),
                      ),
                      SizedBox(height:20),
                TextFormField(
                 // readOnly: true,
                  controller:cima,
                  decoration: new InputDecoration(
                    labelText: " Configurar Nome",
                    //fillColor: Colors.white,
                    //filled: true,
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                    //fillColor: Colors.green
                  ),

                  style: new TextStyle(
                    fontSize:14,
                    fontFamily: "Poppins",
                  ),
                ),
                      SizedBox(height:15),
                      TextFormField(
                      //  readOnly: true,
                        controller:baixo,
                        decoration: new InputDecoration(
                          labelText: " Configurar rastrear",
                          //fillColor: Colors.white,
                          //filled: true,
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                            ),
                          ),
                          //fillColor: Colors.green
                        ),

                        style: new TextStyle(
                          fontSize:14,
                          fontFamily: "Poppins",
                        ),
                      ),

                      SizedBox(height:15),
                      Container(
                        //password


                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child:
                        TextButton(onPressed: () async {
                          //função do botão
                          SharedPreferences prefs = await SharedPreferences.getInstance();

                          //prefs.setString('credenciais',resultado2);
                          prefs.setString('nome',cima.text);
                          prefs.setString('rastrear',baixo.text);

                          Alerta().alerta1(context,'Dados salvos','com sucesso!!');


                        }

                            , child: Text('Salvar', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.8)))


                        ),
                      ),
                      SizedBox(height:50),
                      Container(
                        //password


                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child:
                        TextButton(onPressed: () async {
                          //função do botão
                          SharedPreferences prefs = await SharedPreferences.getInstance();

                          //prefs.setString('credenciais',resultado2);
                         var des=await  prefs.getString('decisao');
                         if(des==null){
                           des='bluetooth';
                         }
                         if(des.contains('bluetooth')){
                           des='wifi';
                           setState(() {
                             decisao=des!;
                           });
                           await prefs.setString('decisao',des);
                           Alerta().alerta1(context,'Dados salvos','com sucesso!!');
                              return;

                         }
                          if(des.contains('wifi')){
                            des='bluetooth';
                            setState(() {
                              decisao=des!;
                            });
                            await prefs.setString('decisao',des);
                            Alerta().alerta1(context,'Mudança de rastreio efetuada','com sucesso!!');
                            return;

                          }



                        }

                            , child: Text('Rastreando '+ decisao, style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.8)))


                        ),
                      ),







                    ]
                ),),)
        ),)

      ,
      WillPopScope(
          onWillPop: () async {

            print('Press again Back Button exit');

            // showAlertDialog(context);

            // print('sign out');
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>Timer2()));

            return true;

          },
          child: Container(
            alignment: Alignment.center,
            child: Text(''),
          ))
    ]);
  }



}
class Alerta{

  void alerta1(BuildContext context,String titulo,String mensagem)
  {
    // configura o button

    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text(titulo),
      content: Text(mensagem),
      actions: [

      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

}








