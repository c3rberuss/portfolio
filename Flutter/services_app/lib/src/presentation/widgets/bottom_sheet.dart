import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:services/src/blocs/application/application_bloc.dart';
import 'package:services/src/blocs/application/application_event.dart';
import 'package:services/src/blocs/application/application_state.dart';
import 'package:services/src/presentation/widgets/image_item.dart';
import 'package:services/src/presentation/widgets/separators.dart';
import 'package:services/src/presentation/widgets/text_area.dart';
import 'package:services/src/utils/screen_utils.dart';

class CustomBottomSheet extends StatefulWidget {
  final Function closeBottomSheet;

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();

  CustomBottomSheet({@required this.closeBottomSheet}) : super();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  // ignore: close_sinks
  ApplicationBloc _bloc;
  final descriptionController = TextEditingController();
  final _focusNode = FocusNode();

  final style = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black38,
  );

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ApplicationBloc>(context);
    descriptionController.text = _bloc.state.application.description;
    descriptionController.addListener(() {
      _bloc.add(ChangeDescriptionEvent(descriptionController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.times,
                          color: Colors.red,
                        ),
                        onPressed: widget.closeBottomSheet,
                      ),
                      SizedBox(
                        width: getScreenWidth(context) * .1,
                      ),
                      Center(
                        child: Text("Resume", style: style),
                      )
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 16),
                  BlocBuilder<ApplicationBloc, ApplicationState>(
                    builder: (BuildContext context, ApplicationState state) {
                      return Table(
                        children: <TableRow>[
                          TableRow(children: <Widget>[
                            Text("Total services"),
                            Text(
                              state.total,
                              textAlign: TextAlign.right,
                            )
                          ]),
                          TableRow(children: <Widget>[
                            Text("Total Workforce"),
                            Text(
                              state.workforce,
                              textAlign: TextAlign.right,
                            )
                          ]),
                          TableRow(children: <Widget>[
                            Text("Home service charge"),
                            Text(
                              state.homeServiceStr,
                              textAlign: TextAlign.right,
                            ),
                          ]),
                          TableRow(children: <Widget>[
                            Text("Total"),
                            Text(
                              state.totFinal,
                              //"\$${application.total.toStringAsFixed(2)}",
                              textAlign: TextAlign.right,
                            )
                          ]),
                        ],
                      );
                    },
                  ),
                  separatorV(16),
                  Divider(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Description about your location", style: style),
                  ),
                  TextArea(
                    placeholder: "In front of...",
                    maxLines: 4,
                    focusNode: _focusNode,
                    controller: descriptionController,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Images", style: style),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.plus, color: Colors.blue),
                        onPressed: () async {
                          _focusNode.unfocus();
                          final File image = await ImagePicker.pickImage(
                              source: ImageSource.camera, imageQuality: 90);

                          if (image != null) {
                            _bloc.add(AddImageEvent(image));
                          }
                        },
                      )
                    ],
                  ),
                  Divider(),
                  BlocBuilder<ApplicationBloc, ApplicationState>(
                    builder: (BuildContext context, ApplicationState state) {
                      if (state.files.length > 0) {
                        return Container(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) {
                              return ImageItem(
                                image: state.files[index],
                                removeImage: () {
                                  _bloc.add(RemoveImageEvent(index));
                                },
                              );
                            },
                            itemCount: state.files.length,
                          ),
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            "No images addeds",
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
