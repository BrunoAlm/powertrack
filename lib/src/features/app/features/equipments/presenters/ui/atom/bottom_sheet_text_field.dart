import 'package:flutter/material.dart';

class BottomSheetTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextInputType? inputType;
  final TextEditingController textController;
  final String? Function(String? value)? validator;
  const BottomSheetTextField({
    Key? key,
    required this.icon,
    required this.textController,
    this.validator,
    this.inputType = TextInputType.text,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: TextFormField(
        controller: textController,
        keyboardType: inputType,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.grey),
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
