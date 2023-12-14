// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

import '../colors.dart';
import '../db_manager.dart';
import '../drawal.dart';

class EditAnime extends StatefulWidget {
  //const About({super.key, required this.title});
  const EditAnime({super.key, required this.itemId});
  
  final String itemId;

  //EditAnime({required this.itemId});


  @override
  _EditAnimeState createState() => _EditAnimeState();
}

class _EditAnimeState extends State<EditAnime> {
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _sinonimo = TextEditingController();
  final TextEditingController _tipo = TextEditingController();
  final TextEditingController _estado = TextEditingController();
  final TextEditingController _episodios = TextEditingController();
  final TextEditingController _fonte = TextEditingController();
  final TextEditingController _genero = TextEditingController();
  final TextEditingController _img = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  String currentCategory = "";
  var imageEncoded;
  List<String> allCategoryData = [];
  final dbHelper = DatabaseHelper.instance;
  late Future<Uint8List> imageBytes;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

// INITIALIZE. RESULT IS A WIDGET, SO IT CAN BE DIRECTLY USED IN BUILD METHOD


  @override
  void initState() {
    super.initState();
    _query();
    var _signatureCanvas = Signature(
      controller: _controller,
      width: 300,
      height: 300,
      backgroundColor: Colors.lightBlueAccent,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawal(),
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          centerTitle: true,
          title: Text("Add Anime"),
        ),
        body: ListView(
          children: [
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      /*
                      InkWell(
                        onTap: () async {
                          final XFile? pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery);

                          if (pickedFile != null) {
                            imageBytes = pickedFile.readAsBytes();
                            setState(() {
                              imageFile = File(pickedFile.path);
                            });
                          }
                        },
                        child: imageFile == null
                            ? CircleAvatar(
                                backgroundColor: MyColors.primaryColor,
                                minRadius: 50,
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: Image.file(
                                  imageFile!,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ).image,
                                minRadius: 100,
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),*/
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'Nome do Anime',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _nome,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um valor valido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'Nome original',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _sinonimo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um valor valido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'Tipo de midia',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _tipo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um valor valido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'estatus de lançamento',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _estado,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um valor valido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'numero de episodios',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _episodios,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um valor valido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'tipo do material original',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _fonte,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um valor valido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'Genero da obra',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _genero,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entre com um valor valido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      /*
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: MyColors.primaryColor),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: allCategoryData
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (selectedItem) => setState(() {
                              currentCategory = selectedItem!;
                            }),
                            hint: Text("Select Category "),
                            value: currentCategory.isEmpty ? null : currentCategory,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),*/
                      TextButtonTheme(
                        data: TextButtonThemeData(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyColors.primaryColor),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formGlobalKey.currentState!.validate()) {
                              _insert();
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insert() async {
    /*
    var base64image;
    if(imageFile?.exists() != null){
       base64image = base64Encode(imageFile!.readAsBytesSync().toList());
    }*/

    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnNome: _nome.text,
      DatabaseHelper.columnSinonimo: _sinonimo.text,
      DatabaseHelper.columnTipo: _tipo.text,
      DatabaseHelper.columnEstado: _estado.text,
      DatabaseHelper.columnEpisodios: _episodios.text,
      DatabaseHelper.columnFonte: _fonte.text,
      DatabaseHelper.columnGenero: _genero.text,
      DatabaseHelper.columnImg: _img.text,
    };
    print('insert stRT');
    currentCategory="";

    final id = await dbHelper.insert(row);
    if (kDebugMode) {
      print('inserted row id: $id');
    }
    _query();
    Navigator.push(context, MaterialPageRoute(builder: (_)=> AnimeList()));
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    if (kDebugMode) {
      print('query all rows:');
    }
    for (var element in allRows) {
      allCategoryData.add(element["nome"]);
    }
    setState(() {});
  }

  void _updateAnime () async {

    Map<String, dynamic> row = {
      DatabaseHelper.columnNome: _nome.text,
      DatabaseHelper.columnSinonimo: _sinonimo.text,
      DatabaseHelper.columnTipo: _tipo.text,
      DatabaseHelper.columnEstado: _estado.text,
      DatabaseHelper.columnEpisodios: _episodios.text,
      DatabaseHelper.columnFonte: _fonte.text,
      DatabaseHelper.columnGenero: _genero.text,
      DatabaseHelper.columnImg: _img.text,
    };

    final id = await dbHelper.update(row);
    if (kDebugMode) {
      print('inserted row id: $id');
    }
    _query();
    Navigator.push(context, MaterialPageRoute(builder: (_)=> AnimeList()));
  }
}
