import 'dart:async';

class Configuration {
  String drive, distro, version, architecture;
  List<String> binaries;
  String ip, domain;

  bool configured = false;
  
  StreamController<bool> burningController = StreamController<bool>();
  StreamController<bool> configuredController = StreamController<bool>();

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

  void updateParameter({String parameter, String value, List<String> bin}) {
    switch (parameter) {
      case "drive":
        drive = value;
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
        binaries = bin;
        break;
      case "ip":
        ip = value;
        break;
      case "domain":
        domain = value;
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
    // if (version == null) return false;
    // if (version.isEmpty) return false;
    // if (architecture == null) return false;
    // if (architecture.isEmpty) return false;
    // if (binaries == null) return false;
    // if (binaries.isEmpty) return false;
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
