defmodule Etlicus.Afinn do
  use Etlicus.Web, :model

  schema "afinn" do
    field :word, :string
    field :score, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:word, :score])
    |> validate_required([:word, :score])
  end
end
