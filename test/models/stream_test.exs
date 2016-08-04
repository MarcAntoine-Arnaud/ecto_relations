defmodule EctoRelations.StreamTest do
  use EctoRelations.ModelCase

  alias EctoRelations.Stream

  @valid_attrs %{index: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stream.changeset(%Stream{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stream.changeset(%Stream{}, @invalid_attrs)
    refute changeset.valid?
  end
end
