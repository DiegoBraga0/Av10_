import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_crud_operations/views/edit.dart';
import '../drawal.dart';

import '../colors.dart';
import '../db_manager.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  _AnimeListState createState() => _AnimeListState();
}

class _AnimeListState extends State<AnimeList> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allCategoryData = [];

  @override
  void initState() {
    super.initState();
    _query();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawal(),
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text("Lista de Animes"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text(""),
            Expanded(
                child: ListView.builder(
              itemCount: allCategoryData.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                var item = allCategoryData[index];
                //Uint8List bytes = base64Decode(item['profile']);
                return Container(
                  color: MyColors.orangeTile,
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          /*CircleAvatar(child: Image.memory(bytes,fit: BoxFit.cover,),minRadius: 20,maxRadius: 25,),*/
                              Text("nome da obra : ${item['nome']}"),
                              Text("sinonimo : ${item['sinonimo']}"),
                              Text("Tipo de Midia : ${item['tipo']}"),
                              Text("Status de Lançamento : ${item['estado']}"),
                              Text("Numero de episodios : ${item['episodios']}"),
                              Text("Tipo do material original : ${item['fonte']}"),
                              Text("Genero da obra : ${item['genero']}"),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => EditAnime(itemId: item['id'])),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              _delete(item['_id']);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                      const Divider(
                        color: MyColors.orangeDivider,
                        thickness: 1,
                      ),
                    ],
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRowsofAnime();
    print('query all rows:');
    allRows.forEach(print);
    allCategoryData = allRows;
    setState(() {});
  }

  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
    _query();
  }
}
