# ExML

This module is an XML parser, written with Leex and Yecc.
It gives more control on the data structure produced out of an XML document, and benefits from Lex/Yacc's declarativeness.


## Usage

The main module is `ExML`, and the main function is `ExML.parse`.
The latter takes an XML document as a string, and produces a tree-like object composed of nested tuples, lists and maps.
This enables converting an XML document into an Elixir object.

There is no guarantee of performance when working on large XML files.


## Examples

```iex
iex> ExML.parse(~S(
...>   <a foo="bar">
...>     <b bar="baz">
...>       <c/>
...>     </b>
...>     <d/>
...>   </a>
...> ))
{"a", %{"foo" => "bar"}, [
  {"b", %{"bar" => "baz"}, [
    {"c", %{}, []}]},
  {"d", %{}, []}]}
```
