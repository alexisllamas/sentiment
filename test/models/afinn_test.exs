defmodule Etlicus.AfinnTest do
  use Etlicus.ModelCase

  alias Etlicus.Afinn

  @valid_attrs %{score: 42, word: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Afinn.changeset(%Afinn{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Afinn.changeset(%Afinn{}, @invalid_attrs)
    refute changeset.valid?
  end
end
