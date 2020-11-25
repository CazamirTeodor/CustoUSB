import 'package:custo_usb/models/configuration.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ConnectionButton extends StatefulWidget {
  bool connection = false;
  bool started = false;

  String connectionString = "Check status";
  var configuration = Configuration();


  @override
  State<ConnectionButton> createState() {
    return _ConnectionButtonState();
  }
}

class _ConnectionButtonState extends State<ConnectionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              color: this.widget.started
                  ? (!this.widget.connection ? Colors.red[400] : Colors.green)
                  : Colors.orange[300],
              border: Border.all(color: Colors.white),
            ),
            child: IconButton(
                onPressed: checkConnectivity,
                icon: Icon(Icons.computer_rounded),
                color: Colors.white,
                tooltip: 'Check server connectivity'),
          ),
          Text(
            this.widget.connectionString,
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void checkConnectivity() {
    if (this.widget.configuration.ip == null) return;
    print("Trying to ping ${this.widget.configuration.ip}...");
    Process.run('ping', ['-t', '2', '-W', '-1', this.widget.configuration.ip]).then((value) {
      this.widget.started = true;
      print("Exit code: ${value.exitCode}");
      if (value.exitCode == 0)
        setState(() {
          this.widget.connection = true;
          this.widget.connectionString = "Server UP";
        });
      else
        setState(() {
          this.widget.connection = false;
          this.widget.connectionString = "Server DOWN";
        });
    });
  }
}
