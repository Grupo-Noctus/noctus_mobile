enum EducationLevel {
  NO_SCHOOLING('Sem escolaridade'),
  PRIMARY_INCOMPLETE('Ensino Fundamental Incompleto'),
  PRIMARY_COMPLETE('Ensino Fundamental Completo'),
  SECONDARY_INCOMPLETE('Ensino Médio Incompleto'),
  SECONDARY_COMPLETE('Ensino Médio Completo'),
  HIGHER_INCOMPLETE('Ensino Superior Incompleto'),
  HIGHER_COMPLETE('Ensino Superior Completo'),
  POSTGRADUATE('Pós-graduação'),
  MASTERS('Mestrado'),
  DOCTORATE('Doutorado');

  final String value;
  const EducationLevel(this.value);
}

enum Ethnicity {
  WHITE('Branca'),
  BLACK('Preta'),
  BROWN('Parda'),
  ASIAN('Amarela'),
  INDIGENOUS('Indígena'),
  OTHER('Outra');

  final String value;
  const Ethnicity(this.value);
}

enum Gender {
  MALE('Masculino'),
  FEMALE('Feminino'),
  NON_BINARY('Não Binário'),
  PREFER_NOT_TO_SAY('Prefiro não dizer');

  final String value;
  const Gender(this.value);
}

enum BrazilianState {
  AC('Acre'),
  AL('Alagoas'),
  AP('Amapá'),
  AM('Amazonas'),
  BA('Bahia'),
  CE('Ceará'),
  DF('Distrito Federal'),
  ES('Espírito Santo'),
  GO('Goiás'),
  MA('Maranhão'),
  MT('Mato Grosso'),
  MS('Mato Grosso do Sul'),
  MG('Minas Gerais'),
  PA('Pará'),
  PB('Paraíba'),
  PR('Paraná'),
  PE('Pernambuco'),
  PI('Piauí'),
  RJ('Rio de Janeiro'),
  RN('Rio Grande do Norte'),
  RS('Rio Grande do Sul'),
  RO('Rondônia'),
  RR('Roraima'),
  SC('Santa Catarina'),
  SP('São Paulo'),
  SE('Sergipe'),
  TO('Tocantins');

  final String value;
  const BrazilianState(this.value);
}

enum DisabilityType {
  visual('Visual'),
  auditory('Auditiva'),
  physical('Física'),
  intellectual('Intelectual'),
  multiple('Múltipla');

  final String value;
  const DisabilityType(this.value);
}

