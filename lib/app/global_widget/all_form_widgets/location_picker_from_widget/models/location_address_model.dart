import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:map_location_picker/map_location_picker.dart';
// import 'package:map_location_picker/map_location_picker.dart';

// enum AddressType {
//   shipping,
//   billing,
// }

class AddressLocation {
  int? id;
  String? placeId;
  String? formattedAddress;
  LatLng? latLng;
  String? name;

  // String? userPlaceName;
  // String? description;

  ///
  // AddressType? type;
  String? storeID;

  AddressLocation({
    this.id,
    this.placeId,
    this.formattedAddress,
    this.latLng,
    // this.description,
    // this.userPlaceName,
    // this.type,
    this.name,
    this.storeID,
  });

  factory AddressLocation.fromMap(Map<String, dynamic> map) {
    return AddressLocation(
      id: map['id'],
      placeId: map['placeId'],
      formattedAddress: map['formattedAddress'],
      // description: map['description'],
      // userPlaceName: map['userPlaceName'],
      latLng: getLatLangFromMap(map['latLng']),
    );
  }

  factory AddressLocation.fromPickResult(PickResult pickedResult) {
    return AddressLocation(
      placeId: pickedResult.placeId,
      formattedAddress: pickedResult.formattedAddress,
      name: pickedResult.formattedAddress,
      latLng: pickedResult.geometry == null
          ? null
          : LatLng(
              pickedResult.geometry!.location.lat,
              pickedResult.geometry!.location.lng,
            ),
    );
  }

  static LatLng? getLatLangFromMap(Map<String, dynamic> map) {
    if (map['lat'] == null ||
        (map['long'] ?? map['lang'] ?? map['lng']) == null) {
      return null;
    }
    return LatLng(map['lat'], map['long'] ?? map['lang'] ?? map['lng']);
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': id,
      'placeId': placeId,
      'formattedAddress': formattedAddress,
      'lat': latLng?.latitude,
      'long': latLng?.longitude,
      // 'description': description,
      // 'userPlaceName': userPlaceName,
    } as Map<String, dynamic>;
  }
}
