// import 'dart:io';
// import 'dart:math';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:sales_management_system/Database/database.dart';

// class Reports {
//   static Future generateReport() async {
//     PdfPageFormat pageFormat = PdfPageFormat.a4;

//     await DB.openCon('product');
//     List<Map<String, dynamic>> data1 = await DB.collection.find().toList();
//     await DB.closeCon();
//     data1.sort(((a, b) => b['SellingPrice'].compareTo(a['SellingPrice'])));

//     List<List<dynamic>> dataTable1 = [];
//     for (int i = 0; i < 5; i++) {
//       List<dynamic> temp = [];
//       temp.add(data1[i]['ProductName']);
//       temp.add(data1[i]['CostPrice']);
//       temp.add(data1[i]['SellingPrice']);
//       dataTable1.add(temp);
//     }

//     const baseColor = PdfColors.cyan;

//     // Create a PDF document.
//     final document = pw.Document();

//     final theme = pw.ThemeData.withFont(
//       base: await PdfGoogleFonts.openSansRegular(),
//       bold: await PdfGoogleFonts.openSansBold(),
//     );

//     // Title Page
//     document.addPage(
//       pw.Page(
//           pageFormat: pageFormat,
//           theme: theme,
//           build: (context) {
//             return pw.Center(
//                 child: pw.Column(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
//                     children: [
//                   pw.Text('Business Report',
//                       style: pw.TextStyle(
//                           fontSize: 50,
//                           fontWeight: pw.FontWeight.bold,
//                           color: PdfColors.yellow900)),
//                   pw.Text('Tata Motors',
//                       style: pw.TextStyle(
//                           fontSize: 40,
//                           fontWeight: pw.FontWeight.bold,
//                           color: PdfColors.blue900)),
//                   pw.Text('Overall',
//                       style: pw.TextStyle(
//                           fontSize: 30,
//                           fontWeight: pw.FontWeight.bold,
//                           color: PdfColors.yellow)),
//                 ]));
//           }),
//     );

//     // Top Products Table
//     final table1 = pw.Table.fromTextArray(
//       border: pw.TableBorder.all(width: 1),
//       headers: ['Product Name', 'Cost Price', 'Selling Price', 'Profit'],
//       data: List<List<dynamic>>.generate(
//         dataTable1.length,
//         (index) => <dynamic>[
//           dataTable1[index][0],
//           dataTable1[index][1],
//           dataTable1[index][2],
//           (dataTable1[index][2] as num) - (dataTable1[index][1] as num),
//         ],
//       ),
//       headerStyle: pw.TextStyle(
//         color: PdfColors.white,
//         fontWeight: pw.FontWeight.bold,
//       ),
//       headerDecoration: const pw.BoxDecoration(
//         color: baseColor,
//       ),
//       rowDecoration: const pw.BoxDecoration(
//         border: pw.Border(
//           bottom: pw.BorderSide(
//             color: baseColor,
//             width: .5,
//           ),
//         ),
//       ),
//       cellAlignment: pw.Alignment.center,
//       cellAlignments: {0: pw.Alignment.center},
//     );

//     // Top Products Chart
//     final chart1 = pw.Chart(
//       left: pw.Container(
//         alignment: pw.Alignment.topCenter,
//         margin: const pw.EdgeInsets.only(right: 5, top: 150),
//         child: pw.Transform.rotateBox(
//           angle: pi / 2,
//           child: pw.Text('Prices'),
//         ),
//       ),
//       overlay: pw.ChartLegend(
//         position: const pw.Alignment(-.7, 1),
//         decoration: pw.BoxDecoration(
//           color: PdfColors.white,
//           border: pw.Border.all(
//             color: PdfColors.black,
//             width: .5,
//           ),
//         ),
//       ),
//       grid: pw.CartesianGrid(
//         xAxis: pw.FixedAxis.fromStrings(
//           List<String>.generate(
//               dataTable1.length, (index) => dataTable1[index][0] as String),
//           marginStart: 30,
//           marginEnd: 30,
//           ticks: true,
//         ),
//         yAxis: pw.FixedAxis(
//           [
//             0,
//             100000,
//             200000,
//             300000,
//             400000,
//             500000,
//             600000,
//             700000,
//             800000,
//             900000,
//             1000000
//           ],
//           format: (v) => '$v',
//           divisions: true,
//         ),
//       ),
//       datasets: [
//         pw.BarDataSet(
//           color: PdfColors.blue100,
//           legend: 'Cost Price',
//           width: 15,
//           offset: -10,
//           borderColor: baseColor,
//           data: List<pw.PointChartValue>.generate(
//             dataTable1.length,
//             (i) {
//               final v = dataTable1[i][1] as num;
//               return pw.PointChartValue(i.toDouble(), v.toDouble());
//             },
//           ),
//         ),
//         pw.BarDataSet(
//           color: PdfColors.amber100,
//           legend: 'Selling Price',
//           width: 15,
//           offset: 10,
//           borderColor: PdfColors.amber,
//           data: List<pw.PointChartValue>.generate(
//             dataTable1.length,
//             (i) {
//               final v = dataTable1[i][2] as num;
//               return pw.PointChartValue(i.toDouble(), v.toDouble());
//             },
//           ),
//         ),
//       ],
//     );

//     // Product Analysis Page
//     document.addPage(
//       pw.Page(
//         pageFormat: pageFormat,
//         theme: theme,
//         build: (context) {
//           // Page layout
//           return pw.Column(
//             children: [
//               pw.Text('Products Analysis',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 40,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.Divider(thickness: 4),
//               pw.SizedBox(height: 10),
//               pw.Text('Top 5 Costly Products',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.SizedBox(height: 175, child: table1),
//               pw.SizedBox(height: 10),
//               pw.Divider(thickness: 2),
//               pw.SizedBox(height: 10),
//               pw.Text('Graphical Representation',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.Expanded(flex: 2, child: chart1),
//             ],
//           );
//         },
//       ),
//     );

//     await DB.openCon('productsales');
//     List<Map<String, dynamic>> data2 = await DB.collection.find().toList();
//     await DB.closeCon();

//     List<List<dynamic>> dataTable2 = [];
//     for (int i = 0; i < data1.length; i++) {
//       List<dynamic> temp = [];
//       temp.add(data1[i]['ProductName']);
//       temp.add(0);
//       temp.add(0);
//       dataTable2.add(temp);
//     }

//     for (int i = 0; i < dataTable2.length; i++) {
//       for (int j = 0; j < data2.length; j++) {
//         if (dataTable2[i][0] == data2[j]['ProductName']) {
//           dataTable2[i][1] += int.parse(data2[j]['Quantity']);
//           dataTable2[i][2] += int.parse(data2[j]['Price']);
//         }
//       }
//     }

//     dataTable2.sort((a, b) => b[1].compareTo(a[1]));
//     dataTable2.removeRange(5, dataTable2.length);

//     // Top 5 Products Table
//     final table2 = pw.Table.fromTextArray(
//       border: pw.TableBorder.all(width: 1),
//       headers: ['Product Name', 'Quantity', 'Price'],
//       data: List<List<dynamic>>.generate(
//         dataTable2.length,
//         (index) => <dynamic>[
//           dataTable2[index][0],
//           dataTable2[index][1],
//           dataTable2[index][2],
//         ],
//       ),
//       headerStyle: pw.TextStyle(
//         color: PdfColors.white,
//         fontWeight: pw.FontWeight.bold,
//       ),
//       headerDecoration: const pw.BoxDecoration(
//         color: baseColor,
//       ),
//       rowDecoration: const pw.BoxDecoration(
//         border: pw.Border(
//           bottom: pw.BorderSide(
//             color: baseColor,
//             width: .5,
//           ),
//         ),
//       ),
//       cellAlignment: pw.Alignment.center,
//       cellAlignments: {0: pw.Alignment.center},
//     );

//     // Top 5 Products Chart
//     final chart2 = pw.Chart(
//       left: pw.Container(
//         alignment: pw.Alignment.topCenter,
//         margin: const pw.EdgeInsets.only(right: 5, top: 150),
//         child: pw.Transform.rotateBox(
//           angle: pi / 2,
//           child: pw.Text('Quantity'),
//         ),
//       ),
//       overlay: pw.ChartLegend(
//         position: const pw.Alignment(-.7, 1),
//         decoration: pw.BoxDecoration(
//           color: PdfColors.white,
//           border: pw.Border.all(
//             color: PdfColors.black,
//             width: .5,
//           ),
//         ),
//       ),
//       grid: pw.CartesianGrid(
//         xAxis: pw.FixedAxis.fromStrings(
//           List<String>.generate(
//               dataTable1.length, (index) => dataTable2[index][0] as String),
//           marginStart: 30,
//           marginEnd: 30,
//           ticks: true,
//         ),
//         yAxis: pw.FixedAxis(
//           [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
//           format: (v) => '$v',
//           divisions: true,
//         ),
//       ),
//       datasets: [
//         pw.BarDataSet(
//           color: PdfColors.blue100,
//           legend: 'Quantity',
//           width: 30,
//           borderColor: baseColor,
//           data: List<pw.PointChartValue>.generate(
//             dataTable1.length,
//             (i) {
//               final v = dataTable2[i][1] as num;
//               return pw.PointChartValue(i.toDouble(), v.toDouble());
//             },
//           ),
//         ),
//       ],
//     );

//     // Product Sales Page
//     document.addPage(
//       pw.Page(
//         pageFormat: pageFormat,
//         theme: theme,
//         build: (context) {
//           // Page layout
//           return pw.Column(
//             children: [
//               pw.Text('Products Sales (Quantity)',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 38,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.Divider(thickness: 4),
//               pw.SizedBox(height: 10),
//               pw.Text('Top 5 Best Sellers',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.SizedBox(height: 175, child: table2),
//               pw.SizedBox(height: 10),
//               pw.Divider(thickness: 2),
//               pw.SizedBox(height: 10),
//               pw.Text('Graphical Representation',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.Expanded(flex: 2, child: chart2),
//             ],
//           );
//         },
//       ),
//     );

//     List<List<dynamic>> dataTable3 = [];
//     dynamic totalProfit = 0;
//     for (int i = 0; i < data1.length; i++) {
//       List<dynamic> temp = [];
//       temp.add(data1[i]['ProductName']);
//       temp.add(data1[i]['CostPrice']);
//       temp.add(data1[i]['SellingPrice']);
//       temp.add(0);
//       temp.add(0);
//       temp.add(0);
//       dataTable3.add(temp);
//     }

//     for (int i = 0; i < dataTable3.length; i++) {
//       for (int j = 0; j < data2.length; j++) {
//         if (dataTable3[i][0] == data2[j]['ProductName']) {
//           dataTable3[i][3] += int.parse(data2[j]['Quantity']);
//           dataTable3[i][4] += int.parse(data2[j]['Price']);
//           dataTable3[i][5] += int.parse(data2[j]['Price']) - dataTable3[i][1];
//         }
//       }
//     }

//     for (int i = 0; i < dataTable3.length; i++) {
//       totalProfit += dataTable3[i][5];
//     }

//     dynamic op = 0, oq = 0;
//     dataTable3.sort((a, b) => b[5].compareTo(a[5]));
//     for (int i = 5; i < dataTable3.length; i++) {
//       op += dataTable3[i][2];
//     }
//     dataTable3.removeRange(5, dataTable3.length);

//     // Top 5 Products Table
//     final table3 = pw.Table.fromTextArray(
//       border: pw.TableBorder.all(width: 1),
//       headers: [
//         'Product Name',
//         'CostPrice',
//         'SellingPrice',
//         'Quantity',
//         'Price',
//         'Profit'
//       ],
//       data: List<List<dynamic>>.generate(
//         dataTable3.length,
//         (index) => <dynamic>[
//           dataTable3[index][0],
//           dataTable3[index][1],
//           dataTable3[index][2],
//           dataTable3[index][3],
//           dataTable3[index][4],
//           dataTable3[index][5],
//         ],
//       ),
//       headerStyle: pw.TextStyle(
//         color: PdfColors.white,
//         fontWeight: pw.FontWeight.bold,
//       ),
//       headerDecoration: const pw.BoxDecoration(
//         color: baseColor,
//       ),
//       rowDecoration: const pw.BoxDecoration(
//         border: pw.Border(
//           bottom: pw.BorderSide(
//             color: baseColor,
//             width: .5,
//           ),
//         ),
//       ),
//       cellAlignment: pw.Alignment.center,
//       cellAlignments: {0: pw.Alignment.center},
//     );

//     // Top 5 Products Chart
//     final chart3 = pw.Chart(
//       left: pw.Container(
//         alignment: pw.Alignment.topCenter,
//         margin: const pw.EdgeInsets.only(right: 5, top: 150),
//         child: pw.Transform.rotateBox(
//           angle: pi / 2,
//           child: pw.Text('Prices'),
//         ),
//       ),
//       overlay: pw.ChartLegend(
//         position: const pw.Alignment(-.7, 1),
//         decoration: pw.BoxDecoration(
//           color: PdfColors.white,
//           border: pw.Border.all(
//             color: PdfColors.black,
//             width: .5,
//           ),
//         ),
//       ),
//       grid: pw.CartesianGrid(
//         xAxis: pw.FixedAxis.fromStrings(
//           List<String>.generate(
//               dataTable1.length, (index) => dataTable2[index][0] as String),
//           marginStart: 30,
//           marginEnd: 30,
//           ticks: true,
//         ),
//         yAxis: pw.FixedAxis(
//           [
//             0,
//             2000000,
//             4000000,
//             6000000,
//             8000000,
//             10000000,
//             12000000,
//             14000000,
//             16000000,
//             18000000,
//             20000000
//           ],
//           format: (v) => '$v',
//           divisions: true,
//         ),
//       ),
//       datasets: [
//         pw.BarDataSet(
//           color: PdfColors.blue100,
//           legend: 'Revenue',
//           width: 15,
//           offset: -10,
//           borderColor: baseColor,
//           data: List<pw.PointChartValue>.generate(
//             dataTable1.length,
//             (i) {
//               final v = dataTable3[i][4] as num;
//               return pw.PointChartValue(i.toDouble(), v.toDouble());
//             },
//           ),
//         ),
//         pw.BarDataSet(
//           color: PdfColors.amber100,
//           legend: 'Profit',
//           width: 15,
//           offset: 10,
//           borderColor: PdfColors.amber,
//           data: List<pw.PointChartValue>.generate(
//             dataTable1.length,
//             (i) {
//               final v = dataTable3[i][5] as num;
//               return pw.PointChartValue(i.toDouble(), v.toDouble());
//             },
//           ),
//         ),
//       ],
//     );

//     // Pie Chart
//     dataTable3.add(['Others', '', '', '', '', op]);
//     const chartColors = [
//       PdfColors.red300,
//       PdfColors.blue300,
//       PdfColors.green300,
//       PdfColors.amber300,
//       PdfColors.pink300,
//       PdfColors.cyan300,
//       PdfColors.purple300,
//       PdfColors.lime300,
//       PdfColors.yellow300,
//       PdfColors.pink300,
//     ];
//     final pie3 = pw.Flexible(
//       child: pw.Chart(
//         grid: pw.PieGrid(),
//         datasets: List<pw.Dataset>.generate(dataTable3.length, (index) {
//           final data = dataTable3[index];
//           final color = chartColors[index % chartColors.length];
//           final value = (data[5] as num).toDouble();
//           final pct = ((value / totalProfit) * 100).floor();
//           return pw.PieDataSet(
//             legend: '${data[0]}\n$pct%',
//             value: value,
//             color: color,
//             legendStyle: const pw.TextStyle(fontSize: 10),
//           );
//         }),
//       ),
//     );

//     // Product Sales Page
//     document.addPage(
//       pw.Page(
//         pageFormat: pageFormat,
//         theme: theme,
//         build: (context) {
//           // Page layout
//           return pw.Column(
//             children: [
//               pw.Text('Products Sales (Profit)',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 40,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.Divider(thickness: 4),
//               pw.SizedBox(height: 10),
//               pw.Text('Top 5 Best Sellers',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.SizedBox(height: 175, child: table3),
//               pw.SizedBox(height: 10),
//               pw.Divider(thickness: 2),
//               pw.SizedBox(height: 10),
//               pw.Text('Graphical Representation',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.Expanded(flex: 2, child: chart3),
//             ],
//           );
//         },
//       ),
//     );

//     // Product Sales Page
//     document.addPage(
//       pw.Page(
//         pageFormat: pageFormat,
//         theme: theme,
//         build: (context) {
//           // Page layout
//           return pw.Column(
//             children: [
//               pw.Text('Pie Chart Representation ',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.SizedBox(child: pie3),
//               pw.SizedBox(height: 10)
//             ],
//           );
//         },
//       ),
//     );

//     await DB.openCon('branch');
//     List<Map<String, dynamic>> branch = await DB.collection.find().toList();
//     await DB.closeCon();
//     await DB.openCon('sales');
//     List<Map<String, dynamic>> data4 = await DB.collection.find().toList();
//     await DB.closeCon();
//     List<List<dynamic>> dataTable4 = [];
//     totalProfit = 0;
//     for (int i = 0; i < branch.length; i++) {
//       List<dynamic> temp = [];
//       temp.add(branch[i]['BranchName'].toString().replaceAll(' Branch', ''));
//       temp.add(0);
//       temp.add(0);
//       dataTable4.add(temp);
//     }

//     for (int i = 0; i < dataTable4.length; i++) {
//       for (int j = 0; j < data4.length; j++) {
//         if (dataTable4[i][0] ==
//             data4[j]['BranchName'].toString().replaceAll(' Branch', '')) {
//           dataTable4[i][1] += data4[j]['TotalQuantity'];
//           dataTable4[i][2] += data4[j]['TotalPrice'];
//         }
//       }
//     }

//     for (int i = 0; i < dataTable4.length; i++) {
//       totalProfit += dataTable4[i][2];
//     }

//     op = 0;
//     oq = 0;
//     dataTable4.sort((a, b) => b[2].compareTo(a[2]));
//     for (int i = 5; i < dataTable4.length; i++) {
//       op += dataTable4[i][2];
//       oq += dataTable4[i][1];
//     }
//     dataTable4.removeRange(5, dataTable4.length);

//     // Top 5 Products Table
//     final table4 = pw.Table.fromTextArray(
//       border: pw.TableBorder.all(width: 1),
//       headers: [
//         'Branch Name',
//         'Quantity',
//         'Revenue',
//       ],
//       data: List<List<dynamic>>.generate(
//         dataTable4.length,
//         (index) => <dynamic>[
//           dataTable4[index][0],
//           dataTable4[index][1],
//           dataTable4[index][2],
//         ],
//       ),
//       headerStyle: pw.TextStyle(
//         color: PdfColors.white,
//         fontWeight: pw.FontWeight.bold,
//       ),
//       headerDecoration: const pw.BoxDecoration(
//         color: baseColor,
//       ),
//       rowDecoration: const pw.BoxDecoration(
//         border: pw.Border(
//           bottom: pw.BorderSide(
//             color: baseColor,
//             width: .5,
//           ),
//         ),
//       ),
//       cellAlignment: pw.Alignment.center,
//       cellAlignments: {0: pw.Alignment.center},
//     );

//     // Top 5 Products Chart
//     final chart4 = pw.Chart(
//       left: pw.Container(
//         alignment: pw.Alignment.topCenter,
//         margin: const pw.EdgeInsets.only(right: 5, top: 150),
//         child: pw.Transform.rotateBox(
//           angle: pi / 2,
//           child: pw.Text('Revenue'),
//         ),
//       ),
//       overlay: pw.ChartLegend(
//         position: const pw.Alignment(-.7, 1),
//         decoration: pw.BoxDecoration(
//           color: PdfColors.white,
//           border: pw.Border.all(
//             color: PdfColors.black,
//             width: .5,
//           ),
//         ),
//       ),
//       grid: pw.CartesianGrid(
//         xAxis: pw.FixedAxis.fromStrings(
//           List<String>.generate(
//               dataTable4.length, (index) => dataTable4[index][0] as String),
//           marginStart: 30,
//           marginEnd: 30,
//           ticks: true,
//         ),
//         yAxis: pw.FixedAxis(
//           [
//             0,
//             2000000,
//             4000000,
//             6000000,
//             8000000,
//             10000000,
//             12000000,
//             14000000,
//             16000000,
//             18000000,
//             20000000
//           ],
//           format: (v) => '$v',
//           divisions: true,
//         ),
//       ),
//       datasets: [
//         pw.BarDataSet(
//           color: PdfColors.blue100,
//           legend: 'Revenue',
//           width: 30,
//           borderColor: baseColor,
//           data: List<pw.PointChartValue>.generate(
//             dataTable4.length,
//             (i) {
//               final v = dataTable4[i][2] as num;
//               return pw.PointChartValue(i.toDouble(), v.toDouble());
//             },
//           ),
//         ),
//       ],
//     );

//     // Pie Chart
//     dataTable4.add(['Others', oq, op]);
//     final pie4 = pw.Flexible(
//       child: pw.Chart(
//         grid: pw.PieGrid(),
//         datasets: List<pw.Dataset>.generate(dataTable4.length, (index) {
//           final data = dataTable4[index];
//           final color = chartColors[index % chartColors.length];
//           final value = (data[2] as num).toDouble();
//           final pct = ((value / totalProfit) * 100).floor();
//           return pw.PieDataSet(
//             legend: '${data[0]}\n$pct%',
//             value: value,
//             color: color,
//             legendStyle: const pw.TextStyle(fontSize: 10),
//           );
//         }),
//       ),
//     );

//     // Product Sales Page
//     document.addPage(
//       pw.Page(
//         pageFormat: pageFormat,
//         theme: theme,
//         build: (context) {
//           // Page layout
//           return pw.Column(
//             children: [
//               pw.Text('Branch Revenue',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 40,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.Divider(thickness: 4),
//               pw.SizedBox(height: 10),
//               pw.Text('Top 5 Best Sellers',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.SizedBox(height: 175, child: table4),
//               pw.SizedBox(height: 10),
//               pw.Divider(thickness: 2),
//               pw.SizedBox(height: 10),
//               pw.Text('Graphical Representation',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.Expanded(flex: 2, child: chart4),
//             ],
//           );
//         },
//       ),
//     );

//     // Product Sales Page
//     document.addPage(
//       pw.Page(
//         pageFormat: pageFormat,
//         theme: theme,
//         build: (context) {
//           // Page layout
//           return pw.Column(
//             children: [
//               pw.Text('Pie Chart Representation ',
//                   style: pw.TextStyle(
//                     color: PdfColors.yellow900,
//                     fontWeight: pw.FontWeight.bold,
//                     fontSize: 20,
//                   )),
//               pw.SizedBox(height: 10),
//               pw.SizedBox(child: pie4),
//               pw.SizedBox(height: 10)
//             ],
//           );
//         },
//       ),
//     );

//     // Saves File in Dowloads Folder
//     File file = File(
//         "C:\\Users\\${Platform.environment['USERNAME']}\\Downloads\\SalesReport.pdf");
//     file.writeAsBytesSync(await document.save());
//   }
// }
