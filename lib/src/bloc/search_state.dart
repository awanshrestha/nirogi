import 'package:meta/meta.dart';
import 'package:nirogi/src/models/models.dart';

abstract class SearchState {}

class SearchUninitialisedState extends SearchState {}

class SearchFetchingState extends SearchState {}

class SearchDrugFetchedState extends SearchState {
  final List<Drug> drugs;
  SearchDrugFetchedState({@required this.drugs}) : assert(drugs != null);
}

class SearchErrorState extends SearchState {}

class SearchEmptyState extends SearchState {}