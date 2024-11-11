import 'dart:typed_data';
import 'package:cogina_restaurants/core/translations/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../../core/helpers/date_formatter.dart';
import '../../../../../../core/routing/navigation_services.dart';
import '../../../../../../core/utils/contact_helper.dart';
import '../../../../../../core/utils/globals.dart';
import '../../../../../../data/model/response/orders_model.dart';
import '../../account/edit_profile/profile_cubit.dart';

void generateAndClientInvoicePrint({required OrdersModelData ordersModelData}) async {
  final pdf = pw.Document();
  final ByteData bytes = await rootBundle.load('assets/images/logo.png');
  final Uint8List byteList = bytes.buffer.asUint8List();
  final ttf = await fontFromAssetBundle('assets/fonts/Cairo-Black.ttf');
  ProfileCubit profileCubit =
  ProfileCubit.get(NavigationService.navigationKey.currentContext!);
  final restaurantName = profileCubit.profileModel?.store?.name ?? '';
  pdf.addPage(
    pw.Page(
      textDirection: kLanguage == 'en' ? pw.TextDirection.ltr : pw.TextDirection.rtl,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
                children: [
                  pw.Center(
                    child: pw.Image(
                      pw.MemoryImage(byteList),
                      width: 90,
                      height: 90,
                    ),
                  ),
                  pw.SizedBox(width: 16.w),
                  pw.Text(
                    restaurantName,
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold, font: ttf),
                  ),
                  pw.Spacer(),
                  pw.Column(
                    children: [
                      pw.Text(
                        '${ordersModelData.client?.name ?? ''}',
                        style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.normal,
                            font: ttf),
                      ),
                      pw.Text(
                        '${ordersModelData.client?.address ?? ''}',
                        style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.normal,
                            font: ttf),
                      ),
                      pw.Text(
                        '${ordersModelData.client?.addressNot ?? ''}',
                        style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.normal,
                            font: ttf),
                      ),
                      pw.Text(
                        '${LocaleKeys.phone.tr()} : ${ordersModelData.client?.phone ?? ''}',
                        style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.normal,
                            font: ttf),
                      ),
                    ],
                  ),
                ]),
            pw.SizedBox(height: 10),
            pw.Text('${LocaleKeys.orderNo.tr()} : ${ordersModelData.id ?? ''}',
                style: pw.TextStyle(fontSize: 13, font: ttf)),
            pw.Text(
                '${LocaleKeys.orderDate.tr()} ${ordersModelData.date ?? ''}',
                style: pw.TextStyle(fontSize: 13, font: ttf)),

            pw.SizedBox(height: 16),
            pw.Table.fromTextArray(
              headers: [
                '${LocaleKeys.productName.tr()}',
                '${LocaleKeys.qty.tr()}',
                '${LocaleKeys.size.tr()}',
                '${LocaleKeys.price.tr()}',
                '${LocaleKeys.total.tr()}'
              ],
              data: ordersModelData.details?.data?.map((item) {
                final totalItemPrice =
                    double.parse(item.qty?.toString() ?? '0') *
                        double.parse(item.productPrice ?? '0');
                return [
                  item.productName ?? '',
                  item.qty?.toString() ?? '',
                  item.size?.name ?? '${LocaleKeys.constSize.tr()}',
                  '${item.productPrice ?? ''} ${LocaleKeys.currency.tr()}',
                  '${totalItemPrice ?? ''} ${LocaleKeys.currency.tr()}',
                ];
              }).toList() ??
                  [],
              border: pw.TableBorder.all(),
              headerStyle:
              pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
              cellAlignment: pw.Alignment.center,
              headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 40,
              cellStyle:
              pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
            ),
            pw.SizedBox(height: 16),
            pw.Row(
              mainAxisAlignment: kLanguage == 'en' ? pw.MainAxisAlignment.end: pw.MainAxisAlignment.start,


              children: [
                pw.Text(
                  '${LocaleKeys.subtotal.tr()} : ',
                  style: pw.TextStyle(
                      fontSize: 15, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
                pw.Text(
                  '${ordersModelData.orderPrice.toString() ?? ''} ${LocaleKeys.currency.tr()}',
                  style: pw.TextStyle(
                      fontSize: 15, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: kLanguage == 'en' ? pw.MainAxisAlignment.end: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  '${LocaleKeys.discount.tr()} : ',
                  style: pw.TextStyle(
                      fontSize: 15, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
                pw.Text(
                  '${ordersModelData.discout.toString() ?? ''} ${LocaleKeys.currency.tr()}',
                  style: pw.TextStyle(
                      fontSize: 15, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: kLanguage == 'en' ? pw.MainAxisAlignment.end: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  '${LocaleKeys.shipping.tr()} : ',
                  style: pw.TextStyle(
                      fontSize: 15, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
                pw.Text(
                  '${ordersModelData.deliveryFees.toString() ?? ''} ${LocaleKeys.currency.tr()}',
                  style: pw.TextStyle(
                      fontSize: 15, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
              ],
            ),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: kLanguage == 'en' ? pw.MainAxisAlignment.end: pw.MainAxisAlignment.start,
              children: [
                pw.Container(
                  width: 220,
                  child: pw.Divider(
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                  ),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: kLanguage == 'en' ? pw.MainAxisAlignment.end: pw.MainAxisAlignment.start,
              children: [
                pw.Text(
                  '${LocaleKeys.total.tr()} : ',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
                pw.Text(
                  '${ordersModelData.orderTotal.toString() ?? ''} ${LocaleKeys.currency.tr()}',
                  style: pw.TextStyle(
                      fontSize: 16, fontWeight: pw.FontWeight.bold, font: ttf),
                ),
              ],
            ),
            pw.SizedBox(height: 30),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  '${ordersModelData.paymentMethod??''}',
                  style: pw.TextStyle(
                      fontSize: 11, fontWeight: pw.FontWeight.normal, font: ttf),
                ),
                pw.Text(
                  '${DateFormatter.currentTime().toString()}',
                  style: pw.TextStyle(
                      fontSize: 11, fontWeight: pw.FontWeight.normal, font: ttf),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
