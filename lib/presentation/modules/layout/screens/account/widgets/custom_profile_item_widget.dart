import 'package:flutter/material.dart';
import '../../../../../../core/resources/color.dart';
import '../../../../../../core/resources/styles.dart';

class CustomProviderProfileItem extends StatelessWidget {
  const CustomProviderProfileItem({super.key, required this.title, required this.icon, this.onTap, this.color, this.trailing});
  final String title;
  final IconData icon ;
  final Color? color ;
  final Widget? trailing ;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  Container(
      color:backGroundGray,
      child:  ListTile(
        onTap: onTap,
        title: Text(title,
          style: TextStyles.font18Black700Weight.copyWith(
            fontSize: 14,
            color:color?? Colors.grey.shade800
          ),),
        leading: Icon(icon,color:color?? backBlue2,),
        trailing: trailing?? Icon(Icons.arrow_forward_ios,size: 20,color: color??Colors.grey.shade800,) ,
      ),
    );
  }
}
