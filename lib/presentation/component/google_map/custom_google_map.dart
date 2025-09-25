import 'dart:async';
import 'dart:convert';
import 'package:cogina_restaurants/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../core/resources/decoration.dart';
import '../../modules/branches/branch_cubit.dart';
import '../custom_elevated_button.dart';
import '../custom_text_field.dart';
import 'address_location_model.dart';

// AddressBody model (copied from first file)
class AddressBody {
  final String? title;
  final double? latitude;
  final double? longitude;
  final String? placeId;

  AddressBody({
    this.title,
    this.latitude,
    this.longitude,
    this.placeId,
  });
}

class CustomGoogleMapScreen extends StatefulWidget {
  final double lat;
  final double long;
  const CustomGoogleMapScreen(
      {super.key, required this.lat, required this.long});

  @override
  State<CustomGoogleMapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<CustomGoogleMapScreen> {
  late GoogleMapController mapController;
  LatLng? markerPosition;

  TextEditingController searchController = TextEditingController();
  List<dynamic> suggestions = []; // suggestions list
  List<AddressBody> placePredictions = []; // New places list

  var getLat = '';
  var getLong = '';
  var getCountry = '';
  var getBigCity = '';
  var getCity = '';
  var getLocality = '';
  var getStreet = '';
  var titlePosition = '';

  final String _googleKey = "YOUR_GOOGLE_API_KEY"; // ✨ حط مفتاحك هنا

  @override
  void initState() {
    markerPosition = LatLng(widget.lat, widget.long);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Map',
          style: TextStyle(
            fontSize: 25.sp,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w700,
          ),
        )),
      ),
      body: Stack(
        children: [
          // الخريطة
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                mapController = controller;
              });
            },
            onTap: (LatLng position) {
              _updateMarker(position);
              getAddressPosition(position);
              // Clear search when tapping on map
              setState(() {
                searchController.clear();
                placePredictions.clear();
              });
              FocusScope.of(context).unfocus();
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

          // حقل البحث
          Positioned(
            top: 10.h,
            left: 16.w,
            right: 16.w,
            child: CustomTextField(
              hintText: 'Search',
              controller: searchController,
              prefixIcon: Icon(Icons.search_sharp, color: Colors.grey.shade400),
              suffixIcon: searchController.text.isEmpty
                  ? null
                  : IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                          placePredictions.clear();
                        });
                      }),
              onChanged: (val) {
                if (val.isNotEmpty) {
                  _searchForPlaces(val);
                } else {
                  setState(() {
                    placePredictions.clear();
                  });
                }
              },
              onFieldSubmitted: (String val) {
                if (val.isNotEmpty) {
                  _searchForPlaces(val);
                }
              },
              textInputAction: TextInputAction.search,
              borderColor: Colors.grey.shade300,
            ),
          ),

          // Search Results Overlay (New places list)
          if (placePredictions.isNotEmpty)
            Positioned.fill(
              top: 70.h, // Position below search field
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: placePredictions.length,
                  itemBuilder: (context, index) => SearchItem(
                    addressBody: placePredictions[index],
                    onSelected: () async {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        searchController.clear();
                      });

                      // Get coordinates from Place Details API
                      LatLng? position =
                          await _setFromLocation(placePredictions[index]);

                      if (position != null) {
                        await mapController.animateCamera(
                            CameraUpdate.newLatLngZoom(position, 16));
                      }
                      setState(() {
                        placePredictions.clear();
                      });
                    },
                  ),
                ),
              ),
            ),

          // زرار Save
          if (placePredictions.isEmpty) // Only show when not searching
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: Decorations.backGroundDecorationButton()
                      .copyWith(borderRadius: BorderRadius.circular(40)),
                  child: CustomElevatedButton(
                      backgroundColor: Colors.transparent,
                      onTap: () {
                        if (getCountry.isEmpty) {
                          LatLng latLng = LatLng(widget.lat, widget.long);
                          setState(() {
                            getAddressPosition(latLng);
                          });
                        }
                        AddressLocationModel addressModel =
                            AddressLocationModel(
                          lat: getLat.isEmpty ? widget.lat.toString() : getLat,
                          long: getLong.isEmpty
                              ? widget.long.toString()
                              : getLong,
                          country: getCountry.isEmpty ? '' : getCountry,
                          bigCity: getBigCity.isEmpty ? '' : getBigCity,
                          city: getCity.isEmpty ? '' : getCity,
                          street: getStreet.isEmpty ? '' : getStreet,
                          locality: getLocality.isEmpty ? '' : getLocality,
                        );
                        if (getCountry.isNotEmpty) {
                          BranchCubit.get().addressLocationModel = addressModel;
                          BranchCubit.get().getLocationAddress(context);
                        }
                      },
                      fontSize: 25,
                      buttonText: 'Save'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> getAddressPosition(LatLng position) async {
    List<Placemark> p =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      getCountry = p[0].country.toString();
      getBigCity = p[0].administrativeArea.toString();
      getCity = p[0].subAdministrativeArea.toString();
      getLocality = p[0].locality.toString();
      getStreet = p[0].street.toString();
      titlePosition = '${p[0].street}';
    });
  }

  void _updateMarker(LatLng newPosition) {
    setState(() {
      getAddressPosition(newPosition);
      getLat = newPosition.latitude.toString();
      getLong = newPosition.longitude.toString();
      markerPosition = newPosition;
    });
  }

  Future<void> _searchPlace(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        LatLng latLng = LatLng(locations[0].latitude, locations[0].longitude);
        mapController.animateCamera(CameraUpdate.newLatLng(latLng));
        _updateMarker(latLng);
      }
    } catch (e) {
      // handle error
    }
  }

  Future<void> _getSuggestions(String input) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$_googleKey&components=country:eg";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        suggestions = data['predictions'];
      });
    }
  }

  Future<void> _goToPlace(String placeId) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$_googleKey";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final location = data['result']['geometry']['location'];
      LatLng latLng = LatLng(location['lat'], location['lng']);
      mapController.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
      _updateMarker(latLng);
    }
  }

  // New methods from the first file
  Future<void> _searchForPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        placePredictions.clear();
      });
      return;
    }

    try {
      final url = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
          "?input=$query"
          "&key=$_googleKey"
          "&sessiontoken=12223444"
          "&language=en";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['predictions'] != null) {
          List<AddressBody> predictions =
              (data['predictions'] as List).map((p) {
            return AddressBody(
              title: p['description'] ?? '',
              latitude: null,
              longitude: null,
              placeId: p['place_id'] ?? '',
            );
          }).toList();

          setState(() {
            placePredictions = predictions;
          });
        } else {
          setState(() {
            placePredictions.clear();
          });
        }
      } else {
        setState(() {
          placePredictions.clear();
        });
        print('Error response code: ${response.statusCode}');
      }
    } catch (e, stack) {
      print('Error searching places: $e');
      print(stack);
      setState(() {
        placePredictions.clear();
      });
    }
  }

  Future<AddressBody?> _getPlaceDetails(String placeId) async {
    try {
      String url =
          'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$_googleKey&fields=geometry,name,formatted_address';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['result'] != null) {
          final location = data['result']['geometry']['location'];
          final name = data['result']['name'];
          final formattedAddress = data['result']['formatted_address'];

          return AddressBody(
            title: formattedAddress ?? name,
            latitude: location['lat']?.toDouble(),
            longitude: location['lng']?.toDouble(),
            placeId: placeId,
          );
        }
      }
    } catch (e) {
      print('Error getting place details: $e');
    }
    return null;
  }

  Future<LatLng?> _setFromLocation(AddressBody addressBody) async {
    try {
      // Get coordinates from Place Details API if not available
      if ((addressBody.latitude == null || addressBody.longitude == null) &&
          addressBody.placeId != null &&
          addressBody.placeId!.isNotEmpty) {
        AddressBody? placeDetails =
            await _getPlaceDetails(addressBody.placeId!);
        if (placeDetails != null &&
            placeDetails.latitude != null &&
            placeDetails.longitude != null) {
          LatLng position =
              LatLng(placeDetails.latitude!, placeDetails.longitude!);
          _updateMarker(position);
          await getAddressPosition(position);
          return position;
        }
      } else if (addressBody.latitude != null &&
          addressBody.longitude != null) {
        LatLng position = LatLng(addressBody.latitude!, addressBody.longitude!);
        _updateMarker(position);
        await getAddressPosition(position);
        return position;
      }
    } catch (e) {
      print('Error setting location: $e');
    }
    return null;
  }
}

// Search Item Widget (copied from first file)
class SearchItem extends StatelessWidget {
  final AddressBody addressBody;
  final VoidCallback onSelected;

  const SearchItem({
    super.key,
    required this.addressBody,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.location_on,
                    size: 15.w,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    addressBody.title ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[300]),
        ],
      ),
    );
  }
}
