import 'package:flutter/cupertino.dart';

import '../../../core/assets_constant/images.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key, required this.image,  this.radius, this.fit, this.width, this.height});
  final String image;
  final double? radius;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
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
    );
  }
}
