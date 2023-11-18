import 'package:flutter/cupertino.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_categorybloc/create_categorybloc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';
Future getCategoryCreation (BuildContext context) {
    List<String> MyCategoriesIcons = [
    'entertainment',
    'food',
    'home',
    'shopping',
    'medical',
    'travel',
    'extra',
  ];
  return showDialog(
    context: context,
    builder: (ctx) {
      TextEditingController Categorynamecontroller =
          TextEditingController();
      TextEditingController CategoryIconcontroller =
          TextEditingController();
      TextEditingController CategoryColorcontroller =
          TextEditingController();
      bool isLoading = false;
      bool isExpanded = false;
      String selectedIcon = '';
      Color categorycolor = Colors.white;
      Category category =Category.empty;

      return StatefulBuilder(
         builder: (ctx, setState) {
        return BlocProvider.value(
          value: context.read<CreateCategoryblocBloc>(),
          child: BlocListener<CreateCategoryblocBloc, CreateCategoryblocState>(
            listener: (context, state) {
              if(state is CreateCategoryblocSuccess)
              {
                Navigator.pop(ctx,category);
              }
              else if (state is CreateCategoryblocLoading){
                setState(() {
                  isLoading = true ;
                });
              }
            },
            child: AlertDialog(
              title: Text('Create a Category'),
              content: SizedBox(
                width:
                    MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller:
                          Categorynamecontroller,
                      textAlignVertical:
                          TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                            borderSide:
                                BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller:
                          CategoryIconcontroller,
                      readOnly: true,
                      textAlignVertical:
                          TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        suffixIcon: Icon(
                          CupertinoIcons.chevron_down,
                          size: 12,
                        ),
                        fillColor: Colors.white,
                        hintText: 'Icon',
                        border: OutlineInputBorder(
                            borderRadius: isExpanded
                                ? BorderRadius.vertical(
                                    top:
                                        Radius.circular(
                                            12))
                                : BorderRadius.circular(
                                    12),
                            borderSide:
                                BorderSide.none),
                      ),
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                    isExpanded
                        ? Container(
                            width:
                                MediaQuery.of(context)
                                    .size
                                    .width,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.vertical(
                                      bottom: Radius
                                          .circular(
                                              12)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(
                                      8.0),
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              3,
                                          mainAxisSpacing:
                                              15,
                                          crossAxisSpacing:
                                              20),
                                  itemCount:
                                      MyCategoriesIcons
                                          .length,
                                  itemBuilder:
                                      (context, int i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIcon =
                                              MyCategoriesIcons[
                                                  i];
                                        });
                                      },
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration:
                                            BoxDecoration(
                                          border: Border
                                              .all(
                                            width: 3,
                                            color: selectedIcon ==
                                                    MyCategoriesIcons[
                                                        i]
                                                ? Colors
                                                    .green
                                                : Colors
                                                    .grey,
                                          ),
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                                      12),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets
                                                  .all(
                                                      8.0), // Adjust the padding value as needed
                                          child: Image
                                              .asset(
                                            'assets/${MyCategoriesIcons[i]}.png',
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller:
                          CategoryColorcontroller,
                      readOnly: true,
                      textAlignVertical:
                          TextAlignVertical.center,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: categorycolor,
                        hintText: 'Color',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    12),
                            borderSide:
                                BorderSide.none),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx2) {
                              Color tempColor =
                                  categorycolor;
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize:
                                      MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                        pickerColor:
                                            Colors.blue,
                                        onColorChanged:
                                            (value) {
                                          tempColor =
                                              value;
                                        }),
                                    SizedBox(
                                      width: double
                                          .infinity,
                                      height: 50,
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            categorycolor =
                                                tempColor;
                                          });
                                          Navigator.pop(
                                              ctx2);
                                        },
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                Colors
                                                    .black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12))),
                                        child: Text(
                                          'Save',
                                          style: TextStyle(
                                              fontSize:
                                                  22,
                                              color: Colors
                                                  .white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: kToolbarHeight,
                      child: isLoading == true
                      ? Center(
                        child: CircularProgressIndicator(),
                      )
                      : TextButton(
                          onPressed: () {
                            
                            setState (() {
                              category.categoryId =Uuid().v1();
                            category.name =Categorynamecontroller.text;
                            category.icon =selectedIcon;
                            category.color =categorycolor.value;
                            });
                            
                            context.read<CreateCategoryblocBloc>()
                                .add(CreateCategory(
                                    category));
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Colors.black,
                              shape:
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                                  12))),
                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
         },
      );
    });

}