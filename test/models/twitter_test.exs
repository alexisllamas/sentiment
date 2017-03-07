defmodule Etlicus.TwitterTest do
  use Etlicus.ModelCase

  alias Etlicus.Twitter

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Twitter.changeset(%Twitter{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Twitter.changeset(%Twitter{}, @invalid_attrs)
    refute changeset.valid?
  end
end
