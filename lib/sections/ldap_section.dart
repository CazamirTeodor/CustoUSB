import 'package:custo_usb/sections/root_subsection.dart';
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
      height: 105,
      width: 305,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text("LDAP Server",
                    style: kTextStyle(kColor: Colors.white))),
            Row(
              children: [
                Column(
                  children: [
                    Text("IP :", style: kTextStyle(kColor: Colors.white)),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4, horizontal: 50),
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
                            configuration.updateParameter(
                                parameter: "ip", value: val);
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
                            configuration.updateParameter(
                                parameter: "domain", value: val);
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                  ],
                ),
                Padding(padding: const EdgeInsets.only(left: 10)),
                ConnectionButton(),
              ],
            ),
            RootSubsection()
          ],
        ),
      ),
    );
  }
}
