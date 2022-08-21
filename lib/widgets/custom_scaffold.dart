import 'package:flutter/material.dart';

import '../config/style.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold(
      {Key? key, required this.body, this.actions, this.backButton, this.title})
      : super(key: key);

  final Widget body;
  final List<Widget>? actions;
  final String? title;
  final Widget? backButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.offwhite,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: title == null ? null : Text(title!),
        leading: backButton,
        automaticallyImplyLeading: false,
        toolbarHeight: 69,
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: actions,
      ),
      body: body,
    );
  }
}
