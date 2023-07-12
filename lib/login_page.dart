import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/spin_wheel.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nameTxtCntr = TextEditingController();
  final TextEditingController surnameTxtCntr = TextEditingController();
  bool isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    nameTxtCntr.addListener(_validateForm);
    surnameTxtCntr.addListener(_validateForm);
  }

  @override
  void dispose() {
    nameTxtCntr.dispose();
    surnameTxtCntr.dispose();
    super.dispose();
  }

  void _validateForm() {
    final text1 = nameTxtCntr.text;
    final text2 = surnameTxtCntr.text;

    setState(() {
      isButtonDisabled = text1.isEmpty || text2.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KAYIT EKRANI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://i.pinimg.com/736x/f0/2e/e4/f02ee4fd85ab93166ff92b87906f8d3c.jpg",
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'KAYIT OL',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: nameTxtCntr,
                  decoration: InputDecoration(
                    labelText: 'Lütfen Adınızı Giriniz',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  keyboardType: TextInputType.name,
                  controller: surnameTxtCntr,
                  decoration: InputDecoration(
                    labelText: 'Lütfen Soyadınızı Giriniz',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: isButtonDisabled
                      ? null
                      : () {
                          String name = nameTxtCntr.text;
                          String surname = surnameTxtCntr.text;
                          print('Name: $name, Surname: $surname');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SpinWheel(
                                  name: name,
                                  surname: surname,
                                ),
                              ));
                        },
                  child: Text('Tamamla'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Login App',
    home: LoginPage(),
  ));
}
