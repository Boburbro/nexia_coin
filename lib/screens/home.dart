import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widget/nexia.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int lvl = 0;

  int energy = 0;

  int tapEnergy = 0;

  int fullEnergy = 0;

  int totalEnergy = 0;

  int restartEnergy = 0;

  @override
  void initState() {
    if (lvl == 0) {
      lvl = 1;
      energy = 500;
      tapEnergy = 1;
      fullEnergy = 500;
      totalEnergy = 0;
      restartEnergy = 2;
    }

    start();
    super.initState();
  }

  void start() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      if (energy >= fullEnergy) {
        setState(() {
          energy = fullEnergy;
        });
      } else if (energy < fullEnergy) {
        energy += restartEnergy;

        if (energy >= fullEnergy) {
          setState(() {
            energy = fullEnergy;
          });
        } else {
          setState(() {});
        }
      }
    }
  }

  void addEnergy() {
    if (tapEnergy < energy) {
      setState(() {
        totalEnergy += tapEnergy;
        energy -= tapEnergy;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double appWidth = MediaQuery.of(context).size.width - 100;
    return Scaffold(
      backgroundColor: const Color(0xFF14213d),
      appBar: AppBar(
        backgroundColor: const Color(0xFF14213d),
        elevation: 0,
        title: const Text("Nexia Coin Nexia Legenda"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage("assets/nexia.jpg"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            if (await canLaunchUrlString(
                                "https://t.me/ITwithBobur")) {
                              await launchUrlString("https://t.me/ITwithBobur");
                            }
                          },
                          icon: const Icon(Icons.open_in_new_outlined),
                          label: const Text("Join us"),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Your lvl: $lvl",
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Energy limit: $fullEnergy",
                          style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage("assets/nexia.jpg"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          totalEnergy.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 42),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Color.fromARGB(137, 123, 121, 121),
                      Color.fromARGB(179, 57, 56, 56),
                      Color.fromARGB(255, 40, 61, 107),
                      Color(0xFF14213d),
                    ],
                  ),
                ),
                child: Nexia(
                  taper: addEnergy,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    energy.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        width: appWidth,
                        height: 20,
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: Container(
                          height: 20,
                          width: appWidth * (energy / fullEnergy),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF14213d),
                                Color.fromARGB(255, 13, 43, 108)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
