import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

enum ListingCategory {
  rawMaterials,
  trucksHaulage,
  movingServices,
  furnitureStores,
  equipmentRental,
}

class Category extends Equatable {
  final String id;
  final String name;
  final ListingCategory type;
  final String icon;

  const Category({
    required this.id,
    required this.name,
    required this.type,
    required this.icon,
  });

  @override
  List<Object?> get props => [id, name, type, icon];
}

class Supplier extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String email;
  final bool isVerified;
  final String? coverPhoto;
  final String? avatar;
  final String location;
  final LatLng? coordinates;
  final double rating;
  final int listingsCount;
  final int viewsCount;
  final int contactsCount;
  final String joinedDate;
  final String status; // Active, Suspended, Pending

  const Supplier({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.isVerified = false,
    this.coverPhoto,
    this.avatar,
    required this.location,
    this.coordinates,
    this.rating = 0.0,
    this.listingsCount = 0,
    this.viewsCount = 0,
    this.contactsCount = 0,
    required this.joinedDate,
    required this.status,
  });

  @override
  List<Object?> get props => [id, name, isVerified, location, status, coordinates];
}

class Listing extends Equatable {
  final String id;
  final String title;
  final String description;
  final double price;
  final String unit;
  final ListingCategory category;
  final String supplierId;
  final String supplierName;
  final bool isSupplierVerified;
  final List<String> images;
  final String location;
  final LatLng? coordinates;
  final double distance; // in km
  final String status; // Active, Paused, Expired
  final DateTime createdAt;
  final int views;
  final int contacts;

  const Listing({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.unit,
    required this.category,
    required this.supplierId,
    required this.supplierName,
    this.isSupplierVerified = false,
    required this.images,
    required this.location,
    this.coordinates,
    required this.distance,
    this.status = 'Active',
    required this.createdAt,
    this.views = 0,
    this.contacts = 0,
  });

  @override
  List<Object?> get props => [id, title, price, supplierId, status, coordinates];
}
