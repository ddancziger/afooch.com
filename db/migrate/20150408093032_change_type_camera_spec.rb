class ChangeTypeCameraSpec < ActiveRecord::Migration
  def change
		rename_column :camera_specs, :type, :type_cam
  end
end
