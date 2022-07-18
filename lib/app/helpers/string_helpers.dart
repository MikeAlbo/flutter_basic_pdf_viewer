String trimFileTitle({required String title, int len = 30, String? suffix}) {
  return title.length < len
      ? title
      : title.replaceRange(len, title.length, "...${suffix ?? ""}");
}

extension TrimText on String {
  String trimText({int len = 30, String? suffix}) {
    return length < len
        ? this
        : replaceRange(len, length, "...${suffix ?? ''}");
  }
}
