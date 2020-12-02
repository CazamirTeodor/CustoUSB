import 'dart:async';
import 'dart:io';
import '../widgets/binary.dart';

class Configuration {
  String drive, distro, version, architecture;
  List<BinaryWidget> binaries = new List<BinaryWidget>();
  String ip, domain;
  String rootPassword;

  bool configured = false;

  StreamController<String> driveController = StreamController<String>();
  StreamController<bool> burningController = StreamController<bool>();
  StreamController<bool> configuredController = StreamController<bool>();
  StreamController<List<BinaryWidget>> binariesController =
      StreamController<List<BinaryWidget>>.broadcast();

  static final Configuration _instance = Configuration._internal();

  factory Configuration() {
    return _instance;
  }

  Configuration._internal();

  String burn() {
    burningController.add(true);
    String to_return;

    return to_return;
  }

  void updateParameter({String parameter, String value, String binaryName}) {
    switch (parameter) {
      case "drive":
        drive = getDriveByName(value);
        driveController.add(value);
        break;
      case "distro":
        distro = value;
        break;
      case "version":
        version = value;
        break;
      case "architecture":
        architecture = value;
        break;
      case "binaries":
        BinaryWidget binary = binaries.singleWhere((element) {
          return element.name == binaryName;
        }, orElse: () {
          return null;
        });
        if (binary == null)
          binaries.add(BinaryWidget(name: binaryName));
        else
          binaries.remove(binary);
        binariesController.add(binaries);
        break;
      case "ip":
        ip = value;
        break;
      case "domain":
        domain = value;
        break;
      case "rootPassword":
        rootPassword = value;
        break;
    }
    configured = getStatus();
    configuredController.add(configured);
  }

  bool getStatus() {
    if (drive == null) return false;
    if (drive.isEmpty) return false;
    if (distro == null) return false;
    if (distro.isEmpty) return false;
    if (version == null) return false;
    if (version.isEmpty) return false;
    if (architecture == null) return false;
    if (architecture.isEmpty) return false;
    if (ip == null) return false;
    if (ip.isEmpty) return false;
    if (domain == null) return false;
    if (domain.isEmpty) return false;
    if (rootPassword == null) return false;
    if (rootPassword.isEmpty) return false;

    return true;
  }

  void printStats() {
    print("Drive: ${drive}");
    print("Distro: ${distro}");
    print("Version: ${version}");
    print("Architecture: ${architecture}");
    print("Binaries: ${binaries}");
    print("Ip: ${ip}");
    print("Domain: ${domain}");
    print("Root password: ${rootPassword}");
  }

  String getDriveByName(String driveName) {
    String to_return;

    var temp = Process.runSync('df', ['-P']).stdout.toString().split("\n");

    temp.removeWhere((element) => !element.contains(new RegExp(r'/dev')));

    temp.forEach((element) {
      element.trim();
      var list = element.split(" ");
      list.removeWhere((element) => element == "");

      if (list[5].startsWith("/media/")) {
        StringBuffer to_add = StringBuffer();
        to_add.write(list[5].substring(list[5].lastIndexOf("/") + 1));

        if (list.length > 6) {
          for (int i = 6; i < list.length; i++) to_add.write(" " + list[i]);
        }

        if (to_add.toString() == driveName) to_return = list[0];
        return;
      }
    });
    return to_return;
  }
}
