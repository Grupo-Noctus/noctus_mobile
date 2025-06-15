import 'package:noctus_mobile/core/library/extensions.dart';

enum BrazilianState implements LabeledEnum {
  ac('AC', 'Acre'),
  al('AL', 'Alagoas'),
  ap('AP', 'Amapá'),
  am('AM', 'Amazonas'),
  ba('BA', 'Bahia'),
  ce('CE', 'Ceará'),
  df('DF', 'Distrito Federal'),
  es('ES', 'Espírito Santo'),
  go('GO', 'Goiás'),
  ma('MA', 'Maranhão'),
  mt('MT', 'Mato Grosso'),
  ms('MS', 'Mato Grosso do Sul'),
  mg('MG', 'Minas Gerais'),
  pa('PA', 'Pará'),
  pb('PB', 'Paraíba'),
  pr('PR', 'Paraná'),
  pe('PE', 'Pernambuco'),
  pi('PI', 'Piauí'),
  rj('RJ', 'Rio de Janeiro'),
  rn('RN', 'Rio Grande do Norte'),
  rs('RS', 'Rio Grande do Sul'),
  ro('RO', 'Rondônia'),
  rr('RR', 'Roraima'),
  sc('SC', 'Santa Catarina'),
  sp('SP', 'São Paulo'),
  se('SE', 'Sergipe'),
  to('TO', 'Tocantins');

  final String value;
  final String label;
  const BrazilianState(this.value, this.label);

  static BrazilianState? fromValue(String? value) {
    return BrazilianState.values.firstWhere(
      (e) => e.value == value,
      orElse: () => BrazilianState.sp,
    );
  }
}
