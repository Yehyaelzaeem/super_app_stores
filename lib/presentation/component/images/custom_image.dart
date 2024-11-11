import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../../core/assets_constant/images.dart';
import '../../../core/resources/color.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.image,  this.radius, this.fit, this.width, this.height, this.openImage=false});
  final String image;
  final double? radius;
  final double? width;
  final double? height;
  final bool? openImage;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: openImage==false?null:
            (){
          ImageProvider imageProvider = NetworkImage(image);
          openBottomSheet(context, imageProvider);
        },
        child: SizedBox(
          height: height,
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius??0),
            child: Image.network(
              image,
              fit:fit?? BoxFit.cover,
              errorBuilder: (context, error, v) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(radius??0),
                  child: Image.asset(AppImages.holder,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ),
      );
  }
}
void openBottomSheet(BuildContext context, ImageProvider imageProvider) =>
    showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const ContinuousRectangleBorder(),
      builder: (BuildContext context) {
        return PhotoViewGestureDetectorScope(
          axis: Axis.vertical,
          child: Stack(
            children: [
              PhotoView(
                backgroundDecoration: BoxDecoration(
                  color: Colors.grey.withAlpha(240),
                ),
                imageProvider: imageProvider,
                heroAttributes:
                PhotoViewHeroAttributes(tag: imageProvider.toString()),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      color: primaryColor,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
