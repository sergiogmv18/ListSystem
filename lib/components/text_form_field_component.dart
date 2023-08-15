import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_system/style.dart';

import '../helpers/function_class.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool enabled;
  final bool autoFocus;
  final String? initialValue;
  final Function(String?)? onSaved;
  final String? labelText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final  FocusNode? focusNode;
  final int? maxLines;
  final bool showBorder;

  const TextFormFieldCustom({
    Key? key,
    this.controller,
    this.suffixIcon,
    this.enabled = true,
    this.autoFocus = false,
    this.initialValue,
    this.onSaved,
    this.labelText,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.onTap,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxLines,
    this.showBorder = true,
    this.keyboardType = TextInputType.name,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        textAlign: TextAlign.center,
        controller: controller,
        initialValue: initialValue,
        style: Theme.of(context).textTheme.titleSmall,
        enabled: enabled,
        autofocus: autoFocus,
        onFieldSubmitted:onFieldSubmitted,
        maxLines:maxLines,
        decoration: InputDecoration(
// suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
        //  labelText: labelText,
          hintText :labelText,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          fillColor:  CustomColors().inputColor,
          filled: true,
          suffixIcon: suffixIcon,
          errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error),
          hintStyle: Theme.of(context).textTheme.titleSmall,
          border:showBorder ? OutlineInputBorder(borderRadius: FunctionsClass.borderRadiusfixed(), borderSide: BorderSide(color: CustomColors().colorDark, width: 1)): null,
          enabledBorder: showBorder ? OutlineInputBorder(borderRadius: FunctionsClass.borderRadiusfixed(), borderSide: BorderSide(color: CustomColors().colorDark, width: 1)):null,
          disabledBorder: showBorder ? OutlineInputBorder(borderRadius: FunctionsClass.borderRadiusfixed(), borderSide: BorderSide(color: CustomColors().colorDark, width: 1)):null,
          focusedBorder:  showBorder ? OutlineInputBorder(borderRadius: FunctionsClass.borderRadiusfixed(), borderSide: BorderSide(color: CustomColors().colorDark, width: 1)):null,
          errorBorder: showBorder ?  OutlineInputBorder(borderRadius: FunctionsClass.borderRadiusfixed(), borderSide: const BorderSide(color: Colors.red, width: 1)):null,
        ),
        onTap: onTap,
        onChanged: onChanged,
        validator: validator,
        onSaved: onSaved
    );
  }
}
