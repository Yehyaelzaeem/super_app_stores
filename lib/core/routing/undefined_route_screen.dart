
import 'package:cogina_restaurants/core/resources/text_styles.dart';
import 'package:flutter/material.dart';




class UndefinedRouteScreen extends StatelessWidget {
  const UndefinedRouteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child:Text('Not found this route',style: const TextStyle().titleStyle(),) ,
        ),
    );
  }
}
