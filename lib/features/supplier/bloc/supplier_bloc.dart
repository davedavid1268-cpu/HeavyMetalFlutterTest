import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/models.dart';
import '../../../core/mock_data.dart';

// Events
abstract class SupplierEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSupplierDashboard extends SupplierEvent {
  final String supplierId;
  LoadSupplierDashboard(this.supplierId);
  @override
  List<Object?> get props => [supplierId];
}

class CreateListing extends SupplierEvent {
  final Listing listing;
  CreateListing(this.listing);
  @override
  List<Object?> get props => [listing];
}

// States
abstract class SupplierState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SupplierInitial extends SupplierState {}
class SupplierLoading extends SupplierState {}
class SupplierDashboardLoaded extends SupplierState {
  final Supplier supplier;
  final List<Listing> myListings;
  SupplierDashboardLoaded(this.supplier, this.myListings);
  @override
  List<Object?> get props => [supplier, myListings];
}

// Bloc
class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  SupplierBloc() : super(SupplierInitial()) {
    on<LoadSupplierDashboard>((event, emit) async {
      emit(SupplierLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      final supplier = MockData.suppliers.firstWhere((s) => s.id == event.supplierId);
      final myListings = MockData.listings.where((l) => l.supplierId == event.supplierId).toList();
      emit(SupplierDashboardLoaded(supplier, myListings));
    });
  }
}
