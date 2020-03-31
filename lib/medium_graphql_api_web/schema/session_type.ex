defmodule MediumGraphqlApiWeb.Schema.SessionType do
  use Absinthe.Schema.Notation

  alias MediumGraphqlApiWeb.Resolvers

  input_object :session_input_type do
    field :email, non_null(:string)
    field :password, non_null(:string)
  end

  object :session_type do
    field :token, :string
    field :user, :user_type
  end

  object :session_mutations do
    @desc "Login a user and return a JWT token"
    field :login_user, type: :session_type do
      arg(:input, non_null(:session_input_type))
      resolve(&Resolvers.SessionResolver.login_user/3)
    end
  end
end
