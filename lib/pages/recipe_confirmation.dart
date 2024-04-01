import 'package:flutter/material.dart';
import '../services/openai/chat_service.dart';

class RecipeConfirmation extends StatefulWidget {
  final List<String> dietaryRestrictions;
  final List<String> cuisines;

  const RecipeConfirmation({
    Key? key,
    required this.dietaryRestrictions,
    required this.cuisines,
  }) : super(key: key);

  @override
  State<RecipeConfirmation> createState() => _RecipeConfirmationState();
}

class _RecipeConfirmationState extends State<RecipeConfirmation> {
  String? response;

  @override
  void initState() {
    super.initState();
    // Load response from ChatGPT
    _loadResponse();
  }

  void _loadResponse() async {
    response = await ChatService().request(promptFlow(widget.dietaryRestrictions, widget.cuisines));
    setState(() {
      // Show popup dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Response: $response'), // Display the response in the dialog content
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // TODO: pass in recipe text to recipe card UI
                  Navigator.of(context).pop(); 
                },
                child: Text('Confirm'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              response ?? "",
              style: TextStyle(color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }
}


// TODO: put in new file and call in generate_tab
String promptFlow(List<String> dietaryRestrictions, List<String> cuisines) {
  print(dietaryRestrictions);
  print(cuisines);

  return "prompt";
}
