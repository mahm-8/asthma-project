import 'package:dashboard/screens/extensions/screen_dimensions.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.hint,
    this.obscure = false,
    required this.controller,
    this.keyForm,
    this.validator,
    this.displayPass = false,
    this.onTap,
    this.keyboardType,
    required this.titel,
  });
  final String hint;
  final String titel;
  final bool obscure;
  final TextEditingController? controller;
  final GlobalKey? keyForm;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool displayPass;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                titel,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 70,
              width: context.getWidth() > 700
                  ? context.getWidth(divide: 3)
                  : context.getWidth(divide: 1.2),
              child: Form(
                key: keyForm,
                child: TextFormField(
                  keyboardType: keyboardType,
                  validator: validator,
                  obscureText: !obscure ? false : !displayPass,
                  controller: controller,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Colors.grey[300],
                    filled: true,
                    suffixIcon: !obscure
                        ? null
                        : InkWell(
                            onTap: onTap,
                            child: Icon(!displayPass
                                ? Icons.visibility_off_sharp
                                : Icons.remove_red_eye),
                          ),
                    hintText: hint,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
