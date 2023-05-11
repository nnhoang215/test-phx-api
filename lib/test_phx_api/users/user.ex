defmodule TestPhxApi.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :biography, :string
    field :full_name, :string
    field :gender, :string
    # field :account_id, :binary_id
    belongs_to :account, TestPhxApi.Accounts.Account #establish relationship between user and account object (u need to configure in account schema as well)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:account_id, :full_name, :gender, :biography])
    |> validate_required([:account_id])
  end
end
