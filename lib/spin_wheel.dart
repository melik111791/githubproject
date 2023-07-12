import 'package:flutter/material.dart';
import 'package:flutter_application_1/ticket.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'dart:async';
import 'package:confetti/confetti.dart';
import 'dart:math';

class SpinWheel extends StatefulWidget {
  const SpinWheel({
    super.key,
    required this.name,
    required this.surname,
  });
  final String name;
  final String surname;

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late Animation<double> _rotationAnimation;
  late AnimationController _animationController;
  late ConfettiController confettiController1 =
      ConfettiController(duration: const Duration(seconds: 3));
  final selected = BehaviorSubject<int>();
  double opacityValue = 0;
  String kazanilan = '';

  List<String> items = [
    'Sepette %5 indirim',
    '50 TL indirim',
    'Sepette %15 indirim',
    '100 TL indirim',
    'Sepette %20 indirim',
    '200 TL indirim',
  ];
  String urunAdi = "";

  @override
  void initState() {
    super.initState();
    print("sayfa açıldı");
    urunAdi = "Air Pro cook";
    _animationController = AnimationController(
      duration: Duration(seconds: 2), // Adjust the duration as needed
      vsync: this,
    );

    _rotationAnimation =
        Tween<double>(begin: 0.0, end: 2.0).animate(_animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reset();
            }
          });

    _animationController.forward();
  }

  @override
  void dispose() {
    print("sayfa kapandı");
    _animationController.dispose();
    selected.close();
    super.dispose();
  }

//KONFETİ İÇİN YILDIZ ŞEKLİ VERDİK VE BURDA TASARLADIK
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);
    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KAZANDIRAN ÇARK',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: null,
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          controller: scrollController,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: FortuneWheel(
                      selected: selected.stream,
                      indicators: const <FortuneIndicator>[
                        FortuneIndicator(
                          alignment: Alignment
                              .topCenter, // <-- changing the position of the indicator
                          child: TriangleIndicator(
                            color: Colors
                                .white, // <-- changing the color of the indicator
                          ),
                        ),
                      ],
                      animateFirst: false,
                      items: [
                        for (int i = 0; i < items.length; i++) ...<FortuneItem>{
                          FortuneItem(
                            child: Text(
                              items[i],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            style: FortuneItemStyle(
                              color:
                                  i % 2 == 0 //if yapsısı çarkın renkleri için
                                      ? Colors.orange
                                      : Colors.black,
                              borderColor: Colors.white,
                              borderWidth: 2.3,
                            ),
                          ),
                        },
                      ],
                      onAnimationStart: () {
                        setState(
                          () {
                            opacityValue = 0;
                          },
                        );
                      },
                      onAnimationEnd: () {
                        setState(
                          () {
                            kazanilan = items[selected.value];
                            opacityValue = 1;

                            confettiController1.play();

                            Timer(
                              Duration(seconds: 8),
                              () {
                                confettiController1.stop();
                              },
                            );
                          },
                        );

                        scrollController.animateTo(10000,
                            duration: Duration(seconds: 2),
                            curve: Curves.bounceIn);
                        print(kazanilan);
                      },
                    ),
                  ),
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: Transform.rotate(
                      angle: 2 * 3.14159265359,
                      child: Container(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://logowik.com/content/uploads/images/karaca-yeni4371.jpg',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(
                  () {
                    selected.add(
                      Fortune.randomInt(0, items.length),
                    );
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 15.0),
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange,
                ),
                child: Center(
                  child: Text('ÇEVİR-KAZAN'),
                ),
              ),
            ),
            Opacity(
              opacity: opacityValue,
              child: TicketWidget(
                width: 350,
                height: 380,
                color: Color.fromARGB(255, 251, 208, 153),
                isCornerRounded: true,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                padding: EdgeInsets.all(20),
                child: TicketData(
                    text: kazanilan + ' ÖDÜL BİLETİ',
                    ad: widget.name,
                    soyad: widget.surname),
              ),
            ),
            Center(
              child: ConfettiWidget(
                confettiController: confettiController1, //attach object created
                shouldLoop: true,
                blastDirection: -3.14 / 2,
                blastDirectionality: BlastDirectionality.directional,
                particleDrag: 0.03,
                emissionFrequency: 0.1,
                canvas: MediaQuery.of(context).size * 2,
                colors: [Colors.orange, Colors.black, Colors.red],
                gravity: 0.6,
                numberOfParticles: 10,
                createParticlePath: drawStar,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
