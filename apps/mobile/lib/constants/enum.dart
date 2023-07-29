enum Gender {
  male,
  female,
}

String convertCategory(String value) {
  switch (value) {
    case 'Grosir':
      return 'wholesale';
    case 'Material':
      return 'material';
    case 'Manufaktur':
      return 'manufacture';
    case 'Kuliner':
      return 'food_and_beverage';
    case 'Jasa':
      return 'business_service';
    case 'Perangkat keras':
      return 'hardware';
    default:
      return 'others';
  }
}
