formatDuration(Duration d) {
  // var formatted = d.toString().split('.').first.padLeft(8, "0");
  var seconds = d.inSeconds;
  final days = seconds ~/ Duration.secondsPerDay;
  seconds -= days * Duration.secondsPerDay;
  final hours = seconds ~/ Duration.secondsPerHour;
  seconds -= hours * Duration.secondsPerHour;
  final minutes = seconds ~/ Duration.secondsPerMinute;
  seconds -= minutes * Duration.secondsPerMinute;

  var formatted =
      '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  if (hours > 0) {
    formatted = '${hours.toString().padLeft(2, "0")}:' + formatted;
  }
  return formatted;
}
