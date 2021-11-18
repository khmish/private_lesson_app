import 'package:flutter/material.dart';

class SelectListWidget extends StatefulWidget {
  late List<dynamic> list;
  Function(List<dynamic>) callback;
  SelectListWidget({Key? key, required this.list, required this.callback})
      : super(key: key);

  @override
  _SelectListWidgetState createState() => _SelectListWidgetState();
}

class _SelectListWidgetState extends State<SelectListWidget> {
  TextEditingController searchContorller = new TextEditingController();
  List<dynamic> selectedList = <dynamic>[];
  List<dynamic> searchList = [];
  List<bool> localval = <bool>[];
  @override
  void initState() {
    super.initState();
    searchList = widget.list;
    for (var itemlist in widget.list) {
      localval.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: searchContorller,
            onChanged: (val) {
              setState(() {
                searchList = widget.list;
                searchList = searchList
                    .where((element) =>
                        element.name.toLowerCase().contains(val.toLowerCase()))
                    .toList();
              });
            },
            decoration: InputDecoration(
              labelText: 'Search',
              border: const OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
            keyboardType: TextInputType.text,
          ),
          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height*.9,
              // width: MediaQuery.of(context).size.width*.8,

              child: ListView.builder(
                itemCount: searchList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Icon(Icons.note_add_rounded),
                    title: Text("${searchList[index].name}"),
                    leading: Checkbox(
                      onChanged: (value) {
                        print(value);
                        if (value == true) {
                          setState(() {
                            localval[index] = true;
                            selectedList.add(searchList[index]);
                          });
                        } else {
                          setState(() {
                            localval[index] = false;
                            selectedList.remove(searchList[index]);
                          });
                        }
                      },
                      value: localval[index],
                    ),
                    dense: true,
                  );
                },
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // print(selectedList.join(', '));
              widget.callback(selectedList);
              Navigator.pop(context);
            },
            icon: Icon(Icons.add),
            label: Text("Save!"),
          ),
        ],
      ),
    );
  }
}
