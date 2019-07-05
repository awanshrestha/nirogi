import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nirogi/src/bloc/blocs.dart';
import 'package:nirogi/src/bloc/events.dart';
import 'package:nirogi/src/bloc/states.dart';
import 'package:nirogi/src/screens/screens.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode focusNode;
  SearchBloc searchBloc;
  String searchQuery = "";
  GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    searchBloc = SearchBloc();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          onFieldSubmitted: (value) {
            if (_key.currentState.validate()) {
              _key.currentState.save();
              searchBloc.dispatch(DrugSearchEvent(query: searchQuery));
              print(searchQuery);
            }
          },
          key: _key,
          validator: (value) {
            if (value.isEmpty || value.length < 6) {
              return "Enter at least 6 characters";
            }
            return null;
          },
          onSaved: (value) {
            searchQuery = value.trim();
          },
          focusNode: focusNode,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
          ),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red[700]),
            ),
            hintText: 'Search for drug',
            labelStyle: TextStyle(
              fontSize: 18,
              color: Colors.red[700],
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
            ),
            suffix: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.search),
              onPressed: () {
                if (_key.currentState.validate()) {
                  _key.currentState.save();
                  searchBloc.dispatch(DrugSearchEvent(query: searchQuery));
                  print(searchQuery);
                }
              },
            ),
          ),
        ),
      ),
      body: Container(
        child: BlocBuilder(
          bloc: searchBloc,
          builder: (BuildContext context, state) {
            if (state is SearchUninitialisedState) {
              return Center(
                child: Text('Search for the drug here.'),
              );
            }
            if (state is SearchFetchingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is SearchErrorState) {
              return Center(
                child: Text('error'),
              );
            }
            if (state is SearchEmptyState) {
              return Center(
                child: Text("Nothing fround for the query\n\n$searchQuery"),
              );
            }
            if (state is SearchDrugFetchedState) {
              return Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: state.drugs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return DrugCard(drug: state.drugs[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 15.0,
                      );
                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
