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
        SizedBox( height: 30),
        SizedBox(
          width: 200,
          height: 60,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color.fromARGB(255, 230, 230, 230),
              ),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  ),
                backgroundColor: Color.fromARGB(255, 67, 107, 31),
                foregroundColor: Colors.white,
                alignment: Alignment.center,
                padding: EdgeInsets.all(1),
              ),
              // TODO: clicking this generates llm
              onPressed: () {},
              child: Text("Generate Recipe"),
              ),
            ), 
          ),
      ],
    );
  }
}