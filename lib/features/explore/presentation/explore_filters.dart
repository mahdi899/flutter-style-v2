import 'package:flutter/material.dart';

enum ExploreFilterType { color, category, season, trend }

extension ExploreFilterTypeX on ExploreFilterType {
  String get key {
    switch (this) {
      case ExploreFilterType.color:
        return 'color';
      case ExploreFilterType.category:
        return 'category';
      case ExploreFilterType.season:
        return 'season';
      case ExploreFilterType.trend:
        return 'trend';
    }
  }

  String get label {
    switch (this) {
      case ExploreFilterType.color:
        return 'رنگ';
      case ExploreFilterType.category:
        return 'نوع';
      case ExploreFilterType.season:
        return 'فصل';
      case ExploreFilterType.trend:
        return 'ترند';
    }
  }
}

class ExploreFilterOptions {
  const ExploreFilterOptions._();

  static const Map<ExploreFilterType, List<String>> values = <ExploreFilterType, List<String>>{
    ExploreFilterType.color: <String>['آبی', 'کرم', 'طوسی', 'سبز', 'قرمز', 'مشکی', 'صورتی', 'زیتونی'],
    ExploreFilterType.category: <String>['کژوال', 'مینیمال', 'رسمی', 'استریت', 'ورزشی', 'بوهو'],
    ExploreFilterType.season: <String>['چهار فصل', 'بهار', 'تابستان', 'پاییز', 'زمستان'],
    ExploreFilterType.trend: <String>['محبوب', 'ترند روز', 'پیشنهاد استایلیست', 'مینیمال‌های نو'],
  };

  static const Map<String, Color> colorPalette = <String, Color>{
    'آبی': Color(0xFF3B82F6),
    'کرم': Color(0xFFEED6A2),
    'طوسی': Color(0xFF94A3B8),
    'سبز': Color(0xFF34D399),
    'قرمز': Color(0xFFEF4444),
    'مشکی': Color(0xFF1F2937),
    'صورتی': Color(0xFFF472B6),
    'زیتونی': Color(0xFF8B9A46),
  };
}
