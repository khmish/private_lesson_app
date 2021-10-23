import 'package:flutter/material.dart';

class permissions extends StatefulWidget {
  const permissions({Key? key}) : super(key: key);

  @override
  _permissionsState createState() => _permissionsState();
}

class _permissionsState extends State<permissions> {

  bool _checkbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      //key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Permissions',
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
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(12),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Color(0xFFA6A4A4),
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
                    'Add permissions',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                  child: TextFormField(

                    //controller: CnameController,


                    obscureText: false,

                    decoration: InputDecoration(
                      labelText: 'Username or Email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.alternate_email,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),


                  child: Row(
                    children: [
                      Checkbox(
                        value: _checkbox,
                        onChanged: (value) {
                          setState(() {
                            _checkbox = true;
                          });
                        },
                      ),
                      Text('Admin'),
                    ],
                  ),


                  // child: TextFormField(
                  //
                  //  // controller: countryController,
                  //
                  //
                  //   obscureText: false,
                  //
                  //   decoration: InputDecoration(
                  //
                  //   //  labelText: 'CountryName',
                  //
                  //
                  //
                  //     //
                  //     // enabledBorder: OutlineInputBorder(
                  //     //   borderSide: BorderSide(
                  //     //     color: Color(0x00000000),
                  //     //     width: 1,
                  //     //   ),
                  //     //   borderRadius: const BorderRadius.only(
                  //     //     topLeft: Radius.circular(4.0),
                  //     //     topRight: Radius.circular(4.0),
                  //     //   ),
                  //     // ),
                  //     // focusedBorder: OutlineInputBorder(
                  //     //   borderSide: BorderSide(
                  //     //     color: Color(0x00000000),
                  //     //     width: 1,
                  //     //   ),
                  //     //   borderRadius: const BorderRadius.only(
                  //     //     topLeft: Radius.circular(4.0),
                  //     //     topRight: Radius.circular(4.0),
                  //     //   ),
                  //     // ),
                  //     // prefixIcon: Icon(
                  //     //   Icons.alternate_email,
                  //     // ),
                  //
                  //
                  //   ),
                  //
                  //
                  //   keyboardType: TextInputType.emailAddress,
                  // ),


                ),

          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),


            child:

            Row(
              children: [
                Checkbox(
                  value: _checkbox,
                  onChanged: (value) {
                    setState(() {
                      _checkbox = true;
                    });
                  },
                ),
                Text('Admin 2'),
              ],
            ),
          ),

                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),


                  child: Row(
                    children: [
                      Checkbox(
                        value: _checkbox,
                        onChanged: (value) {
                          setState(() {
                            _checkbox = true;
                          });
                        },
                      ),
                      Text('Admin 3'),
                    ],
                  ),
                ),







                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 20),
                  child: ElevatedButton.icon(
                    onPressed: () {

                    //  editcity();

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
