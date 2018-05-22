defmodule ExML do
  defp taggify_text(str) do
    Regex.replace(
      ~r/>([^<]*)</, 
      str, 
      fn(_, c) -> if c =~ ~r/^\s*$/ do "><" else "><t text=\"#{c}\" /><" end end
    )
  end

  def parse(str) do
    with {:ok, tokens, _} <- str |> taggify_text |> to_char_list |> :xml_lexer.string,
         {:ok, result} <- :xml_parser.parse(tokens)
    do
      result
    else
      {:error, reason, _} ->
        reason
      {:error, {_, :xml_parser, reason}} ->
        to_string(reason)
    end
  end
end
