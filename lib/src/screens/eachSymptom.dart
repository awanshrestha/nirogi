import 'package:flutter/material.dart';
import 'package:nirogi/src/models/models.dart';
import 'package:nirogi/src/repository/repositories.dart';
import 'package:nirogi/src/themes/scrollOverlay.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class EachSymptom extends StatefulWidget {
  final Symptom symptom;
  EachSymptom({@required this.symptom});
  @override
  _EachSymptomState createState() => _EachSymptomState();
}

class _EachSymptomState extends State<EachSymptom> {
  ScrollController _customController;
  Future<Symptom> symptom;
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    symptom = symptomRepository.getSymptom(symptomId: widget.symptom.symptomId);
    _customController = ScrollController()
      ..addListener(
        () => setState(
              () {
                _isCollapsed =
                    (_customController.offset <= kToolbarHeight) ? false : true;
              },
            ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder<Symptom>(
        future: symptom,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ScrollConfiguration(
              behavior: RemoveEndOfListIndicator(),
              child: NestedScrollView(
                controller: _customController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      centerTitle: true,
                      title: _isCollapsed
                          ? Text(
                              widget.symptom.symptom,
                              style: Theme.of(context).textTheme.body1.copyWith(
                                    fontSize: 20,
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                            )
                          : Text(
                              widget.symptom.symptom,
                              style: Theme.of(context).textTheme.body1.copyWith(
                                    fontSize: 20,
                                    color: Colors.transparent,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          widget.symptom.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Html(
                      data: snapshot.data.body,
                      customTextStyle: (dom.Node node, style) {
                        if (node is dom.Element) {
                          switch (node.localName) {
                            case "code":
                              {
                                return style.copyWith(
                                    color: Colors.red[700],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat');
                              }
                              break;
                            case "b":
                              {
                                return style.copyWith(
                                    color: Colors.blue,
                                    fontFamily: 'Montserrat');
                              }
                              break;
                            default:
                              {
                                return style.copyWith(
                                    fontSize: 15, fontFamily: 'karla');
                              }
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              child: Center(
                child: Text('error'),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}