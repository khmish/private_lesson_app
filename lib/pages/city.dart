import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CityWidget extends StatefulWidget {
  CityWidget({Key? key}) : super(key: key);

  @override
  _CityWidgetState createState() => _CityWidgetState();
}

class _CityWidgetState extends State<CityWidget> {

  late TextEditingController cityNameController;
  late TextEditingController countryController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    cityNameController = TextEditingController();
    countryController = TextEditingController();
  }

  var _baseURL = 'https://privatelesson.herokuapp.com/api/city';
  Future<void> editcity() async {
    var baseUrl = _baseURL;
    try {
      // if (page > 0) {
      baseUrl = _baseURL;
      // }
      var url = Uri.parse(baseUrl);
      var response = await http.post(
        url,
        body: {
          "name": cityNameController.text,
          "country_name": countryController.text,
        },
        // headers: <String, String>{
        //   'Accept': 'application/json',
        //   'Content-Type': 'application/json; charset=UTF-8',
        //   // 'Authorization': 'Bearer $token',
        // },
      );

      print(response.body);
      if (response.statusCode == 200) {
        // dynamic body = json.decode(response.body)['data'];
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
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
      backgroundColor: Color(0xFFF5F5F5),




      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              shape: BoxShape.rectangle,
              border: Border.all(
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                  child: Text(
                    'Edit City',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                  child: TextFormField(
                    controller: cityNameController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'CityName',
                      prefixIcon: Icon(
                        Icons.alternate_email,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
                  child: TextFormField(
                    controller: countryController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'CountryName',
                      prefixIcon: Icon(
                        Icons.alternate_email,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 20),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      editcity();
                    },
                    label: Text('Button'),
                    icon: Icon(
                      Icons.login_outlined,
                      size: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}
