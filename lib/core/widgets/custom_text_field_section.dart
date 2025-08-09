import 'package:day2_course/core/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFieldSection extends StatefulWidget {
  final String label;
  final String placeholderText;
  final String icon;
  final String? Function(String?) validateFunction;
  final String type;
  final TextEditingController? controller;

  const CustomTextFieldSection({
    super.key,
    required this.label,
    required this.placeholderText,
    required this.icon,
    required this.validateFunction,
    required this.type,
    this.controller,
  });

  @override
  State<CustomTextFieldSection> createState() => _CustomTextFieldSectionState();
}

class _CustomTextFieldSectionState extends State<CustomTextFieldSection> {
  bool show = false;
  bool isValid = false;
  bool hasStartedTyping = false;
  late TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    show = false;

    _controller = widget.controller ?? TextEditingController();

    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        hasStartedTyping = true;
      }
      _validateInput(_controller.text);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _validateInput(String value) {
    setState(() {
      if (hasStartedTyping && value.isNotEmpty) {
        String? validationResult = widget.validateFunction(value);
        isValid = validationResult == null;
      } else {
        isValid = false;
      }
    });
  }

  Color getBorderColor(ThemeData theme) {
    if (hasStartedTyping && _controller.text.isNotEmpty) {
      return isValid ? Colors.green : theme.colorScheme.outline;
    }
    return theme.colorScheme.outline;
  }

  Color getFocusedBorderColor(ThemeData theme) {
    if (hasStartedTyping && _controller.text.isNotEmpty && isValid) {
      return Colors.green;
    }
    return theme.colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Helper.getResponsiveHeight(context, height: 16)),
        Text(
          widget.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: Helper.getResponsiveFontSize(context, fontSize: 13),
          ),
        ),
        SizedBox(height: Helper.getResponsiveHeight(context, height: 8)),
        TextFormField(
          controller: _controller, // ← THIS WAS MISSING!
          obscureText: widget.type == "Password" && show == false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Helper.getResponsiveWidth(context, width: 15),
              ),
              borderSide: BorderSide(color: getBorderColor(theme)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: getBorderColor(theme)), // ← FIXED
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: getFocusedBorderColor(theme),
                width: 2,
              ), // ← FIXED
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Show green checkmark when valid
                if (isValid && hasStartedTyping && _controller.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: Helper.getResponsiveHeight(context, height: 20),
                    ),
                  ),
                // Show password visibility toggle for password fields
                if (widget.type == "Password")
                  IconButton(
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    icon: Icon(
                      show == true ? Icons.visibility : Icons.visibility_off,
                      size: Helper.getResponsiveHeight(context, height: 16),
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
              ],
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.fromLTRB(
                Helper.getResponsiveWidth(context, width: 15),
                Helper.getResponsiveWidth(context, width: 12),
                Helper.getResponsiveWidth(context, width: 12),
                Helper.getResponsiveWidth(context, width: 12),
              ),
              child: SvgPicture.asset(
                widget.icon,
                width: Helper.getResponsiveHeight(context, height: 13),
                height: Helper.getResponsiveHeight(context, height: 13),
                colorFilter: ColorFilter.mode(
                  isValid && hasStartedTyping && _controller.text.isNotEmpty
                      ? Colors.green
                      : theme.colorScheme.onPrimary, // ← ADDED GREEN ICON
                  BlendMode.srcIn,
                ),
              ),
            ),
            hintText: widget.placeholderText,
            iconColor: theme.colorScheme.primary,
          ),
          validator: widget.validateFunction,
        ),
      ],
    );
  }
}

class PasswordValidator {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }

  // Confirm password validation function
  static String? validateConfirmPassword(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != originalPassword) {
      return 'Passwords do not match';
    }

    return null; // Confirm password is valid
  }

  // Alternative: Single function that validates both
  static String? validatePasswordMatch(
    String? password,
    String? confirmPassword,
  ) {
    // First validate the password
    String? passwordError = validatePassword(password);
    if (passwordError != null) {
      return passwordError;
    }

    // Then check if passwords match
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}
