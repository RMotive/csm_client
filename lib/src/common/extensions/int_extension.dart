extension IntDuration on int {
  Duration get seconds => Duration(seconds: this);
  Duration get miliseconds => Duration(milliseconds: this);
}
