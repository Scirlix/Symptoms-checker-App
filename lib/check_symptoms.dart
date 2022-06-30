import 'package:diagnose_app/results.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class SymptomsChecker extends StatefulWidget {
  const SymptomsChecker({Key? key}) : super(key: key);

  @override
  State<SymptomsChecker> createState() => _SymptomsCheckerState();
}

class _SymptomsCheckerState extends State<SymptomsChecker> {
  List _items = [];
  List _itemsForDisplay = [];
  List _chosenItems = [];
  int maxheight = 0;
  ScrollController _scrollController = ScrollController();
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/data/Symptoms.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["Symptoms"];
      _itemsForDisplay = _items;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 120, 255),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            // Display the data loaded from sample.json
            // _ListChosenItem(23),
            SizedBox(
              height: 25,
            ),
            _searchBar(),
            Divider(
              height: 1,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return _ListItem(index);
                },
                itemCount: _itemsForDisplay.length,
              ),
            ),
            Divider(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: LimitedBox(
                maxHeight: 200,
                child: Scrollbar(
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    //scrollDirection: Axis.horizontal,
                    child: Wrap(
                      children: _chosenItems.map((item) {
                        //print(_chosenItems);
                        return chosenItems(item);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.black,
              height: 10,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_chosenItems.length > 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          // sending chosenItems to results.dart
                          builder: (context) => Results(list: _chosenItems)));
                    } else {
                      showAlertDialog(BuildContext context) {
                        // set up the button
                        Widget okButton = TextButton(
                          child: Text("OK"),
                          onPressed: () {},
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Choose A Symptom"),
                          content: Text("Please choose at least one symptom."),
                          actions: [
                            okButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    }
                    /* Navigator.of(context).push(MaterialPageRoute(
                        // sending chosenItems to results.dart
                        builder: (context) => Results(list: _chosenItems))); */
                  },
                  child: Text(
                    "Find Results",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

  Padding chosenItems(item) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Builder(builder: (context) {
        return ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _itemsForDisplay.add(item);
              //_items.add(item);
              _chosenItems.remove(item);
            });
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
          label: Text(item),
          icon: Icon(
            Icons.remove_circle,
            color: Color.fromARGB(255, 255, 217, 216),
          ),
        );
      }),
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Color.fromARGB(255, 244, 244, 244),
            hintText: 'Search Symptoms'),
        style: TextStyle(color: Color.fromARGB(255, 22, 25, 52)),
        maxLines: 1,
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _itemsForDisplay = _items.where((item) {
              var itemEntity = item.toLowerCase();
              return itemEntity.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _ListItem(index) {
    return Wrap(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _chosenItems.add(_itemsForDisplay[index]);
              _itemsForDisplay.removeAt((index));
              //_items.removeAt((index));
            });
          },
          style: ElevatedButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          child: Text(_itemsForDisplay[index]),
        ),
      ],
    );
  }

  _ListChosenItem(index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20)),
            child: Text(_chosenItems[index]),
          ),
        ],
      ),
    );
  }
}
