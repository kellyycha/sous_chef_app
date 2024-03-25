import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class GenerateTab extends StatefulWidget {
  const GenerateTab({super.key});

  @override
  State<GenerateTab> createState() => _GenerateState();
}

class _GenerateState extends State<GenerateTab> {
  late final Future<LottieComposition> _composition;

  @override
  void initState() {
    super.initState();

    _composition = AssetLottie('assets/animations/cooking2.json').load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox( height: 100),
        // starts frozen
        FutureBuilder<LottieComposition>(
          future: _composition,
          builder: (context, snapshot) {
            var composition = snapshot.data;
            if (composition != null) {
              return Lottie(composition: composition);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        const SizedBox( height: 50),
        Row(
          children: [
            const Spacer(),
            SizedBox(
              width: 200,
              height: 60,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 230, 230, 230),
                  ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      ),
                    backgroundColor: const Color.fromARGB(255, 67, 107, 31),
                    foregroundColor: Colors.white,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(1),
                  ),
                  // TODO: clicking this generates llm + start animation
                  onPressed: () {},
                  child: const Text("Generate Recipe"),
                  ),
                ), 
              ),
              const SizedBox( width: 10), 
              SizedBox(
              width: 50,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromARGB(255, 230, 230, 230),
                  ),
                child: IconButton(
                  icon: const Icon(Icons.tune_rounded),
                  iconSize: 30,
                  color: Colors.black,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(1),
                  // TODO: clicking this opens filter dialogue (dietary, cusine)
                  onPressed: () {},
                ), 
              ), 
            ),
            const Spacer(),
          ],
        ),
          
      ],
    );
  }
}
