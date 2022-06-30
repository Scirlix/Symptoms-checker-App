import 'dart:convert';
import 'package:diagnose_app/check_symptoms.dart';

import 'diseaseNames.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'test.dart';

class Results extends StatefulWidget {
  final List list;
  const Results({required this.list});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  List symptoms = [];
  List diseaseName = [];
  List diseaseSymptoms = [];
  List nonDuplicates = [];
  //late Map<String, List<String>> diseases;
  Map<String, dynamic> diseases = new Map();
  late Map<String, dynamic> data1;
  var level = List.generate(147, (index) => 0);

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/Diseases.json');
    final data = await json.decode(response);
    setState(() {
      diseases.clear();
      diseases = data;
      diseaseName = data.keys.toList();
      for (int k = 0; k < symptoms.length; k++) {
        for (int i = 0; i < names.length; i++) {
          for (int j = 0; j < data[names[i]].length; j++) {
            if (data[names[i]][j] == symptoms[k]) {
              level[i] += 1;
              print("Found a symptom in " +
                  names[i] +
                  " \n" +
                  "which contains: " +
                  data[names[i]][j]);
            }
          }
        }
      }
    });
    //print(diseases);
  }

  @override
  void initState() {
    // TODO: implement initState
    readJson();
    //print(symptoms);
    symptoms = widget.list;
    symptoms.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(diseases[names[0]]);
    print(level);
    int many = 0;
    for (int i = 0; i < level.length - 1; ++i) {
      if (level[i] != 0) {
        many += 1;
      }
    }
    int i = 0;
    print(many);
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 105, 120, 255),
          body: Column(
            //children: [
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Results are:',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int j = level.length - 1; j > 0; --j)
                          if (level[j] > 0) getData(j, i),
                      ],
                    );
                  },
                  itemCount: 1,
                ),
              ),
            ],
          )),
    );
  }

  Padding getData(int j, int i) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 105, 120, 255),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(1, 3))
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 202, 208, 251)),
              child: Column(
                children: [
                  Text(
                    diseaseName[j],
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 14, 14, 14),
                        fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    height: 2,
                  ),
                  Container(
                    child: Wrap(
                      children: [
                        for (int k = 0; k < symptoms.length; ++k)
                          for (i = 0;
                              i < diseases[diseaseName[j]].length - 1;
                              ++i)
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Wrap(
                                children: [
                                  Text(
                                    diseases[diseaseName[j]][i].toString() +
                                        " ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ],
                              ),
                            )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
