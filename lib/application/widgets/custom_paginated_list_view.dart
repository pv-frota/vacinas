import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vacinas/application/constants/icons.dart';
import 'package:vacinas/application/controllers/manipulate_animal_controller.dart';
import 'package:vacinas/domain/models/entity.dart';

///Paginated ListView as an alternative to PaginatedDataTable used in the web
class CustomPaginatedListView extends StatefulWidget {
  CustomPaginatedListView(
      {Key? key,
      required this.data,
      required this.itemsPerPage,
      required this.usesIcon,
      required this.listName,
      this.onTap})
      : super(key: key);

  ///List of children of Entity used for building the ListView
  final List<Entity> data;
  final String listName;

  ///Number of items per page
  final int itemsPerPage;

  final bool usesIcon;
  final void Function(int index)? onTap;

  @override
  _CustomPaginatedListViewState createState() =>
      _CustomPaginatedListViewState();
}

class _CustomPaginatedListViewState extends State<CustomPaginatedListView> {
  int? itemsPerPage;
  List<Entity>? data;
  bool? usesIcon;
  String? listName;

  List<Entity>? dataInPage = [];
  int lastPageLastIndex = 0;
  int currentPageIndex = 0;
  List<String>? valueDescriptionList;
  String? iconDescription;
  int? iconIndex;

  @override
  void initState() {
    this.data = widget.data;
    final e = this.data![0];
    this.itemsPerPage = widget.itemsPerPage;
    this.usesIcon = widget.usesIcon;
    this.listName = widget.listName;
    this.valueDescriptionList = e.valuesDescriptions;

    if (usesIcon!) {
      iconIndex = valueDescriptionList!.indexOf(e.iconAttributeName!);
      iconDescription = e.iconAttributeName!;
    }

    if (data!.length > 0) {
      generatePageList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          child: Column(
        children: [
          Text(listName!),
          data!.length == 0
              ? Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text("Nenhum ${listName!} encontrado"),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: currentPageIndex != maxPageCount - 1
                      ? itemsPerPage!
                      : lastPageLength,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: widget.onTap != null
                          ? () {
                              if (currentPageIndex == 0) {
                                widget.onTap!(index + lastPageLastIndex);
                              } else if (currentPageIndex != maxPageCount - 1) {
                                widget.onTap!(index + lastPageLastIndex + 1);
                              } else {
                                widget.onTap!(index + lastPageLastIndex + 2);
                              }
                            }
                          : null,
                      child: Column(
                        children: [
                          generateTile(index)
                          // Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: generateRow(index)),
                        ],
                      ),
                    );
                  },
                ),
          data!.length == 0
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Text(generatePageDescription()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${currentPageIndex + 1} of $maxPageCount"),
                        IconButton(
                          onPressed: 0 == currentPageIndex
                              ? null
                              : () => generatePageList(operation: -1),
                          icon: Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: maxPageCount - 1 == currentPageIndex
                              ? null
                              : () => generatePageList(operation: 1),
                          icon: Icon(Icons.arrow_forward),
                        )
                      ],
                    )
                  ],
                )
        ],
      )),
    );
  }

  String generatePageDescription() {
    String pageDescription = "";
    if (currentPageIndex == 0) {
      pageDescription +=
          "${lastPageLastIndex + 1} - ${itemsPerPage! * (currentPageIndex + 1)}";
    } else if (currentPageIndex == maxPageCount - 1) {
      pageDescription +=
          "${data!.length - lastPageLength + 1} - ${data!.length}";
    } else {
      pageDescription +=
          "${lastPageLastIndex + 2} - ${itemsPerPage! * (currentPageIndex + 1)}";
    }

    pageDescription += " of ${data!.length}";
    return pageDescription;
  }

  Widget generateDivider(int index) {
    if (index == 2) {
      return Container();
    }
    if (index == lastPageLength - 1) {
      if (currentPageIndex == maxPageCount - 1) {
        return Container();
      }
    }
    return Divider(color: Colors.white);
  }

  void generatePageList({int? operation}) {
    List<Entity> list = [];
    if (operation != null) {
      setState(() {
        currentPageIndex += operation;
        lastPageLastIndex += (operation * (itemsPerPage! - 1));
      });
    }
    if (currentPageIndex == 0) {
      for (int i = 0; i < 3; i++) {
        list.add(data![i + lastPageLastIndex]);
      }
    } else if (currentPageIndex != maxPageCount - 1) {
      for (int i = 0; i < 3; i++) {
        list.add(data![i + lastPageLastIndex + 1]);
      }
    } else {
      for (int i = 0; i < lastPageLength; i++) {
        list.add(data![i + lastPageLastIndex + 2]);
      }
    }
    setState(() {
      dataInPage = list;
    });
  }

  ListTile generateTile(int index) {
    final entity = dataInPage![index];

    return ListTile(
      leading: usesIcon! && IconHandler.isIconColumn(entity.values![iconIndex!])
          ? Image(
              height: 25,
              width: 25,
              color: Colors.amber,
              image:
                  AssetImage(IconHandler.iconPath(entity.values![iconIndex!])))
          : Text(entity.values![0]),
      title: Text(entity.values![1]),
      subtitle: Text(entity.values![2]),
    );
  }

  // List<Widget> generateRow(int index) {
  //   final entity = dataInPage![index];
  //   List<Widget> list = [Text(entity.key.toString()), Text(entity.name)];

  //   if (usesOptionalFields!) {
  //     if (entity.optional1 != null) {
  //       String optional1 = entity.optional1!;
  //       if (IconHandler.isIconColumn(optional1)) {
  //         list.add(Image(
  //             height: 25,
  //             width: 25,
  //             color: Colors.amber,
  //             image: AssetImage(IconHandler.iconPath(optional1))));
  //       } else {
  //         list.add(Text(optional1));
  //       }
  //     }
  //     if (entity.optional2 != null) {
  //       String optional2 = entity.optional2!;
  //       list.add(Text(optional2));
  //     }
  //     if (entity.optional3 != null) {
  //       String optional3 = entity.optional3!;
  //       list.add(Text(optional3));
  //     }
  //   }
  //   return list;
  // }

  int get maxPageCount => (data!.length / itemsPerPage!).ceil();
  int get lastPageLength {
    int result = data!.length % itemsPerPage!;
    if (result == 0) {
      return itemsPerPage!;
    }
    return result;
  }
}

class IconHandler {
  static const List<String> animalIcons = ["G", "C"];

  static bool isIconColumn(String s) => s.length == 1;

  static String iconPath(String iconName) {
    if (animalIcons.contains(iconName)) {
      switch (iconName) {
        case "C":
          return dogIcon;
        case "G":
          return catIcon;
      }
    }
    return "";
  }
}
