Rails.application.config.middleware.use OmniAuth::Builder do
  provider :moves, Moves.moves_key , Moves.moves_secret
end