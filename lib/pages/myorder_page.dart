import 'package:flutter/material.dart';
import 'package:private_lesson_app/pages/main_search.dart';


class myorder_page extends StatefulWidget {
  const myorder_page({Key? key}) : super(key: key);

  @override
  _myorder_pageState createState() => _myorder_pageState();



}

class _myorder_pageState extends State<myorder_page> {




  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController textController;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late List<String> _genderList = ['male', 'female'];
  String _genderSelectedValue = "male";
  late int _citySelectedValue = 1;
  late bool passwordVisibility;


  late TextEditingController cityNameController;
  late TextEditingController countryController;


  late TextEditingController leveleducationNameController;
  late TextEditingController subjectNameController;





  //*********  Show/Hide Level education page
  bool _isVisibleLevel = false;
  void showLeveleducationPage() {
    setState(() {
      _isVisibleLevel = !_isVisibleLevel;
    });
  }




  @override
  void initState() {
    super.initState();
    textController = TextEditingController();

    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;


  }

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Private Lesson',
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                      MediaQuery.of(context).size.width > 1000 ? 4 : 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 50),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        //showUserPage();
                      },
                      label: Text('All'),
                      icon: Icon(
                        Icons.subject,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // showCityPage();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchWidget()),
                        );

                      },
                      label: Text('New'),
                      icon: Icon(
                        Icons.add,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        showLeveleducationPage();
                      },
                      label: Text('Accepted'),
                      icon: Icon(
                        Icons.done,
                        size: 15,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        //showSubjectPage();
                      },
                      label: Text('Canceled'),
                      icon: Icon(
                        Icons.cancel_outlined,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),




              SafeArea(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,

                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'All orders',
                          ),
                        ),


                        Card(
                          child:Container(
                            height: 100,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                  ),
                                ),
                                Expanded(
                                  child:Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: ListTile(
                                            title: Text("Order #1"),
                                            subtitle: Text("Order state: Accepted"),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                child:Text("More details"),
                                                onPressed: ()
                                                {},
                                              ),
                                              SizedBox(width: 8,),
                                              // TextButton(
                                              //   child: Text("ADD TO QUEUE"),
                                              //   onPressed: (){},
                                              // ),
                                              SizedBox(width: 8,)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  flex:8 ,
                                ),
                              ],
                            ),
                          ),
                          elevation: 8,
                          margin: EdgeInsets.all(10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






