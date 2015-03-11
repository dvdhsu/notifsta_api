# config/initializers/assets.rb
Rails.application.config.assets.precompile << Proc.new do |path|
  if path =~ /\.(scss|css|js)\z/
    full_path = Rails.application.assets.resolve(path).to_path
    app_assets_path = Rails.root.join('app', 'assets').to_path
    if full_path.starts_with? app_assets_path
      Rails.logger.info "including asset: " + full_path
      true
    else
      Rails.logger.info "excluding asset: " + full_path
      false
    end
  else
    false
  end
end
