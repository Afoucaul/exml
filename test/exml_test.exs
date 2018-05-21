defmodule ExMLTest do
  use ExUnit.Case
  doctest ExML

  test "one orphan tag" do
    tree = ExML.parse(~S(
      <br/>
    )) 
    assert tree == {"br", %{}, []}
  end

  test "one paired tag with no children and no attributes" do
    tree = ExML.parse(~S(
      <a></a>
    ))
    assert tree == {"a", %{}, []}
  end

  test "one paired tag with no children and one attribute" do
    tree = ExML.parse(~S(
      <a b="c"></a>
    ))
    assert tree == {"a", %{"b" => "c"}, []}
  end

  test "one paired tag with no children and a few attributes" do
    tree = ExML.parse(~S(
      <a b="c" d="e" f="g"></a>
    ))
    assert tree == {"a", %{"b" => "c", "f" => "g", "d" => "e"}, []}
  end

  test "one paired tag with no attributes but one paired tag as child" do
    tree = ExML.parse(~S(
      <a>
        <b></b>
      </a>
    ))

    assert tree == {"a", %{}, [{"b", %{}, []}]}
  end

  test "one paired tag with no attributes but one orphan tag as child" do
    tree = ExML.parse(~S(
      <a>
        <b/>
      </a>
    ))

    assert tree == {"a", %{}, [{"b", %{}, []}]}
  end

  test "one tag with several children and attributes" do
    tree = ExML.parse(~S(
      <a foo="bar" bar>
        <b baz="foobar">
          <c spam="eggs"/>
        </b>
        <d banana="potato" size="tall">
          <e color="red"/>
        </d>
      </a>
    ))

    assert tree == {
      "a", %{"foo" => "bar", "bar" => nil}, [
        {"b", %{"baz" => "foobar"}, [
          {"c", %{"spam" => "eggs"}, []}]
        },
        {"d", %{"banana" => "potato", "size" => "tall"}, [
          {"e", %{"color" => "red"}, []}]
        }
      ]
    }
  end
end
