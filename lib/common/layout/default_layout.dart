import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? leading;
  final List<Widget>? actions;
  final FlexibleSpaceBar? flexibleSpace;
  final Color? appBarForegroundColor;
  final Color? appBarBackgroundColor;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(
        leading,
        appBarForegroundColor,
        appBarBackgroundColor,
      ),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }

  AppBar? renderAppBar(
    Widget? leading,
    Color? appBarForegroundColor,
    Color? appBarBackgroundColor,
  ) {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        foregroundColor: appBarForegroundColor ?? Colors.black,
        backgroundColor: appBarBackgroundColor ?? Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: leading,
        actions: actions,
      );
    }
  }
}
