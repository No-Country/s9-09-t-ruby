class IngredientItems::YeastDossage < ActiveModel::Validator
  def validate(record)
    yeast = record.addable
    recommended_dosage = ( yeast.dosage * record.recipe.batch ) / 100
    if record.quantity < recommended_dosage
      record.errors.add :base, "Se recomienda una cantidad de #{recommended_dosage} gr"
    end
  end
end
