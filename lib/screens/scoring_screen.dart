import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/get_athletes_provider.dart';
import 'package:test/widgets/error_snakbar.dart';
import '../widgets/score_field_widget.dart';
import '../widgets/search_widget.dart';

class Scoring extends StatefulWidget {
  const Scoring({super.key});

  @override
  State<Scoring> createState() => _ScoringState();
}

class _ScoringState extends State<Scoring> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    TextEditingController score1Controller = TextEditingController();
    TextEditingController score2Controller = TextEditingController();
    TextEditingController score3Controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.only(top: 12, right: 12, left: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Text('Scoring',
              style: TextStyle(
                  fontSize: 32,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold)),
          SearchWidget(searchController: searchController),
          Text(
            Provider.of<GetAtlete>(context).name,
            style: const TextStyle(
                fontSize: 32, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ScoreField(
                scoreController: score1Controller,
                label: 'Execution',
              ),
              ScoreField(
                scoreController: score2Controller,
                label: 'Difficulty',
              ),
              ScoreField(
                scoreController: score3Controller,
                label: 'Flow',
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 55)),
              onPressed: () {
                setScoreMethod(
                    context,
                    searchController,
                    score1Controller,
                    score2Controller,
                    score3Controller,
                    Provider.of<GetAtlete>(context, listen: false).name);
              },
              child: const Text('Set Score'))
        ],
      ),
    );
  }

  void setScoreMethod(
    BuildContext context,
    TextEditingController searchController,
    TextEditingController score1Controller,
    TextEditingController score2Controller,
    TextEditingController score3Controller,
    String name,
  ) {
    if (Provider.of<GetAtlete>(context, listen: false).name == 'Athlete Name') {
      ErrorSnackBar(context, 'Please Search Athlete First');
    } else if (score1Controller.text.isEmpty) {
      ErrorSnackBar(context, "Execution score can't be empty !");
    } else if (score2Controller.text.isEmpty) {
      ErrorSnackBar(context, "Difficulty score can't be empty !");
    } else if (score3Controller.text.isEmpty) {
      ErrorSnackBar(context, "Flow score can't be empty !");
    } else {
      int excScore = int.parse(score1Controller.text);
      int diffScore = int.parse(score2Controller.text);
      int floScore = int.parse(score3Controller.text);
      int overall = excScore + diffScore + floScore;
      print(excScore + diffScore + floScore);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Score Confirmation"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Athlete Name : $name'),
                  Text('Execution Score : $excScore'),
                  Text('Difficulty Score : $diffScore'),
                  Text('Flow Score : $floScore'),
                  Text('Overall Score : $overall'),
                ],
              ),
              actions: <Widget>[
                OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    var overall = excScore + diffScore + floScore;
                    Provider.of<GetAtlete>(context, listen: false)
                        .setScore(overall, excScore, diffScore, floScore);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text('Confirm'),
                ),
              ],
            );
          });
    }
  }
}
