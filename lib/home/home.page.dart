import 'package:flutter/material.dart';
import 'package:weather/common/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cityCntrl = TextEditingController();
  @override
  void dispose() {
    _cityCntrl.clear();
    _cityCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 50,
                child: TextField(
                  controller: _cityCntrl,
                  decoration:
                      const InputDecoration(labelText: 'Write yor city'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: MaterialButton(
                    color: Colors.green,
                    child: const Text('Accept'),
                    onPressed: _onAccept,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _onAccept() {
    if (_cityCntrl.text.isNotEmpty) {
      Navigator.of(context)
          .pushNamed(infoCurrentPath, arguments: _cityCntrl.text);

      _cityCntrl.clear();
    }
  }
}
