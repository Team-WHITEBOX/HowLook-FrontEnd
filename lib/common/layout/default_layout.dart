import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget? endDrawer;
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
  final bool? resizeToAvoidBottomInset;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.endDrawer,
    this.title,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.resizeToAvoidBottomInset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(
        leading,
        appBarForegroundColor,
        appBarBackgroundColor,
      ),
      body: child,
      endDrawer: endDrawer,
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
        centerTitle: false,
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'NotoSans',
          ),
        ),
        leading: leading,
        actions: actions,
      );
    }
  }
}
