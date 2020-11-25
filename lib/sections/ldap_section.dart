import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/connection_button.dart';
import '../constants.dart';
import '../models/configuration.dart';

class LDAPSection extends StatelessWidget {
  TextEditingController _controllerIP = TextEditingController();
  TextEditingController _controllerDomain = TextEditingController();

  var configuration = Configuration();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 320,
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Text("LDAP Server", style: kTextStyle(kColor: Colors.white)),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 40,
                      ),
                      child:
                          Text("IP :", style: kTextStyle(kColor: Colors.white)),
                    ),
                    Text("Domain :", style: kTextStyle(kColor: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          textAlign: TextAlign.center,
                          cursorHeight: 11,
                          style: kTextStyle(kColor: Colors.white),
                          controller: _controllerIP,
                          onChanged: (val) {
                            //if (val != null) {
                              configuration.updateParameter(
                                  parameter: "ip", value: val);
                            //}
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                    Container(
                        width: 120,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          textAlign: TextAlign.center,
                          cursorHeight: 11,
                          style: kTextStyle(kColor: Colors.white),
                          controller: _controllerDomain,
                          onChanged: (val) {
                            //f (val != null) {
                              configuration.updateParameter(
                                  parameter: "domain", value: val);
                            //}
                          },
                        )),
                  ],
                ),
                Padding(padding: const EdgeInsets.only(left: 22)),
                ConnectionButton()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
