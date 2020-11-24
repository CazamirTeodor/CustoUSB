import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/connection_button.dart';
import '../constants.dart';

class LDAPSection extends StatelessWidget {
  TextEditingController _controllerIP = TextEditingController();
  TextEditingController _controllerDomain = TextEditingController();

  StreamController<String> streamController = StreamController<String>();

  Function ldapFunction;

  LDAPSection({this.ldapFunction});

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
                          onChanged: (value) {
                            if (value != null) {
                              streamController.add(value);
                              ldapFunction(ip: value);
                            }
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
                          onChanged: (value) {
                              ldapFunction(domain: value);
                            },
                    )),
                  ],
                ),
                Padding(padding: const EdgeInsets.only(left: 22)),
                ConnectionButton(stream: streamController.stream)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
