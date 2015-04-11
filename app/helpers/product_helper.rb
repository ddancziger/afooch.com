module ProductHelper

	def product_specs product
		specs = ""
		if product.subcategory.id.eql?(1)
			if product.computer_spec
				specs = "<h5>Monitor Size:</h5> #{product.computer_spec.monitor}"
				specs += "<h5>Memory Ram:</h5> #{product.computer_spec.ram} GB"
				specs += "<h5>Processor:</h5> #{product.computer_spec.processor}"
				specs += "<h5>Hard Drive:</h5> #{product.computer_spec.hard} GB"
			end
		else
			if product.camera_spec
				specs = "<h5>Mega Pixels:</h5> #{product.camera_spec.mega_pixel}"
				specs += "<h5>Type Cam:</h5> #{product.camera_spec.type_cam} GB"
				specs += "<h5>Optical Zoom:</h5> #{product.camera_spec.optical_zoom}"
			end
		end

		specs.html_safe
	end

	def specs_form subcategory_id
		if subcategory_id.eql?(1)
			fo = "products/specs_forms/computer_form"
		else
			fo = "products/specs_forms/camera_form"
		end
		fo
	end

end
