import 'package:flutter/material.dart';

class DiseaseBlock extends StatelessWidget {
  final disease;
  const DiseaseBlock({
    @required this.disease,
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Here');
      },
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 1.0,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Row(
            children: <Widget>[
              Container(
                child: Image.network(
                  disease.imageUrl,
                  height: 120,
                  width: 140,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        disease.name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.body1.copyWith(
                              fontSize: 16,
                              color: Colors.red[700],
                            ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text(disease.body,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          maxLines: 5,
                          style: Theme.of(context)
                              .textTheme
                              .body2
                              .copyWith(fontSize: 14)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
