defmodule TestPhxApi.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :email, :string
    field :hash_password, :string
    has_one :user, TestPhxApi.Users.User
    
    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :hash_password])
    |> validate_required([:email, :hash_password])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unique_constraint(:email) # if we didn't have this, the API code would allow this to the posgreSQL but gets rejected there anyway
    |> put_password_hash()
  end
  
  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{hash_password: hash_password}} = changeset) do
    change(changeset, hash_password: Bcrypt.hash_pwd_salt(hash_password))
  end
  
  # The second definition of put_password_hash/1 is the catch-all clause, which means it will match
  # any changeset that doesn't match the pattern of the previous definition. 
  # This function simply returns the unchanged changeset without modifying it. 
  # This definition acts as a fallback or default behavior when the changeset is not valid or doesn't contain a hash_password field.
  defp put_password_hash(changeset), do: changeset 
end
