import 'package:flutter/material.dart';

class Distro {
  String name;
  List<String> versions;
  List<String> archs;
  String link;

  Distro(
      {@required this.name,
      @required this.versions,
      @required this.archs,
      @required this.link});

  factory Distro.fromJson(Map<String, dynamic> json) {
    print(json);
    var versions_from_json = json['versions'];
    List<String> vers = new List<String>.from(versions_from_json);

    var arch_from_json = json['archs'];
    List<String> archs = new List<String>.from(arch_from_json);

    return Distro(
        name: json['name'],
        versions: vers,
        archs: archs,
        link: json['link']);
  }
}
