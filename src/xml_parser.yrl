Terminals equals open close slash string identifier.
Nonterminals opening_tag closing_tag orphan_tag tree list_of_trees list_of_attributes attribute.
Rootsymbol tree.

tree ->
        orphan_tag : "orphan tag as tree".

tree ->
        opening_tag closing_tag : 1.

tree ->
        opening_tag list_of_trees closing_tag : nil.

list_of_trees ->
        tree : nil.

list_of_trees ->
        tree list_of_trees : nil.

opening_tag ->
        open identifier close : nil.

opening_tag ->
        open identifier list_of_attributes close : nil.

closing_tag -> open slash identifier close : nil.

orphan_tag -> open identifier slash close : nil.
orphan_tag -> open identifier list_of_attributes slash close : nil.

list_of_attributes -> attribute : nil.
list_of_attributes -> attribute list_of_attributes : nil.

attribute -> identifier : nil.
attribute -> identifier equals string : nil.

Erlang code.
