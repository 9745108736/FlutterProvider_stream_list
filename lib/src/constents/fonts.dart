enum MyFonts { FontBold, FontRegular, FontLight, FontMedium }

extension fontExtn on MyFonts {
  String get fontC {
    switch (this) {
      case MyFonts.FontRegular:
        return "SfProRegular";
        break;
      case MyFonts.FontLight:
        return "SfProLight";
        break;
      case MyFonts.FontBold:
        return "SfProBold";
        break;
      case MyFonts.FontMedium:
        return "SfProMedium";
        break;
      default:
        break;
    }
  }
}
