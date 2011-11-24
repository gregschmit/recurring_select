//= require recurring_select_dialog
//= require_self

$ = jQuery
$ ->
  $(".recurring_select").each ->
    $(this).recurring_select("set_initial_values")

  $(document).on "change", ".recurring_select", ->
    $(this).recurring_select('changed')

methods =
  set_initial_values: ->
    @data 'initial-value-hash', @val()
    @data 'initial-value-str', $(@find("option").get()[@.prop("selectedIndex")]).text()
    
  changed: ->
    if @val() == "custom"
      methods.open_custom.apply(@)
    else
      methods.set_initial_values.apply(@)
  
  open_custom: ->
    @data "recurring-select-active", true
    new RecurringSelectDialog(@)

  set_change: ->
    alert "setting changes"

  current_rule: ->
    str:  @data("initial-value-str")
    hash: $.parseJSON(@data("initial-value-hash"))
    
  cancel: ->
    @val @data("initial-value-hash")
    @data "recurring-select-active", false

 
$.fn.recurring_select = (method) ->
  if method of methods
    return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ) );
  else 
    $.error( "Method #{method} does not exist on jQuery.recurring_select" );
