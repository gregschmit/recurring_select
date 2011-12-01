//= require recurring_select
//= require_self

$ ->
  $(document).on "recurring_select:cancel recurring_select:save", ".recurring_select", ->
    $(this).selectmenu('refresh');
