import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchableList<T> extends StatefulWidget {
  final T value;
  final Function(T) onChange;
  final bool Function(String, T) searchCondition;
  final Function onClear;
  final List<T> items;
  final Widget Function(T) buildItem;
  final String Function(T) showSelected;
  final String searchHint;
  final bool disabled;

  //States
  final Function onTextChange;
  final String textColor;
  final String backgroundColor;
  final bool isPassword;
  final String label;
  final IconData icon;
  final bool required;
  final FocusNode focusNode;
  final bool isValid;
  final String hint;

  SearchableList({
    this.value,
    this.onChange,
    this.textColor = "c0c0c0",
    this.backgroundColor = "ffffff",
    this.isPassword = false,
    this.label = "",
    this.icon,
    this.required = true,
    this.focusNode,
    this.isValid = false,
    this.hint = "",
    this.onTextChange,
    this.items,
    this.buildItem,
    this.showSelected,
    this.searchHint = "Search",
    this.onClear,
    this.disabled = false,
    this.searchCondition,
  });

  @override
  _SearchableListState createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {
  bool selected;
  TextEditingController _controller;
  TextEditingController _searchController;
  T itemSelected;
  List<T> searchableList;

  @override
  void initState() {
    super.initState();
    selected = widget.value != null;
    _controller = TextEditingController(text: widget.showSelected(widget.value));
    _searchController = TextEditingController();
    searchableList = widget.items;
    _searchController.addListener(() {
      _filterList(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.showSelected(widget.value);
    selected = widget.value != null;

    if (widget.focusNode != null && widget.disabled) {
      widget.focusNode.unfocus();
    }

    if (_searchController.text.isEmpty) {
      searchableList = widget.items;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: selected ? constraints.biggest.width * 0.93 : constraints.biggest.width,
              child: TextField(
                readOnly: true,
                onTap: !widget.disabled
                    ? () async {
                        await _showDialogList(context);
                      }
                    : null,
                controller: _controller,
                focusNode: widget.focusNode != null ? widget.focusNode : null,
                style: TextStyle(
                  //color: HexColor(textColor),
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  labelText: widget.label,
                  labelStyle: TextStyle(
                    //color: HexColor(textColor),
                    fontSize: 18,
                  ),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  hintStyle: TextStyle(
                    //color: HexColor(textColor),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            if (selected) ...[
              InkWell(
                onTap: () {
                  widget.onClear();
                },
                child: Icon(Icons.clear),
              ),
            ]
          ],
        );
      },
    );
  }

  Future<void> _showDialogList(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              print(MediaQuery.of(context).viewInsets.bottom);

              return Wrap(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                        child: Text(
                          widget.hint,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: widget.searchHint,
                            hintStyle: TextStyle(
                              //color: HexColor(textColor),
                              fontSize: 15,
                            ),
                            border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: constraints.biggest.height * 0.7,
                        child: ListView.builder(
                          itemCount: searchableList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selected = true;
                                });

                                widget.onChange(searchableList[index]);
                                Navigator.pop(context);
                                _searchController.clear();
                              },
                              child: widget.buildItem(searchableList[index]),
                            );
                          },
                        ),
                      ),
                      Divider(),
                      Container(
                        height: constraints.biggest.height * 0.1,
                        padding: EdgeInsets.only(right: 8, bottom: 8),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancelar"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  _filterList(String query) {
    print(query);

    if (query.isNotEmpty) {
      setState(() {
        searchableList =
            widget.items.where((T item) => widget.searchCondition(query, item)).toList();
      });
    }
  }
}
