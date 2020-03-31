defmodule MediumGraphqlApiWeb.Resolvers.UserResolver do
  alias MediumGraphqlApi.Repo
  alias MediumGraphqlApi.Accounts

  def list_users(_parent, _args, _resolution) do
    {:ok, Accounts.list_users()}
  end

  def register_user(_parent, %{input: input}, _resolution) do
    Accounts.create_user(input)
  end

  def get_user(_parent, %{id: id}, _resolution) do
    {:ok, Accounts.get_user!(id)}
  rescue
    Ecto.NoResultsError -> {:error, "User ID #{id} not found"}
  end
end
