import 'package:flutter/material.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:photo_view/photo_view.dart';

class FullPhotoView extends StatelessWidget {
  final String imageUrl;

  const FullPhotoView(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(
          shadowColor: Colors.transparent, context: context, titleText: '', bgColor: Colors.transparent),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
        loadingBuilder: (context, progress) => const Center(
          child: SizedBox(
            width: 20.0,
            height: 20.0,
          ),
        ),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        gaplessPlayback: false,
        customSize: MediaQuery.of(context).size,
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 1.8,
        initialScale: PhotoViewComputedScale.contained,
        basePosition: Alignment.center,
      ),
    );
  }
}
