import 'dart:developer';
import 'package:attendance_management_system/consts.dart';
import 'package:attendance_management_system/screens/home/providers/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return Consumer<HomePageProvider>(
      builder: (context, homePageProvider, child) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
                radius: width * 0.2,
                backgroundColor: AppColors.white,
                backgroundImage: homePageProvider.isUploadingImage
                    ? null
                    : NetworkImage(
                        homePageProvider.imageUrl ?? defaultImageUrl),
                child: homePageProvider.isUploadingImage
                    ? const CircularProgressIndicator()
                    : null),
            IconButton.filled(
                color: AppColors.white,
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.grey)),
                onPressed: () => _showImageUploadDialog(context, width, height),
                icon: const Icon(Icons.camera_alt_rounded)),
          ],
        );
      },
    );
  }

  void _showImageUploadDialog(
      BuildContext context, double width, double height) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Consumer<HomePageProvider>(
          builder: (context, homePageProvider, child) {
            return AlertDialog(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      homePageProvider.clearImage();
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () async {
                      await homePageProvider.uploadImageToFirebaseStorage();
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: const Text('OK')),
              ],
              title: const Text('Upload a profile picture'),
              content: Container(
                width: width,
                height: height * 0.3,
                padding: homePageProvider.isImagePicked
                    ? EdgeInsets.only(top: height * 0.01)
                    : null,
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(width * 0.05)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (homePageProvider.isImagePicked &&
                        !homePageProvider.isImageUploaded)
                      Expanded(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              homePageProvider.image!,
                              fit: BoxFit.contain,
                            )),
                      ),
                    SizedBox(height: height * 0.01),
                    const Text('Upload an image'),
                    SizedBox(height: height * 0.002),
                    IconButton(
                        iconSize: width * 0.1,
                        onPressed: () async {
                          log(homePageProvider.isImageUploaded.toString());
                          await homePageProvider.pickImageFromGallery();
                        },
                        icon: const Icon(Icons.add_photo_alternate_rounded))
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((_) =>
        Provider.of<HomePageProvider>(context, listen: false).clearImage());
  }
}
