defmodule MediumGraphqlApiWeb.Resolvers.SessionResolver do
  alias MediumGraphqlApi.{Session, Guardian}

  def login_user(_parent, %{input: input}, _resolution) do
    with {:ok, user} <- Session.authenticate(input),
         {:ok, jwt_token, _} <- Guardian.encode_and_sign(user) do
      {:ok, %{token: jwt_token, user: user}}
    end
  end
end
