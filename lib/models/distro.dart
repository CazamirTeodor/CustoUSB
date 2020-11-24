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
    print(
        "Acum creez un Distro cu numele ${json['name']}, versiunile ${json['versions']} si link-ul ${json['link']}");
    var versions_from_json = json['versions'];
    List<String> vers = new List<String>.from(versions_from_json);
    return Distro(
        name: json['name'],
        versions: vers,
        archs: json['archs'],
        link: json['link']);
  }
}
