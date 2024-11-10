import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

extension ExtensionList<T> on List<T>? {
  List<T> intersperse(T item) {
    if (this == null) return [];

    final result = <T>[];
    int index = 0;
    while (index < this!.length) {
      if (index > 0) {
        result.add(item);
      }
      result.add(this![index]);
      index++;
    }
    return result;
  }

  T? firstOrNullWhere(bool Function(T) test, {T Function()? orElse}) {
    if (this == null) return null;
    try {
      return this!.firstWhere(test, orElse: orElse);
    } catch (e) {}
    return null;
  }
}

extension IntExtension on int {
  String formatAmount([bool isDot = false]) {
    final format = NumberFormat.decimalPattern();
    String res = format.format(this);
    if (isDot) {
      res = res.replaceAll(",", ".");
    }
    return res;
  }
}

extension DoubleRound on double {
  double roundNumber({int? fractionDigits = 6}) {
    return double.parse(toStringAsFixed(fractionDigits!));
  }
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var result = <T>[];
    forEach((element) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element))) {
        result.add(element);
      }
    });
    return result;
  }
}

extension TextExtensions on Text {
  Text copyWith(
      {StrutStyle? strutStyle,
      TextAlign? textAlign,
      Locale? locale,
      bool? softWrap,
      TextOverflow? overflow,
      TextScaler? textScaler,
      int? maxLines,
      String? semanticsLabel,
      TextWidthBasis? textWidthBasis,
      TextStyle? style}) {
    return Text(data ?? "",
        key: key,
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection,
        locale: locale ?? this.locale,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        textScaler: textScaler ?? this.textScaler,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
        style: style != null ? this.style?.merge(style) ?? style : this.style);
  }

  Text get bold => copyWith(style: (style ?? const TextStyle()).bold);
  Text setColor(Color color) =>
      copyWith(style: (style ?? const TextStyle()).setColor(color));
  Text setFontSize(double size) =>
      copyWith(style: (style ?? const TextStyle()).setFontSize(size));
}

extension NumExtensions on num? {
  String formatPercent({int fractionDigits = 0, bool round = false}) {
    if (this == null) return "0%";

    num value = this! * 100;
    if (round) {
      value = value.round();
    }
    return "${value.toStringAsFixed(fractionDigits)}%";
  }

  String formatNumber() {
    if (this == null) return "0";
    try {
      return NumberFormat("#,###").format(this!.toInt());
    } catch (e) {}
    return "0";
  }

  String formatCurrency([String unit = "đ"]) {
    var res = "0";
    if (this != null) {
      try {
        res = NumberFormat("#,###").format(this!.toInt());
      } catch (e) {}
    }

    return "$res$unit";
  }
}

extension StringExtensions on String? {
  bool isEmptyOrNull() => this == null || this!.isEmpty;
  bool isNotEmptyAndNull() => this != null && this!.isNotEmpty;
  void addPrefix(String prefix) {
    print('$prefix $this');
  }

  String get getCharNumber {
    return this?.replaceAll(RegExp(r'[.,]'), '') ?? "";
  }

  int toInt() => int.tryParse(this?.replaceAll(RegExp(r'[.,]'), '') ?? '') ?? 0;

  double toDouble() => double.tryParse(this ?? '') ?? 0;

  DateTime? toDateTime([String? newPattern, String? locale]) {
    if (this == null) return null;
    try {
      return DateFormat(newPattern, locale).parse(this!);
    } catch (e) {}
    return null;
  }

  int compareName(String? value) {
    String a = (this ?? "").toLowerCase();
    String b = (value ?? "").toLowerCase();
    // if (Get.locale?.countryCode != "VN") {
    //   return a.compareTo(b);
    // }

    const vietnameseAlphabet =
        'aàảãáạăằẳẵắặbcdđeèẻẽéẹêềểễếệghiìỉĩíịklmnoòỏõóọôồổỗốộơờởỡớợpqrstuùủũúụưừửữứựvxyỳỷỹýỵ';
    int indexA = vietnameseAlphabet.indexOf(a[0]);
    int indexB = vietnameseAlphabet.indexOf(b[0]);
    if (indexA == -1 || indexB == -1) {
      // Nếu có từ không có trong bảng chữ cái tiếng Việt, sử dụng so sánh thông thường
      return a.compareTo(b);
    } else {
      return indexA.compareTo(indexB);
    }
  }

  bool isValidUrl() {
    if (isEmptyOrNull()) {
      return false;
    }
    const pattern =
        r'^(?:http|https):\/\/(?:[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*\.)+[a-zA-Z]{2,}(?::[0-9]+)?(?:\/\S*)?$';
    final regex = RegExp(pattern, caseSensitive: false);
    return regex.hasMatch(this!);
  }

  bool containEmoji() {
    if (isEmptyOrNull()) {
      return false;
    }
    return this!.contains(RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'));
  }

  bool isValidEmail() {
    if (isEmptyOrNull()) {
      return false;
    }
    // Regular expression pattern to check email format
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(this!);
  }

  bool isValidPassword() {
    if (isEmptyOrNull()) {
      return false;
    }
    return RegExp(
            r'.{8,}') //"(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9\$&+,:;=?@#|'<>.^*()%!-]{8,20}\$"
        .hasMatch(this!);
  }

  String removeUTF8Character() {
    if (isEmptyOrNull()) {
      return "";
    }
    var newKeyword =
        this!.toLowerCase().replaceAll(RegExp(r'[eèéêếẹẻẽềềểễệ]'), 'e');
    newKeyword = newKeyword.replaceAll(RegExp(r'[aáàảâãăạảấầẩẫậắằẳẵặ]'), 'a');
    newKeyword = newKeyword.replaceAll(RegExp(r'[uùúũưụủứừửữự]'), 'u');
    newKeyword = newKeyword.replaceAll(RegExp(r'[oòóôõọỏốồổỗộớờởỡợơ]'), 'o');
    newKeyword = newKeyword.replaceAll(RegExp(r'[iìíĩịỉ]'), 'i');
    newKeyword = newKeyword.replaceAll(RegExp(r'[yýỳỷỹỵ]'), 'y');
    newKeyword = newKeyword.replaceAll(RegExp(r'[dđ]'), 'd');
    return "$newKeyword";
  }

  String removeDiacritics() {
    if (isEmptyOrNull()) {
      return "";
    }
    const diacriticChars =
        'àáảãạăắằẳẵặâấầẩẫậèéẻẽẹêếềểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựỳýỷỹỵđÀÁẢÃẠĂẮẰẲẴẶÂẤẦẨẪẬÈÉẺẼẸÊẾỀỂỄỆÌÍỈĨỊÒÓỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÙÚỦŨỤƯỨỪỬỮỰỲÝỶỸỴĐ';
    const nonDiacriticChars =
        'aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyydAAAAAAAAAAAAAAAAAEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYD';
    final buffer = StringBuffer();

    for (var i = 0; i < this!.length; i++) {
      final char = this![i];
      final index = diacriticChars.indexOf(char);

      if (index >= 0) {
        buffer.write(nonDiacriticChars[index]);
      } else {
        buffer.write(char);
      }
    }

    return buffer.toString();
  }

  bool isValidNotEmptyTextField() {
    if (isEmptyOrNull()) {
      return false;
    }
    return this!.trim().isNotEmpty;
  }

  bool isValidPhone() {
    if (isEmptyOrNull()) {
      return false;
    }
    var status = this!.isValidNotEmptyTextField();
    return status;
  }

  DateTime? get convertISO8601 =>
      isEmptyOrNull() ? null : DateTime.parse(this!).toLocal();

  String get getFileExtension {
    if (isEmptyOrNull()) {
      return "";
    }
    final Uri uri = Uri.parse(this!);
    final String path = uri.path;
    if (path.isEmpty) {
      return '';
    }

    final int lastDotIndex = path.lastIndexOf('.');
    if (lastDotIndex == -1) {
      return '';
    }

    return path.substring(lastDotIndex + 1).toLowerCase();
  }

  Widget toImage({required Widget image}) {
    var img = image;
    if (isEmptyOrNull()) {
      return img;
    }
    if (isValidUrl()) {
      return Image.network(
        this!,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child; // Image has loaded
          }
          return Center(
              child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ));
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return img;
        },
      );
    }
    if (this!.startsWith("/assets/")) {
      return Image.asset(this!);
    }
    return img;
  }

  
}

extension TimeOfDayExtension on TimeOfDay {
  bool isAfter(TimeOfDay otherDay) {
    if (hour > otherDay.hour) return true;
    if (hour == otherDay.hour && minute > otherDay.minute) {
      return true;
    }
    return false;
  }
}

extension DateTimeExtension on DateTime {
  DateTime addYear(int number) {
    int newYear = year + number;
    return DateTime(
        newYear, month, day, hour, minute, second, millisecond, microsecond);
  }

  DateTime minusYear(int number) {
    int newYear = year - number;
    return DateTime(
        newYear, month, day, hour, minute, second, millisecond, microsecond);
  }

  bool get isToday {
    final now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }

  bool get isAfterToday {
    final now = DateTime.now();
    if (now.year == year) {
      if (now.month == month) {
        return now.day <= day;
      } else if (now.month < month) {
        return true;
      } else {
        return false;
      }
    } else if (now.year < year) {
      return true;
    } else {
      return false;
    }
  }

  bool get isBeforeToday {
    final now = DateTime.now();
    if (now.year == year) {
      if (now.month == month) {
        return now.day > day;
      } else if (now.month > month) {
        return true;
      } else {
        return false;
      }
    } else if (now.year > year) {
      return true;
    } else {
      return false;
    }
  }

  int compareDate(DateTime date) {
    final compareString = toDateCompareFormat();
    final compareString2 = date.toDateCompareFormat();
    return compareString.compareTo(compareString2);
  }

  bool isSameDay(DateTime dateTime) {
    return dateTime.year == year &&
        dateTime.month == month &&
        dateTime.day == day;
  }

  DateTime getStartOfDate() {
    return DateTime(year, month, day);
  }

  DateTime getEndOfDate() {
    return DateTime(year, month, day, 23, 59, 59);
  }

  DateTime getNextDay() {
    return DateTime(year, month, day).add(const Duration(days: 1));
  }

  DateTime getPreviousDay() {
    return DateTime(year, month, day).add(const Duration(days: -1));
  }

  String toDateCompareFormat() {
    return DateFormat("yyyy-MM-dd").format(this);
  }

  String toDateFormat([String? newPattern, String? locale]) {
    return DateFormat(newPattern, locale).format(this);
  }

  DateTime get lastDayOfMonth =>
      month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);

  DateTime get firstDayOfMonth => DateTime(year, month, 1);

  int get quarter {
    if (month >= 1 && month <= 3) {
      return 1;
    } else if (month >= 4 && month <= 6) {
      return 2;
    } else if (month >= 7 && month <= 9) {
      return 3;
    } else {
      return 4;
    }
  }
}

extension MapExtension<K, V> on Map<K, V> {
  void removeNullEntries() {
    removeWhere((key, value) => key == null || value == null);
  }

  Map<K, V> get nonNullMap {
    return Map.from(this)..removeNullEntries();
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle get italic {
    return copyWith(fontStyle: FontStyle.italic);
  }

  TextStyle get underline {
    return copyWith(decoration: TextDecoration.underline);
  }

  TextStyle get price {
    return bold.copyWith(color: Colors.red);
  }

  TextStyle get white {
    return bold.copyWith(color: Colors.white);
  }

  TextStyle get black {
    return bold.copyWith(color: Colors.black);
  }
  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setFontSize(double size) {
    return copyWith(fontSize: size);
  }
}

extension IconExtension on Icon {
  Widget avatar({double? size, Color? colorIcon}) {
    return Icon(
      icon,
      size: (size ?? 0) > 0 ? (size! * 0.6) : 18,
      color: colorIcon,
    ).circleAvatar(backgroundColor: Colors.grey.shade400, size: size);
  }
}

extension WidgetExtension on Widget {
  Widget circular({double? radius, double? width, double? height}) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        width: width ?? 160,
        height: height ?? 200,
        clipBehavior: Clip.hardEdge, // Add this line
        child: this);
  }

  Widget circleAvatar({double? size, Color? backgroundColor}) {
    return CircleAvatar(
        radius: size ?? 30,
        backgroundColor: backgroundColor ?? Colors.transparent,
        child: this);
  }

  Widget buildbBorderRadius(
      {Color? color, BorderRadiusGeometry? borderRadius}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(12)),
          color: (color ?? Colors.grey).withOpacity(0.2),
        ),
        child: this);
  }

  Widget withRequired(bool isRequired) {
    return !isRequired
        ? this
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: this),
              Text(
                " *",
                style: const TextStyle().copyWith(color: Colors.red),
              )
            ],
          );
  }

  Widget banner({int? count, Color color = Colors.red}) {
    return (count ?? 0) > 0
        ? Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4, top: 4),
                child: this,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  child: Text(
                    "$count",
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                ),
              )
            ],
          )
        : this;
  }

  Widget withTitle(
      {Widget? title,
      String? textTitle,
      Axis direction = Axis.vertical,
      MainAxisSize mainAxisSize = MainAxisSize.max}) {
    if (direction == Axis.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: mainAxisSize,
        children: [
          title ??
              Text(
                textTitle ?? "",
                style: const TextStyle().copyWith(color: Colors.grey),
              ),
          const SizedBox(height: 8),
          this
        ],
      );
    } else {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: mainAxisSize,
          children: [
            title ??
                Text(
                  textTitle ?? "",
                  style: const TextStyle().copyWith(color: Colors.grey),
                ),
            const SizedBox(width: 2),
            this
          ],
        ),
      );
    }
  }

  Widget withIcon({required Widget icon}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [icon, SizedBox(width: 12), this],
    );
  }

  // Widget withName({Widget? title, String? textTitle, MainAxisSize mainAxisSize = MainAxisSize.max}) {
  //   if (textTitle != null && !textTitle.endsWith(":")) {
  //     textTitle += ":";
  //   }
  //   return this.withTitle(title: title, textTitle: textTitle, direction: Axis.horizontal, mainAxisSize: mainAxisSize);
  // }

  Widget withContent(
      {Widget? content,
      String? textContent,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
      TextStyle? style,
      bool haveTwoDots = true}) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Row(
          children: [this, if (haveTwoDots) const Text(": ")],
        ),
        (content != null
            ? Row(
                children: [
                  content,
                ],
              )
            : Text(
                textContent ?? "",
                style: style,
              ))
      ],
    );
  }

  Widget disable([bool disable = true]) {
    return disable
        ? AnimatedOpacity(
            opacity: 0.5,
            duration: const Duration(milliseconds: 500), // Thời gian chuyển đổi
            child: readonly(),
          )
        : this;
  }

  Widget readonly([bool isReadOnly = true]) {
    return isReadOnly ? IgnorePointer(child: this) : this;
  }
}

extension ColorExtension on Color {
  Color get toBlackWhite {
    // Tính toán luminance của màu nền
    double luminance = computeLuminance();

    // Nếu luminance lớn hơn 0.5, chọn màu chữ đen
    // Nếu luminance nhỏ hơn 0.5, chọn màu chữ trắng
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

extension FileExtension on File {
  Future<Uint8List?> compressFile({
    int minWidth = 1920,
    int minHeight = 1080,
    int inSampleSize = 1,
    int quality = 95,
    int rotate = 0,
    bool autoCorrectionAngle = true,
    CompressFormat format = CompressFormat.jpeg,
    bool keepExif = false,
    int numberOfRetries = 5,
  }) async {
    var result = await FlutterImageCompress.compressWithFile(path,
        minWidth: minWidth,
        minHeight: minHeight,
        inSampleSize: inSampleSize,
        quality: quality,
        rotate: rotate,
        autoCorrectionAngle: autoCorrectionAngle,
        format: format,
        keepExif: keepExif,
        numberOfRetries: numberOfRetries);

    return result;
  }
}

const COLOR_DATA_ALPHA = {
  "a": Color.fromRGBO(226, 95, 81, 1),
  "b": Color.fromRGBO(242, 96, 145, 1),
  "c": Color.fromRGBO(187, 101, 202, 1),
  "d": Color.fromRGBO(149, 114, 207, 1),
  "e": Color.fromRGBO(120, 132, 205, 1),
  "f": Color.fromRGBO(91, 149, 249, 1),
  "g": Color.fromRGBO(72, 194, 249, 1),
  "h": Color.fromRGBO(69, 208, 226, 1),
  "i": Color.fromRGBO(38, 166, 154, 1),
  "j": Color.fromRGBO(82, 188, 137, 1),
  "k": Color.fromRGBO(155, 206, 95, 1),
  "l": Color.fromRGBO(212, 227, 74, 1),
  "m": Color.fromRGBO(254, 218, 16, 1),
  "n": Color.fromRGBO(247, 192, 0, 1),
  "o": Color.fromRGBO(255, 168, 0, 1),
  "p": Color.fromRGBO(255, 138, 96, 1),
  "q": Color.fromRGBO(194, 194, 194, 1),
  "r": Color.fromRGBO(143, 164, 175, 1),
  "s": Color.fromRGBO(162, 136, 126, 1),
  "t": Color.fromRGBO(163, 163, 163, 1),
  "u": Color.fromRGBO(175, 181, 226, 1),
  "v": Color.fromRGBO(179, 155, 221, 1),
  "w": Color.fromRGBO(194, 194, 194, 1),
  "x": Color.fromRGBO(124, 222, 235, 1),
  "y": Color.fromRGBO(188, 170, 164, 1),
  "z": Color.fromRGBO(173, 214, 125, 1),
};
