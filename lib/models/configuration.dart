import 'dart:async';
import './binary.dart';

class Configuration {
  String drive, distro, version, architecture;
  List<Binary> binaries = new List<Binary>();
  String ip, domain;
  String rootPassword;

  bool configured = false;

StreamController<String> driveController = StreamController<String>();
  StreamController<bool> burningController = StreamController<bool>();
  StreamController<bool> configuredController = StreamController<bool>();
  StreamController<List<Binary>> binariesController =
      StreamController<List<Binary>>.broadcast();

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
        drive = value;
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
        Binary binary = binaries.singleWhere((element) {
          return element.name == binaryName;
        }, orElse: () {
          return null;
        });
        if (binary == null)
          binaries.add(Binary(name: binaryName));
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
    //if (binaries == null) return false;
    //if (binaries.isEmpty) return false;
    if (ip == null) return false;
    if (ip.isEmpty) return false;
    if (domain == null) return false;
    if (domain.isEmpty) return false;

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
  }
}
