ActiveAdmin.register Subcategory do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :category_id, :name, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  index do
	  selectable_column
	  id_column
	  column "Category" do |p|
		  user = Category.find(p.category_id).name
	  end
	  column :name
	  column :description
	  actions
  end

	form do |f|
		f.inputs do
			f.input :category_id, :label => 'Category', :as => :select, :collection => Category.all.map{|u| ["#{u.name}", u.id]}
			f.input :name
			f.input :description
			actions
		end
	end

end
