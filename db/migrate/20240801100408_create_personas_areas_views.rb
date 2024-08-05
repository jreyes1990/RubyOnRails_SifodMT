class CreatePersonasAreasViews < ActiveRecord::Migration[6.0]
  def change
    create_view :personas_areas_views
  end
end
