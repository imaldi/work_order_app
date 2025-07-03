bool isPlusCodeCheck(String locationName) {
  final plusCodePattern = RegExp(r'^[23456789CFGHJMPQRVWX]{4,8}\+[23456789CFGHJMPQRVWX]{2,3}$');
  return plusCodePattern.hasMatch(locationName);
}