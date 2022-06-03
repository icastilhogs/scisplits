enum MuscleGroup {
  hamstrings([
    'biceps femoris',
    'semimembranosus',
    'semitendinosus',
  ]),
  flexors([
    'gastrocnemius',
    'soleus',
    'plantaris',
    'gastrocnemius',
  ]),
  adductors([
    'adductor brevis',
    'adductor longus',
    'adductor magnus',
    'gracilis',
    'pectineus',
  ]),
  gluteal([
    'gluteus maximus',
    'gluteus medius',
    'gluteus minimus',
    'tensor fasciae latea',
  ]),
  quadriceps([
    'rectus femoris',
    'vastus lateralis',
    'vastus medialiss',
  ]),
  extensors([
    'tribialis anterior',
    'extensor digitorium longus',
    'extensor hallucis longus',
    'peroneus tertus',
  ]),
  peroneal([
    'peroneus ongus',
    'peroneus' 'brevis',
  ]),
  sartorius([]);

  final List<String> muscles;

  String get groupName => name;

  const MuscleGroup(this.muscles);
}
