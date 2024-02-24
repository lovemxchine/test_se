// import 'package:flutter/material.dart';

// import '../provider/quantity_selector.dart';

// class ProductQuantitySelectorRow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final value = Provider.of<QuantitySelector>(context);

//     return Row(
//       children: [
//         ProductQuantitySelector(
//           margin: const EdgeInsets.only(right: 10),
//           symbol: '-',
//           onTap: () {
//             value.quantityDecreament();
//           },
//         ),
//         Text(value.quantity.toString()),
//         ProductQuantitySelector(
//           margin: const EdgeInsets.only(left: 10),
//           symbol: '+',
//           onTap: () {
//             value.quantityIncreament();
//           },
//         )
//       ],
//     );
//   }
// }
