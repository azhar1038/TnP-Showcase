import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';

class FormInputField extends StatelessWidget {
  final int minLines, maxLines;
  final ScrollPhysics scrollPhysics;
  final String labelText, hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final bool enabled;
  final List<TextInputFormatter> inputFormatters;
  final bool obscureText;
  final Widget prefixIcon, suffixIcon;

  const FormInputField({
    Key key,
    this.minLines,
    this.maxLines = 1,
    this.scrollPhysics,
    this.labelText,
    this.hintText = '',
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.validator,
    this.onFieldSubmitted,
    this.enabled = true,
    this.inputFormatters,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(labelText,
                style: Theme.of(context).textTheme.subtitle1),
          ),
          TextFormField(
            minLines: minLines,
            maxLines: maxLines,
            scrollPhysics: scrollPhysics,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            keyboardType: keyboardType,
            controller: controller,
            focusNode: focusNode,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
            enabled: enabled,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
          ),
        ],
      );
    } else
      return TextFormField(
        minLines: minLines,
        maxLines: maxLines,
        scrollPhysics: scrollPhysics,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        enabled: enabled,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
      );
  }
}
