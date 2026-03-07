import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/models.dart';
import '../../../core/mock_data.dart';

// Events
abstract class BuyerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadListings extends BuyerEvent {
  final ListingCategory? category;
  LoadListings({this.category});
  @override
  List<Object?> get props => [category];
}

class SearchListings extends BuyerEvent {
  final String query;
  SearchListings(this.query);
  @override
  List<Object?> get props => [query];
}

// States
abstract class BuyerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BuyerInitial extends BuyerState {}
class BuyerLoading extends BuyerState {}
class ListingsLoaded extends BuyerState {
  final List<Listing> listings;
  final List<Category> categories;
  ListingsLoaded(this.listings, this.categories);
  @override
  List<Object?> get props => [listings, categories];
}

// Bloc
class BuyerBloc extends Bloc<BuyerEvent, BuyerState> {
  BuyerBloc() : super(BuyerInitial()) {
    on<LoadListings>((event, emit) async {
      emit(BuyerLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      var filtered = MockData.listings;
      if (event.category != null) {
        filtered = filtered.where((l) => l.category == event.category).toList();
      }
      emit(ListingsLoaded(filtered, MockData.categories));
    });

    on<SearchListings>((event, emit) async {
      emit(BuyerLoading());
      await Future.delayed(const Duration(milliseconds: 500));
      final filtered = MockData.listings.where((l) =>
        l.title.toLowerCase().contains(event.query.toLowerCase()) ||
        l.description.toLowerCase().contains(event.query.toLowerCase())
      ).toList();
      emit(ListingsLoaded(filtered, MockData.categories));
    });
  }
}
