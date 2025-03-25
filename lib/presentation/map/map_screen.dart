import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mon_assessment/core/map.dart';
import 'package:mon_assessment/presentation/map/widgets/list_of_variant_button.dart';
import 'package:mon_assessment/presentation/map/widgets/map_actions_fab.dart';
import 'package:mon_assessment/presentation/map/widgets/map_marker.dart';
import 'package:mon_assessment/presentation/map/widgets/search_input_field.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();

  static Future<void> preloadMapStyle() async {
    _MapScreenState._cachedDarkMapStyle ??= await rootBundle.loadString(MapStyle.dark);
  }
}

class _MapScreenState extends State<MapScreen> with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  late AnimationController _animationController;
  bool _isExpanded = true;
  bool _isMapStyleLoaded = false;

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 13,
  );

  static String? _cachedDarkMapStyle;

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
    _initializeMapStyle();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeMapStyle() async {
    _cachedDarkMapStyle ??= await rootBundle.loadString(MapStyle.dark);
    setState(() => _isMapStyleLoaded = true);
  }

  void _initializeAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
      setState(() => _isExpanded = status != AnimationStatus.dismissed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _isMapStyleLoaded
              ? _buildGoogleMap()
              : const Center(child: CircularProgressIndicator()), // Loading indicator
          if (_isMapStyleLoaded) ...[
            const ListOfVariantButton(),
            _buildMapActionsFab(),
            const SearchInputField(),
            MapMarker(isExpanded: _isExpanded),
          ],
        ],
      ),
    );
  }

  Widget _buildGoogleMap() {
    return GoogleMap(
      mapType: MapType.normal,
      style: _cachedDarkMapStyle,
      compassEnabled: false,
      mapToolbarEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Widget _buildMapActionsFab() {
    return Positioned(
      left: 30,
      bottom: MediaQuery.of(context).size.height * 0.12, // Dynamic sizing
      child: MapActionsFab(animationController: _animationController),
    );
  }
}