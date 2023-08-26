import 'package:flutter/material.dart';

class BottomSheetTextField extends StatelessWidget {
  final IconData icon;
  final String? labelText;
  final TextInputType? inputType;
  final TextEditingController textController;
  final String? Function(String? value)? validator;
  final TextInputAction? inputAction;
  final Function(String value)? onSubmit;
  const BottomSheetTextField({
    Key? key,
    required this.icon,
    required this.textController,
    this.validator,
    this.inputType = TextInputType.text,
    this.labelText,
    this.inputAction,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: TextFormField(
        controller: textController,
        keyboardType: inputType,
        validator: validator,
        textInputAction: inputAction,
        onFieldSubmitted: onSubmit,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelLarge,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Icon(icon),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}
