class Food {
  late int id;
  late int baseId;
  late String keylist;
  late String description;
  late String shortDescription;
  late double kcal;
  late double proteinInGrams;
  late double fatInGrams;
  late double carbohydratesInGrams;
  // late double? fiberInGrams;
  late double solubleFiberInGrams;
  late double insolubleFiberInGrams;
  late double calciumInMilligrams;
  late double sodiumInMilligrams;
  late double saturatedFattyAcidsInGrams;
  late double polyunsaturatedFattyAcidsInGrams;
  late double monounsaturatedFattyAcidsInGrams;
  late double sugarInGrams;
  // late double? alcoholInGrams;
  late double vitaminDInMicrograms;
  late int commonPortionSizeAmount;
  late double commonPortionSizeGramWeight;
  late String commonPortionSizeDescription;
  late String commonPortionSizeUnit;
  late String nccFoodGroupCategory;

  @override
  String toString() {
    return 'Food{id: $id, baseId: $baseId, keylist: $keylist, description: $description, shortDescription: $shortDescription, kcal: $kcal, proteinInGrams: $proteinInGrams, fatInGrams: $fatInGrams, carbohydratesInGrams: $carbohydratesInGrams, solubleFiberInGrams: $solubleFiberInGrams, insolubleFiberInGrams: $insolubleFiberInGrams, calciumInMilligrams: $calciumInMilligrams, sodiumInMilligrams: $sodiumInMilligrams, saturatedFattyAcidsInGrams: $saturatedFattyAcidsInGrams, polyunsaturatedFattyAcidsInGrams: $polyunsaturatedFattyAcidsInGrams, monounsaturatedFattyAcidsInGrams: $monounsaturatedFattyAcidsInGrams, sugarInGrams: $sugarInGrams, vitaminDInMicrograms: $vitaminDInMicrograms, commonPortionSizeAmount: $commonPortionSizeAmount, commonPortionSizeGramWeight: $commonPortionSizeGramWeight, commonPortionSizeDescription: $commonPortionSizeDescription, commonPortionSizeUnit: $commonPortionSizeUnit, nccFoodGroupCategory: $nccFoodGroupCategory}';
  }
}
