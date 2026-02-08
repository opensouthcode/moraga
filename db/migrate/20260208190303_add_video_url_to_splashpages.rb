class AddVideoUrlToSplashpages < ActiveRecord::Migration[7.0]
  def change
    add_column :splashpages, :video_url, :string
  end
end
