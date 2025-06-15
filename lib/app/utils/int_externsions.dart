extension IntExternsions on int {
  String countDownDuration() {
    Duration duration = Duration(seconds: this);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String secs = twoDigits(duration.inSeconds.remainder(60));

    return secs;
  }
}
