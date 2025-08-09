
import 'package:day2_course/core/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFieldSection extends StatefulWidget {
  final String label;
  final String placeholderText;
  final String icon;
  final String? Function(String?) validateFunction;
  final String type;

  const CustomTextFieldSection({
    super.key,
    required this.label,
    required this.placeholderText,
    required this.icon,
    required this.validateFunction,
    required this.type,
  });

  @override
  State<CustomTextFieldSection> createState() => _CustomTextFieldSectionState();
}

class _CustomTextFieldSectionState extends State<CustomTextFieldSection> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    show = false;
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
          obscureText: widget.type == "Password" && show == false,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Helper.getResponsiveWidth(context, width: 15),
              ),
              borderSide: BorderSide(color: theme.colorScheme.onPrimary),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            suffixIcon: widget.type == "Password"
                ? IconButton(
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

                    // icon: SvgPicture.asset(
                    //   show == true
                    //       ? "assets/image/login_images/eye_open.svg"
                    //       : "assets/image/login_images/eye_closed.svg",
                    //   width: Helper.getResponsiveHeight(context, height: 16),
                    //   height: Helper.getResponsiveHeight(context, height: 16),
                    //   colorFilter: ColorFilter.mode(
                    //     Color.fromARGB(255, 255, 255, 255),
                    //     BlendMode.srcIn,
                    //   ),
                    // ),
                  )
                : null,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(
                12.0,
              ), // Add padding to center the SVG
              child: SvgPicture.asset(
                widget.icon, // Use the SVG path from widget.icon
                width: Helper.getResponsiveHeight(context, height: 13),
                height: Helper.getResponsiveHeight(context, height: 13),
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            hintText: widget.placeholderText, // Use the actual placeholder text
            iconColor: theme.colorScheme.primary,
          ),
          validator: widget.validateFunction,
        ),
      ],
    );
  }
}
