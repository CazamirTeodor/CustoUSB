import 'dart:async';
import 'dart:io';
import '../widgets/binary.dart';

class Configuration {
  String drive, distro, version, architecture;
  List<BinaryWidget> selectedBinaries = new List<BinaryWidget>();
  String ip, domain;
  String rootPassword;

  bool configured = false;
  List<BinaryWidget> allBinaries = new List<BinaryWidget>();

  StreamController<String> driveController = StreamController<String>();
  StreamController<bool> burningController = StreamController<bool>();
  StreamController<bool> configuredController = StreamController<bool>();
  StreamController<List<BinaryWidget>> binariesController = StreamController<List<BinaryWidget>>.broadcast();

  static final Configuration _instance = Configuration._internal();


  factory Configuration() {
    return _instance;
  }

  Configuration._internal()
  {
    fetchBinaries();  // fetches all available apt packages
  }

  String burn() {
    burningController.add(true);
    String to_return;

    return to_return;
  }

  void updateParameter({String parameter, String value, BinaryWidget binary}) {
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
        BinaryWidget bin = selectedBinaries.singleWhere((element) {
          return element.name == binary.name;
        }, orElse: () {
          return null;
        });
        if (bin == null)
          selectedBinaries.add(binary);
        else
          selectedBinaries.remove(binary);
        binariesController.add(selectedBinaries);
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
    print("Binaries: ${selectedBinaries}");
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

  void fetchBinaries() {
    String result =
        Process.runSync("apt-cache", ["search", "."]).stdout.toString();
    List<String> rows = result.split("\n");
    rows.forEach((element) {
      List<String> row = element.split(" ");
      allBinaries.add(BinaryWidget(name: row[0]));
    });

    allBinaries.sort((a, b) {
      return a.name.compareTo(b.name);
    });

    getDimensions();
  }

  void getDimensions() {
    int range = 1;
    StringBuffer buffer = StringBuffer();
    int index = 1;

    while(allBinaries.length - index > range)
    {
      allBinaries.getRange(index, index + range).forEach((element) {
        buffer.write(element.name + " ");
      });

      print(buffer.toString());
       var result = Process.runSync(
              "apt-cache", ["--no-all-versions", "show", buffer.toString()])
          .stdout
          .toString();
      print(result);

      List<String> rows = result.split("\n");
      //print(rows);
      rows.removeWhere((element){
        return !(element.startsWith("Installed-Size"));
      });
      print(rows.length);
      List<String> row;
      for(int i=0; i < rows.length; i++)
      {
        row = rows[i].split(" ");
        allBinaries[index + i].dimension = (double.parse(row[1]))*(1/1024);
        print(allBinaries[index + i].name + " " + allBinaries[index +i].dimension.toString());
      }
      print("Am ${rows.length} randuri.");
      index+=rows.length;
      buffer.clear();
    }
  }
}
