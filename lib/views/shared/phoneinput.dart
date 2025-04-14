import 'package:flutter/material.dart';

import '../../utils/phonenumberutils.dart';

/// Extended TextFormField specifically for phone numbers
class TzPhoneFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final bool showVisualHint;

  const TzPhoneFormField({
    super.key,
    required this.controller,
    this.focusNode,
    this.labelText = 'Phone Number',
    this.hintText = 'Enter Tanzania phone number',
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
    this.showVisualHint = true,
  });

  @override
  State<TzPhoneFormField> createState() => _TzPhoneFormFieldState();
}

class _TzPhoneFormFieldState extends State<TzPhoneFormField> {
  String? _formattedHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          keyboardType: TextInputType.phone,
          inputFormatters: [TzPhoneNumberFormatter()],
          onChanged: (value) {
            if (widget.showVisualHint) {
              setState(() {
                _formattedHint = TzPhoneUtils.getVisualHint(value);
              });
            }
          },
          onFieldSubmitted: widget.onFieldSubmitted,
          validator:
              widget.validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                if (!TzPhoneUtils.isValidTanzaniaNumber(value)) {
                  return 'Please enter a valid Tanzania phone number';
                }
                return null;
              },
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(Icons.phone_android),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        if (_formattedHint != null && widget.showVisualHint)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12.0),
            child: Text(
              'Will be saved as: $_formattedHint',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
