import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.textEditingController,
      required this.searchFocused,
      required this.isFocused});

  final TextEditingController textEditingController;
  final FocusNode searchFocused;
  final Function(bool isFocused) isFocused;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    widget.searchFocused.addListener(
      () {
        if (widget.searchFocused.hasFocus) {
          print("Search field is focused (opened/tapped)");
          widget.isFocused(true);
        } else {
          print("Search field lost focus (closed/unfocused)");
          widget.isFocused(false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
      focusNode: widget.searchFocused,
      controller: widget.textEditingController,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        hintText: "Search Here...",
        hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
        prefixIcon: Icon(
          Icons.location_on,
          size: 29,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
