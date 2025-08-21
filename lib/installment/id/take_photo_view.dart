import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myphsar/base_widget/alert_dialog_view.dart';
import 'package:myphsar/base_widget/custom_appbar_view.dart';
import 'package:myphsar/base_widget/custom_icon_button.dart';
import 'package:myphsar/base_widget/custom_scaffold.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../base_colors.dart';
import '../../base_widget/myphsar_text_view.dart';
import '../installment_view_controller.dart';

class TakePhotoView extends StatefulWidget {
  final dynamic isFront;

  const TakePhotoView({super.key, this.isFront});

  @override
  State<TakePhotoView> createState() => _TakePhotoViewState();
}

class _TakePhotoViewState extends State<TakePhotoView> {
  bool flashSwitch = false;
  late CameraController _controller;
  bool isCameraReady = false;
  bool isPhotoInProgress = false;
  late List<CameraDescription> _availableCameras;

  @override
  void initState() {
    _getAvailableCameras();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // init camera
  Future<void> _initCamera(CameraDescription description) async {
    _controller = CameraController(description, ResolutionPreset.medium, enableAudio: false);
    try {
      await _controller.initialize();
      setState(() {
        isCameraReady = true;
      });
    } catch (e) {
      //TODO: context warning
      alertDialogWidgetView(
          context: context,
          widget: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: textView15(
                    maxLine: 2,
                    context: context,
                    text: "get_setting_msg".tr,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w700),
              ),
              customTextButton(
                  onTap: () {
                    openAppSettings();
                  },
                  blur: 2,
                  padding: 10,
                  radius: 20,
                  text: textView15(maxLine: 2, context: context, text: "go_setting".tr, textAlign: TextAlign.center)),
            ],
          ));
    }
  }

// get available cameras
  Future<void> _getAvailableCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    _availableCameras = await availableCameras();
    _initCamera(_availableCameras.first);
  }

  void _toggleCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection = _controller.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription =
          _availableCameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription =
          _availableCameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }

    _initCamera(newDescription);
  }

  Widget image1(XFile imagePath) {
    return Expanded(
      child: Column(
        children: [Image.file(File(imagePath.path)), textView15(text: "next".tr, context: context)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "take_id_photo".tr),
      body: isCameraReady
          ? Column(children: [
              Expanded(flex: 8, child: SizedBox(width: double.infinity, child: CameraPreview(_controller))),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                              onTap: () async {
                                if (flashSwitch) {
                                  setState(() {
                                    _controller.setFlashMode(FlashMode.off);
                                    flashSwitch = false;
                                  });
                                } else {
                                  setState(() {
                                    _controller.setFlashMode(FlashMode.always);
                                    flashSwitch = true;
                                  });
                                }
                              },
                              child: Icon(
                                flashSwitch ? Icons.flash_on : Icons.flash_off,
                                color: flashSwitch ? Colors.amber : Colors.black54,
                                size: 30,
                              ))),
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                              onTap: () async {
                                try {
                                  final image = await _controller.takePicture();
                                  if (flashSwitch) _controller.setFlashMode(FlashMode.off);
                                  if (!mounted) return;

                                  if (widget.isFront) {
                                    Get.find<InstallmentViewController>().saveCapturePhotoFile(image);
                                  } else {
                                    Get.find<InstallmentViewController>().saveSelfieCapturePhotoFile(image);
                                  }
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DisplayPictureScreen(imagePath: image.path),
                                    ),
                                  );
                                } catch (e) {}
                              },
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.red,
                                size: 40,
                              ))),
                      Container(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                              onTap: () async {
                                _toggleCameraLens();
                              },
                              child: const Icon(
                                Icons.cameraswitch_rounded,
                                color: Colors.black54,
                                size: 30,
                              ))),
                    ],
                  ),
                ),
              ),
            ])
          : Container(
              color: Colors.black,
            ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: customAppBarView(context: context, titleText: "preview".tr),
      body: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          width: double.infinity,
          child: Image.file(
            File(imagePath),
            fit: BoxFit.fill,
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: customTextButton(
          blur: 0,
          height: 50,
          radius: 5,
          color: ColorResource.primaryColor,
          onTap: () async {
            Navigator.of(context)
              ..pop()
              ..pop();
          },
          text: Center(
            child: textView15(
                context: context, text: "next".tr, color: ColorResource.whiteColor, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
