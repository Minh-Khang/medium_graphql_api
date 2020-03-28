defmodule MediumGraphqlApi.Session do
  alias MediumGraphqlApi.Accounts.User
  alias MediumGraphqlApi.Repo

  def authenticate(agrs) do
    user = Repo.get_by(User, email: String.downcase(agrs.email))

    case check_password(user, agrs) do
      true -> {:ok, user}
      _ -> {:error, "Incorrect login credentials"}
    end
  end

  defp check_password(user, agrs) do
    case user do
      nil -> Argon2.no_user_verify()
      _ -> Argon2.verify_pass(agrs.password, user.password_hash)
    end
  end
end
