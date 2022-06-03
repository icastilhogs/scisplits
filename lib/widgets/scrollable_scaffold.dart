import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scisplits/config/style.dart';
import 'package:scisplits/widgets/bottom_container.dart';
import 'package:scisplits/widgets/image_viewer.dart';

class ScrollableScaffold extends StatelessWidget {
  const ScrollableScaffold({
    Key? key,
    this.title,
    this.backButton,
    this.actions,
    this.body,
    this.background,
    this.floatingActionButton,
    this.expandedHeightFactor,
    this.bottomPadding,
    this.customHeader,
    this.sidePadding,
  }) : super(key: key);

  final String? title;
  final Widget? backButton;
  final Widget? customHeader;
  final List<Widget>? actions;
  final List<Widget>? body;
  final String? background;
  final Widget? floatingActionButton;
  final double? expandedHeightFactor;
  final double? bottomPadding;
  final double? sidePadding;

  List<Widget> get fullBody {
    final List<Widget> result = [];
    if (body != null) {
      result.addAll(body!);

      //result.insert(0, BottomContainer(height: 100));
    }
    result.add(SizedBox(height: bottomPadding ?? 0));

    return result;
  }

  Widget? get getBackground {
    if (background != null) {
      return Stack(alignment: Alignment.bottomCenter, children: [
        if (background != null) ImageViewer(image: background!),
        Container(
          //height: double.infinity,
          decoration:
              const BoxDecoration(gradient: CustomColors.primaryGradient),
        )
      ]);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton,
      backgroundColor: CustomColors.offwhite,
      extendBodyBehindAppBar: true,
      extendBody: true,

      /* appBar: AppBar(
        title: title == null ? null : Text(title!),
        leading: backButton,
        automaticallyImplyLeading: false,
        toolbarHeight: 69,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        actions: actions,
      ), */
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            scrolledUnderElevation: 1,
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: BottomContainer(
                  height: 40,
                  opaque: true,
                )),
            backgroundColor: CustomColors.primary,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            /* shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(80))), */
            //floating: true,
            stretch: true,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height *
                (expandedHeightFactor ?? .5),
            leading: backButton,
            automaticallyImplyLeading: false,
            //toolbarHeight: 60,
            shadowColor: Colors.transparent,
            //backgroundColor: Colors.transparent,
            actions: actions,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 40.0, bottom: 56.0),
              title: title == null
                  ? null
                  : Text(
                      title!,
                      style: font.copyWith(
                        fontSize: 20,
                        //color: CustomColors.primary,
                      ),
                    ),
              expandedTitleScale: 1.6,
              background: getBackground,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverAppBarDelegate(
              minHeight: customHeader == null ? 0 : 60,
              maxHeight: customHeader == null ? 0 : 60,
              child: customHeader ?? Container(color: CustomColors.offwhite),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(sidePadding ?? 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate(fullBody),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
