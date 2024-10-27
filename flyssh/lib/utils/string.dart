String pluralize(num count, String singular, [String? plural]) {
  plural ??= '${singular}s'; // Default plural adds 's' if not provided
  return count == 1 ? singular : plural;
}
