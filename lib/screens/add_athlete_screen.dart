import 'package:flutter/material.dart';
import 'package:test/widgets/error_snakbar.dart';
import '../widgets/form_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddAthlete extends StatefulWidget {
  const AddAthlete({super.key});

  @override
  State<AddAthlete> createState() => _AddAthleteState();
}

class _AddAthleteState extends State<AddAthlete> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    String? categoryController;
    TextEditingController idController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Athletes',
                    style: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold)),
                FormTextField(
                  controller: idController,
                  label: "ID",
                  onlyNumbers: true,
                ),
                FormTextField(
                  controller: nameController,
                  label: "Name",
                  onlyNumbers: false,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      menuProps: MenuProps(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: const ['Advanced', 'Girls', 'Junior'],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle:
                          const TextStyle(color: Colors.white, fontSize: 16),
                      dropdownSearchDecoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(12)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          hintText: "Category",
                          hintStyle: const TextStyle(color: Colors.white),
                          suffixIconColor: Colors.white),
                    ),
                    onChanged: (String? selectedvalue) {
                      categoryController = selectedvalue!;
                    },
                  ),
                ),
                const Expanded(child: SizedBox()),
                ElevatedButton(
                  onPressed: () {
                    if (idController.text.isEmpty ||
                        nameController.text.isEmpty ||
                        categoryController == null) {
                      ErrorSnackBar(context, "Fields can't be Empty");
                      print('Empty');
                    } else {
                      addAthleteMethod(
                          idController, nameController, categoryController);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 55)),
                  child: const Text(
                    'Add Athlete',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addAthleteMethod(TextEditingController idController,
      TextEditingController nameController, String? categoryController) async {
    Map<String, dynamic> athleteData = {
      'id': int.parse(idController.text),
      'name': nameController.text.toString(),
      'category': categoryController.toString(),
      'excScore': 0,
      'diffScore': 0,
      'floScore': 0,
      'score': 0
    };
    print(athleteData);
    return FirebaseFirestore.instance
        .collection('Athletes')
        .doc(idController.text.toString())
        .set(athleteData)
        .then((value) => print('Added'))
        .catchError((error) => print('Failed to add user : $error'));
  }
}
