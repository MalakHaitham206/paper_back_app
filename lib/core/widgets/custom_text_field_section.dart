// import 'package:flutter/material.dart';

// class CustomTextFieldSection extends StatefulWidget {
//   const CustomTextFieldSection({
//     super.key,
//     required this.label,
//     required this.placeholderText,
//     required this.icon,
//     required this.validateFunction,
//   });
//   final String label;
//   final String placeholderText;
//   final String icon;
//   final String? Function(String?) validateFunction;
//   @override
//   State<CustomTextFieldSection> createState() => _CustomTextFieldSection();
// }

// class _CustomTextFieldSection extends State<CustomTextFieldSection> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       padding: EdgeInsets.all(24),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 7),
//           Text(widget.label, style: theme.textTheme.bodyMedium),
//           TextFormField(
//             decoration: InputDecoration(hintText: widget.placeholderText),
//             validator: widget.validateFunction,
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:day2_course/core/widgets/helper.dart';
import 'package:flutter/material.dart';

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
        SizedBox(height: Helper.responsiveHeight(context, height: 24)),
        Text(widget.label, style: theme.textTheme.bodyMedium),
        SizedBox(height: Helper.responsiveHeight(context, height: 16)),
        TextFormField(
          obscureText: widget.type == "Password" && show == false,
          decoration: InputDecoration(
            suffixIcon: widget.type == "Password"
                ? IconButton(
                    onPressed: () {
                      // if (show == true) {
                      //   setState(() {
                      //     show = false;
                      //   });
                      // } else {
                      //   setState(() {
                      //     show = true;
                      //   });
                      // }
                      setState(() {
                        show = !show;
                      });
                    },
                    icon: Icon(
                      show == true
                          ? Icons.remove_red_eye
                          : Icons.hls_off_outlined,
                      size: Helper.responsiveHeight(context, height: 24),
                    ),
                  )
                : null,
            prefixIcon: SizedBox(
              child: Icon(
                Icons.email_outlined,
                size: Helper.responsiveHeight(context, height: 24),
              ),
            ),
            hintText: 'Enter your email',
            // prefix:
            iconColor: theme.colorScheme.primary,
          ),
          validator: widget.validateFunction,
        ),
      ],
    );
  }
}
