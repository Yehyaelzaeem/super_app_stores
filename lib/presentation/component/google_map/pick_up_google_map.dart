import 'dart:async';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/resources/decoration.dart';
import '../../../domain/provider/local_auth_provider_cubit.dart';
import '../../../domain/provider/local_auth_provider_state.dart';
import '../../modules/branches/branch_cubit.dart';
import '../custom_elevated_button.dart';
import '../custom_text_field.dart';
import 'address_location_model.dart';

class PickUpGoogleMapScreen extends StatefulWidget {
  final LatLng? latLng;
  const PickUpGoogleMapScreen({super.key, this.latLng});

  @override
  State<PickUpGoogleMapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<PickUpGoogleMapScreen> {
  late GoogleMapController mapController;
  LatLng? markerPosition; // Initial po
  // sition (San Francisco)
  @override
  void initState() {
    LatLng? latLng=context.read<LocalAuthCubit>().state.latLng;
    if(latLng!=null){
      markerPosition =latLng;
    }else{
      markerPosition = widget.latLng;
    }
    super.initState();
  }

  TextEditingController searchController = TextEditingController();
   var getLat='';
   var getLong='';
   var getCountry='';
   var getBigCity='';
   var getCity='';
   var getLocality='';
   var getStreet='';
  var titlePosition='';

  @override
  Widget build(BuildContext context) {
    getAddressPosition(markerPosition??LatLng(0,0));
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Map',
        style: TextStyle(
          fontSize: 25.sp,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w700,
        ),
        )),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w),
            child: CustomTextField(
                hintText: 'Search',
                controller: searchController,
                prefixIcon:
                Icon(Icons.search_sharp, color: Colors.grey.shade400),
                onFieldSubmitted: (String val){
                  _searchPlace();
                },
                textInputAction: TextInputAction.search,
                borderColor: Colors.grey.shade300),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
              },
              onTap: (LatLng position) {
                _updateMarker(position);
                getAddressPosition(position);
              },
              initialCameraPosition: CameraPosition(
                target: markerPosition!,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('markerId'),
                  infoWindow: InfoWindow(title: titlePosition),
                  position: markerPosition!,
                  draggable: true,
                  onDragEnd: (LatLng newPosition) {
                    _updateMarker(newPosition);
                  },
                ),
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w ,vertical: 10.h),
            child: Container(
              height: 40.h,
              width: MediaQuery.of(context).size.width*0.6,
              decoration: Decorations.backGroundDecorationButton().copyWith(
                  borderRadius: BorderRadius.circular(40)
              ),
              child:
             BlocBuilder<LocalAuthCubit, LocalAuthState>(
                builder: (context, state) {
                  return  CustomElevatedButton(
                      backgroundColor: Colors.transparent,
                      onTap: (){
                        AddressLocationModel addressModel =AddressLocationModel(
                          lat: getLat.isEmpty?markerPosition?.latitude.toString():getLat ,
                          long: getLong.isEmpty?markerPosition?.longitude.toString():getLong,
                          country: getCountry.isEmpty?'':getCountry,
                          bigCity: getBigCity.isEmpty?'':getBigCity,
                          city: getCity.isEmpty?'':getCity,
                          street: getStreet.isEmpty?'':getStreet,
                          locality: getLocality.isEmpty?'':getLocality,
                        );
                        context.read<LocalAuthCubit>().pickUpAddress(addressModel).then((value) {
                          Navigator.pop(context,addressModel);
                        });
                      },
                      fontSize: 25,
                      buttonText: 'Save');
                })
            ),
          ),

        ],
      ),
    );
  }
  Future<void> getAddressPosition(LatLng position)async {
    List<Placemark> p = await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      getCountry=p[0].country.toString();
      getBigCity=p[0].administrativeArea.toString();
      getCity=p[0].subAdministrativeArea.toString();
      getLocality=p[0].locality.toString();
      getStreet=p[0].street.toString();
      titlePosition = '${p[0].street}';
    });
  }
  void _updateMarker(LatLng newPosition) {
    setState((){
      getAddressPosition(newPosition);
      getLat=newPosition.latitude.toString();
      getLong=newPosition.longitude.toString();
      markerPosition = newPosition;
    });
  }
//getPermission
  Future<void> _searchPlace() async {
    try {
      List<Location> locations = await locationFromAddress(searchController.text);
      LatLng latLng =LatLng(locations.first.latitude, locations.first.longitude);
      if (locations.isNotEmpty) {
        mapController.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
        _updateMarker(latLng);
      } else {
        // print('No location found for the provided address.');
      }
    } catch (e) {
      // print('Error during geocoding: $e');
    }
  }

}

