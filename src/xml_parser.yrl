Terminals equals open close slash string identifier.
Nonterminals opening_tag closing_tag orphan_tag tree trees node list_of_attributes attribute.
Rootsymbol tree.

tree ->
        orphan_tag : io:fwrite("tree\n"), make_tree('$1', []).
tree ->
        opening_tag closing_tag : io:fwrite("tree\n"), make_tree('$1', []).
tree ->
        opening_tag trees closing_tag : io:fwrite("tree\n"), make_tree('$1', '$2').

trees ->
        tree : io:fwrite("trees\n"), ['$1'].
trees ->
        trees tree : io:fwrite("trees\n"), ['$2' | '$1'].

opening_tag ->
        open identifier close : io:fwrite("opening tag\n"), tag('$2', #{}).
opening_tag ->
        open identifier list_of_attributes close : io:fwrite("opening tag\n"), tag('$2', '$3').

closing_tag -> 
        open slash identifier close : io:fwrite("closing tag\n"), tag('$3', #{}).

orphan_tag -> 
        open identifier slash close : io:fwrite("orphan tag\n"), tag('$2', #{}).
orphan_tag -> 
        open identifier list_of_attributes slash close : io:fwrite("orphan tag\n"), tag('$2', '$3').

list_of_attributes -> 
        attribute : '$1'.
list_of_attributes -> 
        attribute list_of_attributes : maps:merge('$1', '$2').

attribute -> 
        identifier : attribute('$1').
attribute -> 
        identifier equals string : attribute('$1', '$3').


Erlang code.

make_tree({Name, Attributes}, Children) ->
        {Name, Attributes, Children}.

tag({identifier, _, Name}, Attributes) ->
        {Name, Attributes}.

attribute({identifier, _, Name}) ->
        #{Name => nil}.

attribute({identifier, _, Name}, {string, _, Value}) ->
        #{Name => Value}.
