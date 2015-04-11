// Place all the behaviors and hooks related to the matching controller here.//
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/




$(document).ready(function(){

    // List all subcategories on Create Product after choose category
    $('#product_category_id').change(function() {
      var subcategory_url = "/get_subcategories/" + $(this).val();
      var subcategory_select = $("#product_subcategory_id");

      $.ajax({
        url: subcategory_url,
        success: function(data) {
            subcategory_select.html(data);
        }
       });
    });

    $("#product_subcategory_id").change(function() {
        var sub_category = $(this).val();
        $("[id$='_form']").hide();
        if(sub_category === '1')$('#computer_form').show();
        if(sub_category === '2') $('#camera_form').show();

    });
});