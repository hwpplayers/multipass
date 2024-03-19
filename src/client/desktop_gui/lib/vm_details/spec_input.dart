import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ffi.dart';

class SpecInput extends StatelessWidget {
  final bool autofocus;
  final bool enabled;
  final String? helper;
  final String? hint;
  final String? initialValue;
  final String? label;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final double width;
  final TextEditingController? controller;

  const SpecInput({
    super.key,
    this.autofocus = false,
    this.enabled = true,
    this.helper,
    this.hint,
    this.initialValue,
    this.label,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.width = 170,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (label != null) ...[
          Text(label!, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
        ],
        TextFormField(
          autofocus: autofocus,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            helperText: helper,
            helperMaxLines: 3,
            helperStyle: const TextStyle(color: Colors.black),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.zero,
            ),
          ),
          enabled: enabled,
          initialValue: initialValue,
          inputFormatters: inputFormatters,
          onSaved: onSaved,
          style: const TextStyle(color: Colors.black),
          validator: validator,
        ),
      ]),
    );
  }
}

final memoryRegex = RegExp(
  r'^\s*\d+(\.\d+)?((K|M|G|T|Ki|Mi|Gi|Ti)?B)?\s*$',
  caseSensitive: false,
);

String? memorySizeValidator(String? value) {
  value = double.tryParse(value!) != null ? '${value}GB' : value;
  try {
    memoryInBytes(value);
    return null;
  } catch (_) {
    return 'Invalid memory size';
  }
}
