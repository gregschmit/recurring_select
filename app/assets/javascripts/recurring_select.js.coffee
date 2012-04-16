//= require recurring_select_dialog
//= require_self

$ = jQuery
$ ->
  $(document).on "focus", ".recurring_select", ->
    $(this).recurring_select('set_initial_values')

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
    @blur()

  save: (new_rule) ->
    @find("option[data-custom]").remove()
    new_json_val = JSON.stringify(new_rule.hash)

    # TODO: check for matching name, and replace that value if found

    if $.inArray(new_json_val, @find("option").map -> $(@).val()) == -1
      methods.insert_option.apply @, [new_rule.str, new_json_val]

    @val new_json_val
    methods.set_initial_values.apply @
    @.trigger "recurring_select:save"

  current_rule: ->
    str:  @data("initial-value-str")
    hash: $.parseJSON(@data("initial-value-hash"))

  cancel: ->
    @val @data("initial-value-hash")
    @data "recurring-select-active", false
    @.trigger "recurring_select:cancel"


  insert_option: (new_rule_str, new_rule_json) ->
    seperator = @find("option:disabled")
    if seperator.length == 0
      seperator = @find("option")
    seperator = seperator.last()

    new_option = $(document.createElement("option"))
    new_option.attr "data-custom", true

    if new_rule_str.substr(new_rule_str.length - 1) != "*"
      new_rule_str+="*"

    new_option.text new_rule_str
    new_option.val new_rule_json
    new_option.insertBefore seperator

  methods: ->
    methods

$.fn.recurring_select = (method) ->
  if method of methods
    return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ) );
  else
    $.error( "Method #{method} does not exist on jQuery.recurring_select" );
