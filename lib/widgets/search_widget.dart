import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/widgets/error_snakbar.dart';

import '../providers/get_athletes_provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: const [
              Padding(padding: EdgeInsets.only(left: 8)),
              Text(
                'Search Athlete With ID :',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'ID',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity, 64)),
                onPressed: () {
                  if (searchController.text.isEmpty) {
                    ErrorSnackBar(context, 'Please type the Athlete ID');
                  } else {
                    Provider.of<GetAtlete>(context, listen: false).id =
                        searchController.text;
                    Provider.of<GetAtlete>(context, listen: false)
                        .searchAthlete(searchController.text);
                  }
                },
                child: const Icon(Icons.search_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
