import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/constants/app_sizes.dart';

class UserProfilePhoto extends StatelessWidget {
  const UserProfilePhoto({
    Key key,
    this.userProfileImageUrl = "",
    this.isFile = false,
    this.userProfileImage,
  }) : super(key: key);

  final String userProfileImageUrl;
  final bool isFile;
  final File userProfileImage;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: isFile
          ? Image.file(
              userProfileImage,
              height: AppSizes.userProfilePictureImageHeight,
              width: AppSizes.userProfilePictureImageWidth,
            )
          : CachedNetworkImage(
              imageUrl: userProfileImageUrl,
              placeholder: (context, url) => Container(
                height: AppSizes.userProfilePictureImageHeight,
                width: AppSizes.userProfilePictureImageWidth,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) {
                //error occurred due to no profile show a default profile
                if (url.isEmpty) {
                  return Container(
                    height: AppSizes.userProfilePictureImageHeight,
                    width: AppSizes.userProfilePictureImageWidth,
                    child: Image.asset(
                      AppImages.defaultProfile,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                //maybe caused by network or server issue
                else {
                  return Container(
                    height: AppSizes.userProfilePictureImageHeight,
                    width: AppSizes.userProfilePictureImageWidth,
                    child: Center(
                      child: Icon(Icons.error),
                    ),
                  );
                }
              },
              height: AppSizes.userProfilePictureImageHeight,
              width: AppSizes.userProfilePictureImageWidth,
              fit: BoxFit.cover,
            ),
    );
  }
}
