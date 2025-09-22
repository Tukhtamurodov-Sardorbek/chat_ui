extension DateTimeExt on DateTime {
  String get formatDate {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '$day ${months[month - 1]}, $year';
  }
}

extension NullableDateTimeExt on DateTime? {
  String get formatLastSeen {
    if (this == null) {
      return 'Last seen recently';
    }

    final now = DateTime.now();
    final difference = now.difference(this!);

    if (difference.inMinutes <= 1) {
      return "Last seen just now";
    } else if (difference.inMinutes < 60) {
      return "Last seen ${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago";
    } else if (difference.inHours < 24) {
      final hours = this!.hour.toString().padLeft(2, '0');
      final minutes = this!.minute.toString().padLeft(2, '0');
      return "Last seen at $hours:$minutes";
    } else if (difference.inDays < 7) {
      return "Last seen ${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago";
    } else {
      return "Last seen on ${this!.day.toString().padLeft(2, '0')}/"
          "${this!.month.toString().padLeft(2, '0')}/"
          "${this!.year}";
    }
  }
}
