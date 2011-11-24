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

  save: (new_rule) ->
    @find("option[data-custom]").remove()
    seperator = @find("option:disabled")
    if seperator.length == 0
      seperator = @find("option").first()
    seperator = seperator.last()
    
    new_option = $(document.createElement("option"))
    new_option.attr "data-custom", true
    new_option.text new_rule.str+"*"
    new_option.val JSON.stringify(new_rule.hash)
    new_option.insertBefore seperator
    
    @val new_option.val()
    
    # set value
    methods.set_initial_values.apply(@)

  current_rule: ->
    str:  @data("initial-value-str")
    hash: $.parseJSON(@data("initial-value-hash"))
    
  cancel: ->
    @val @data("initial-value-hash")
    @data "recurring-select-active", false

  methods: ->
    methods

$.fn.recurring_select = (method) ->
  if method of methods
    return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ) );
  else 
    $.error( "Method #{method} does not exist on jQuery.recurring_select" );
