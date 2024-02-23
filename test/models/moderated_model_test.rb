# test/models/moderated_model_test.rb
require 'test_helper'

class ModeratedModelTest < ActiveSupport::TestCase
  test "should moderate content" do
    model = ModeratedModel.new(content_to_moderate: "Contenu à modérer")
    model.save
    assert_not_nil model.is_accepted, "Le champ is_accepted ne devrait pas être nul"
    assert_equal true, model.is_accepted, "Le contenu modéré devrait être accepté"
  end
end
