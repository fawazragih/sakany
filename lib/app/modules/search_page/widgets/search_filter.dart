// import 'package:flutter/material.dart';
// import '../../../data/models/catalog_products_model.dart';
//
// class SearchFilter extends StatefulWidget {
//
//   final CatalogProductsModel catalogProductsModel;
//
//   const SearchFilter({super.key,required this.catalogProductsModel,});
//
//
//   @override
//   State<SearchFilter>  createState() => _SearchFilterState();
//
//
// }
//
// class _SearchFilterState extends State<SearchFilter> {
//   final GlobalService _globalService = GlobalService();
//   var _currentRangeValues;
//   var txtMin = TextEditingController();
//   var txtMax = TextEditingController();
//   ProductListResponse? productList;
//   String orderBy = '';
//   String price = '';
//   String specs = '';
//   String ms = '';
//   List<String> specsArr = [];
//   List<String> msArr = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.catalogProductsModel.priceRangeFilter?.enabled == true) {
//       _currentRangeValues = RangeValues(
//           widget.catalogProductsModel.priceRangeFilter?.selectedPriceRange?.from!.toDouble() ?? 0.0,
//           widget.catalogProductsModel.priceRangeFilter?.selectedPriceRange?.to != null
//               ? widget.catalogProductsModel.priceRangeFilter?.selectedPriceRange?.to?.toDouble()??0.0
//               : 0);
//       txtMin.text = widget
//               .catalogProductsModel.priceRangeFilter?.selectedPriceRange?.from
//               ?.round()
//               .toString() ??
//           '0';
//       txtMax.text = widget.catalogProductsModel.priceRangeFilter
//                   ?.selectedPriceRange?.to !=
//               null
//           ? (widget
//                   .catalogProductsModel.priceRangeFilter?.selectedPriceRange?.to
//                   ?.round()
//                   .toString() ??
//               '0')
//           : '0';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppBar(
//           leading: InkWell(
//             child: const Icon(Icons.close),
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           title: Text(_globalService.getString(Const.FILTER)),
//         ),
//         body: getFilterWidget());
//   }
//
//   Widget getFilterWidget() {
//     // Price range filter
//     List<Widget> priceRangeFilter(num min, num max) {
//       return [
//         sectionTitleWithDivider(_globalService.getString(
//             _globalService.getString(Const.FILTER_PRICE_RANGE))),
//         Row(
//           children: [
//             const SizedBox(
//               width: 15,
//             ),
//             Container(
//               child: Text('Min ${min.round()}'),
//             ),
//             const Spacer(),
//             Container(
//               child: Text('Max ${max.round()}'),
//             ),
//             const SizedBox(
//               width: 15,
//             ),
//           ],
//         ),
//         RangeSlider(
//           values: _currentRangeValues,
//           min: min.toDouble(),
//           max: max.toDouble(),
//           divisions: max.round(),
//           labels: RangeLabels(
//             _currentRangeValues.start.round().toString(),
//             _currentRangeValues.end.round().toString(),
//           ),
//           onChanged: (RangeValues values) {
//             setState(() {
//               _currentRangeValues = values;
//               txtMin.text = values.start.round().toString();
//               txtMax.text = values.end.round().toString();
//             });
//           },
//         ),
//         Row(
//           children: [
//             const SizedBox(
//               width: 15,
//             ),
//             Container(
//               width: 80,
//               height: 40,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: const Color(0xFFD4D3DA),
//                 ),
//               ),
//               child: TextField(
//                 controller: txtMin,
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.number,
//                 autofocus: false,
//                 decoration: const InputDecoration(
//                   focusedBorder: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   hintText: '0',
//                 ),
//                 onEditingComplete: () {
//                   setState(() {
//                     FocusScope.of(context).unfocus();
//                     _currentRangeValues = RangeValues(
//                         double.parse(txtMin.text), double.parse(txtMax.text));
//                   });
//                 },
//               ),
//             ),
//             const Spacer(),
//             Container(
//               width: 80,
//               height: 40,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: const Color(0xFFD4D3DA),
//                 ),
//               ),
//               child: TextField(
//                 controller: txtMax,
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.number,
//                 autofocus: false,
//                 decoration: const InputDecoration(
//                   focusedBorder: InputBorder.none,
//                   enabledBorder: InputBorder.none,
//                   hintText: '0',
//                 ),
//                 onEditingComplete: () {
//                   setState(() {
//                     FocusScope.of(context).unfocus();
//                     _currentRangeValues = RangeValues(
//                         double.parse(txtMin.text), double.parse(txtMax.text));
//                   });
//                 },
//               ),
//             ),
//             if (widget.catalogProductsModel.priceRangeFilter?.enabled ?? false)
//               const SizedBox(
//                 width: 15,
//               ),
//           ],
//         ),
//       ];
//     }
//
//     // Specification filter
//     List<Widget> specificationFilter(List<Attribute> attributes) {
//       return attributes
//           .map<Widget>((e) => Column(
//                 children: [
//                   if ((e.values?.length ?? 0) > 0)
//                     sectionTitleWithDivider(_globalService.getString(
//                         '${_globalService.getString(Const.FILTER_SPECIFICATION)}: ${e.name}')),
//                   if ((e.values?.length ?? 0) > 0)
//                     ...e.values
//                             ?.map<Widget>((e) => e.colorSquaresRgb != null
//                                 ? CheckboxListTile(
//                                 secondary: Container(
//                                   width: 30,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                       color: parseColor(e.colorSquaresRgb),
//                                       shape: BoxShape.circle),
//                                 ),
//                                     title: Text(e.name ?? ''),
//                                     value: e.selected,
//                                 onChanged: (_) {
//                                   setState(() {
//                                         e.selected = !(e.selected ?? false);
//                                       });
//                                 })
//                             : CheckboxListTile(
//                                     title: Text(e.name ?? ''),
//                                     value: e.selected,
//                                 onChanged: (_) {
//                                   setState(() {
//                                         e.selected = !(e.selected ?? false);
//                                       });
//                                 }))
//                             .toList() ??
//                         [],
//                 ],
//               ))
//           .toList();
//     }
//
//     // Manufacture filter
//     List<Widget> manufacturerFilter(List<AvailableSortOption> manufactures) {
//       return [
//         sectionTitleWithDivider(_globalService.getString(
//             _globalService.getString('Filter by manufacturer'))),
//         ...manufactures
//             .map<Widget>((e) => CheckboxListTile(
//                 title: Text(e.text ?? ""),
//                 value: e.selected,
//                 onChanged: (_) {
//                   setState(() {
//                     e.selected = !(e.selected ?? false);
//                   });
//                 }))
//
//       ];
//     }
//
//     // Apply filter button
//     CustomButton btnApplyFilter = CustomButton(
//       label: 'Apply Filter',
//       shape: ButtonShape.RoundedTopLeft,
//       onClick: () => _applyFilter(),
//       // backgroundColor: Styles.secondaryButtonColor,
//     );
//
//     // Clear all button
//     CustomButton btnClearAll = CustomButton(
//       label: 'Clear All',
//       shape: ButtonShape.RoundedTopRight,
//       onClick: () => _clearAll(),
//     );
//
//     return Stack(children: [
//       Padding(
//         padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
//         child: SingleChildScrollView(
//             child: Column(
//           children: [
//             if (widget.catalogProductsModel.priceRangeFilter?.enabled ?? false)
//               ...priceRangeFilter(
//                   widget.catalogProductsModel.priceRangeFilter
//                           ?.availablePriceRange?.from ??
//                       0,
//                   widget.catalogProductsModel.priceRangeFilter
//                           ?.availablePriceRange?.to ??
//                       0),
//             if ((widget.catalogProductsModel.specificationFilter?.enabled ??
//                     false) &&
//                 (widget.catalogProductsModel.specificationFilter?.attributes
//                             ?.length ??
//                         0) >
//                     0)
//               ...specificationFilter(
//                   widget.catalogProductsModel.specificationFilter?.attributes ??
//                       []),
//             if ((widget.catalogProductsModel.manufacturerFilter?.enabled ??
//                     false) &&
//                 (widget.catalogProductsModel.manufacturerFilter?.manufacturers
//                             ?.length ??
//                         0) >
//                     0)
//               ...manufacturerFilter(widget
//                       .catalogProductsModel.manufacturerFilter?.manufacturers ??
//                   [])
//           ],
//         )),
//       ),
//       Align(
//           alignment: Alignment.bottomCenter,
//           child: Row(
//             children: [
//               Expanded(child: btnApplyFilter),
//               Expanded(child: btnClearAll),
//             ],
//           )),
//     ]);
//   }
//
//   void _applyFilter() {
//     Navigator.of(context).pop();
//
//     // widget.bloc.type = widget.type;
//     // widget.bloc.categoryId = widget.id;
//     widget.bloc.searchPageNumber = 1;
//     // widget.bloc.orderBy = widget.orderBy;
//
//     widget.bloc.price = '${txtMin.text}-${txtMax.text}';
//
//     specs = '';
//
//     widget.catalogProductsModel.specificationFilter?.attributes
//         ?.forEach((attr) {
//       attr.values?.forEach((val) {
//         if (val.selected ?? false) {
//           specsArr.add(val.id.toString());
//         }
//       });
//     });
//
//     for (var i = 0; i < specsArr.length; i++) {
//       if (i != specsArr.length - 1) {
//         specs += '${specsArr[i]},';
//       } else {
//         specs += specsArr[i];
//       }
//     }
//
//     widget.bloc.specs = specs;
//
//     ms = '';
//
//     widget.catalogProductsModel.manufacturerFilter?.manufacturers
//         ?.forEach((manufacturer) {
//       if (manufacturer.selected ?? false) {
//         msArr.add(manufacturer.value ?? '');
//       }
//     });
//
//     for (var i = 0; i < msArr.length; i++) {
//       if (i != msArr.length - 1) {
//         ms += '${msArr[i]},';
//       } else {
//         ms += msArr[i];
//       }
//     }
//
//     widget.bloc.ms = ms;
//
//     widget.bloc.searchProduct();
//   }
//
//   void _clearAll() {
//     Navigator.of(context).pop();
//
//     // widget.bloc.type = widget.type;
//     // widget.bloc.categoryId = widget.id;
//     widget.bloc.searchPageNumber = 1;
//     // widget.bloc.orderBy = widget.orderBy;
//     widget.bloc.price = '';
//     widget.bloc.specs = '';
//     widget.bloc.ms = '';
//
//     widget.bloc.searchProduct();
//   }
// }
