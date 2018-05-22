Definitions.

WHITESPACE=[\s\t\r\n]+
IDENTIFIER=[a-zA-Z]\w*
STRING="([^"\\]|\\.)*"


Rules.

{WHITESPACE} : skip_token.
= : {token, {equals, TokenLine}}.
< : {token, {open, TokenLine}}.
> : {token, {close, TokenLine}}.
/ : {token, {slash, TokenLine}}.
{IDENTIFIER} : {token, {identifier, TokenLine, list_to_binary(TokenChars)}}.
{STRING} : {token, {string, TokenLine, extract_string(TokenChars)}}.


Erlang code.

extract_string(Chars) ->
    list_to_binary(lists:sublist(Chars, 2, length(Chars) - 2)).
