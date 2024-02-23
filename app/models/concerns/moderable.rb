# app/models/concerns/moderable.rb
module Moderable
    extend ActiveSupport::Concern
  
    included do
      before_save :moderate_content
    end
  
    def moderate_content
      # Appelez l'API de modération et stockez le résultat dans la colonne is_accepted
      moderation_response = RestClient.post(
        "https://moderation.logora.fr/predict",
        { text: self.content_to_moderate }.to_json,
        content_type: :json,
        accept: :json
      )
      response_data = JSON.parse(moderation_response.body)
  
      # Utilisez les données de la réponse de l'API pour déterminer si le contenu est accepté
      self.is_accepted = response_data["probability"] < 0.5
    end
  end
  