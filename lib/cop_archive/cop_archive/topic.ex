defmodule CopArchive.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Query, as: Q
  use CopArchive.TopherDB

  @primary_key {:oid, :integer, autogenerate: false}

  schema "ForumTopic" do
    field :body, :string
    # belongs_to :comp, CopArchive.Composition, foriegn_key: "oid"
  end

  def apply_clause(query, :id, oid), do: Q.where(query, [r], r.oid == ^oid)

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [])
    |> validate_required([])
  end
end
