import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sous_chef_app/pages/recipe_card.dart';
import 'package:sous_chef_app/pages/recipe_confirmation.dart';
import 'package:sous_chef_app/widgets/filter.dart';

final GlobalKey<FilterPopupState> filterPopupKey = GlobalKey<FilterPopupState>();

class GenerateTab extends StatefulWidget {
  const GenerateTab({super.key});

  @override
  State<GenerateTab> createState() => _GenerateState();
}

class _GenerateState extends State<GenerateTab> {
  bool _isPlaying = false;
  late final Future<LottieComposition> _composition;
  
  List<String> dietaryRestrictions = [];
  List<String> cuisines = [];


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
        _isPlaying ?
        FutureBuilder<LottieComposition>(
          future: _composition,
          builder: (context, snapshot) {
            var composition = snapshot.data;
            return Lottie(composition: composition);
          },
        )
        : Container(
          height: 202,
          padding:EdgeInsets.all(30),
          alignment: Alignment.center,
          child: const Text(
            'WARNING: Sous-Chef will try to recommend recipes that use ingredients expiring soon. Please check all ingredients for signs of rotting before use.',
            style: TextStyle(
              color:Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
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
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying; // Toggle animation
                      // TODO: load chatgpt here. after loaded, show dialog.
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return RecipeConfirmation(dietaryRestrictions: dietaryRestrictions, cuisines: cuisines);
                        },
                      ); 
                    });
                  },
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FilterPopup(
                          key: filterPopupKey,
                        );
                      },
                    ).then((value) {
                      dietaryRestrictions = filterPopupKey.currentState!.getSelectedDietaryRestrictions();
                      cuisines = filterPopupKey.currentState!.getSelectedCuisines();
                    });
                  },
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
