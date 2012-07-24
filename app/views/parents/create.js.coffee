$('#new_parent').hide()
$('#new_parent').before("<%= escape_javascript(render("shared/parents/parent", parent: @parent)) %>")