import 'package:flutter/material.dart';

class CustomFormFiled extends StatelessWidget {
  final String labelText;
  final Widget icon;
  final bool maxLinesbool;
  final bool maxLengthbool;
  final String validatortext;
  final bool keyboardTypebool;
  final TextEditingController cntrl;

  const CustomFormFiled(
      {super.key,
      required this.labelText,
      required this.icon,
      this.maxLinesbool = false,
      required this.cntrl,
      this.maxLengthbool = false,
      this.keyboardTypebool = false,
      required this.validatortext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: TextFormField(
          controller: cntrl,
          keyboardType:
              keyboardTypebool ? TextInputType.number : TextInputType.name,
          maxLength: maxLengthbool ? 2 : null,
          maxLines: maxLinesbool == true ? null : 1,
          decoration: InputDecoration(
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
            border: InputBorder.none,
            fillColor: const Color.fromARGB(255, 205, 243, 205),
            filled: true,
            labelText: labelText,

            labelStyle: const TextStyle(
                fontFamily: 'Montserrat-Medium',
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 13,
                fontWeight: FontWeight.w100,
                letterSpacing: 0.9),
            prefixIcon: icon,
          ),
          onChanged: (_) {},
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $validatortext';
            } else if (value.startsWith('')) {
              return "Please remove empty space $validatortext";
            }
            return null;
          },
        ),
      ),
    );
  }
}
