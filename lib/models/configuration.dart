
class Configuration
{
  String drive, distro, version, architecture;
  List<String> binaries;
  String ip, domain;

  void inputDrive(String drive)
  {
    this.drive = drive;
    print("Selected drive: ${this.drive}");
  }

  void inputSpecs(String distro, String version, String architecture)
  {
    this.distro = distro;
    this.version = version;
    this.architecture = architecture;

  }

  void inputBinaries(List<String> binaries)
  {
    this.binaries = binaries;
  }

  void inputLDAP(String ip, String domain)
  {
    this.ip = ip;
    this.domain = domain;
  }

  String generateScript()
  {
    String to_return;

    return to_return;
  }
}