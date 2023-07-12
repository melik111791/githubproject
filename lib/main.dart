import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_page.dart';




void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'KARACA ÇARK',
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('KAZANDIRAN ÇARK'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            
            height: 530,
            decoration: const BoxDecoration(
              image: DecorationImage(
              
                alignment: Alignment.center,
                image: NetworkImage(
                    'https://logowik.com/content/uploads/images/karaca-yeni-20229763.jpg'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 20),
           child: ElevatedButton(
              onPressed: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  LoginPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text(
                'BAŞLAMAK İÇİN TIKLAYIN',
              ),
            ),
          ),
        ],
      ),
    );
  }
}


