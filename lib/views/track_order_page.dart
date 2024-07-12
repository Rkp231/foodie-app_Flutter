import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodie/constants/app_images.dart';
import 'package:foodie/data/models/order.dart';
import 'package:foodie/widgets/appbar/leading_app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackOrderPage extends StatefulWidget {
  TrackOrderPage({
    Key key,
    this.order,
  }) : super(key: key);

  final Order order;
  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  //
  
  final deliveryBoyLocationRef =  FirebaseDatabase.instance.reference();
  //
  GoogleMapController googleMapController;
  //
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  //
  final MarkerId markerId = MarkerId("deliveryBoy");
  //
  Marker deliveryBoyLocationMarker;
  //
  BitmapDescriptor deliveryBoyLocationIcon;

  @override
  void initState() {
    super.initState();

    print("Lat ==> ${widget.order.deliveryAddress.latitude}");
    print("Lng ==> ${widget.order.deliveryAddress.longitude}");

    //prepare the image as icon for the driver tracking
    setCustomMapPin();

    // creating a new MARKER
    deliveryBoyLocationMarker = Marker(
      markerId: markerId,
      position: LatLng(
        double.parse(widget.order.deliveryAddress.latitude ?? 0.00),
        double.parse(widget.order.deliveryAddress.longitude ?? 0.00),
      ),
      icon: deliveryBoyLocationIcon,
    );

    //add the initial marker to the map
    _updateDeliveryBoyLocationMarker();

    //start listening to driver boy location
    deliveryBoyLocationRef
        .child("locations")
        .child(widget.order.delveryBoyId.toString())
        .onValue
        .listen((event) {
      print("Location Data ==> ${event.snapshot.value}");

      //recreate a marker with the new data
      deliveryBoyLocationMarker = Marker(
        markerId: markerId,
        position: LatLng(
          event.snapshot.value["latitude"] ?? 0.00,
          event.snapshot.value["longitude"] ?? 0.00,
        ),
        icon: deliveryBoyLocationIcon,
      );
      //update the marker
      _updateDeliveryBoyLocationMarker();

      final cameraUpdate = CameraUpdate.newLatLng(
        deliveryBoyLocationMarker.position,
      );
      if (googleMapController != null) {
        googleMapController.animateCamera(cameraUpdate);
      }
    }, onError: (error) {
      print("Error Getting Location ==> $error");
    });
  }

  //
  void _updateDeliveryBoyLocationMarker() {
    setState(() {
      // adding a new marker to map
      markers[markerId] = deliveryBoyLocationMarker;
    });
  }

  void setCustomMapPin() async {
    deliveryBoyLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 0.1, size: Size(10, 10)),
      AppImages.deliveryBoyMarkerIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Order"),
        leading: LeadingAppBar(
          color: Colors.white,
        ),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController mapController) {
          googleMapController = mapController;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            double.parse(widget.order.deliveryAddress.latitude) ?? 0.00,
            double.parse(widget.order.deliveryAddress.longitude) ?? 0.00,
          ),
          // target: LatLng(-33.852, 151.211),
          zoom: 14.0,
        ),
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}
