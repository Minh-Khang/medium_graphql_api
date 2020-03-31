defmodule MediumGraphqlApiWeb.Schema.UserType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: MediumGraphqlApi.Repo

  alias MediumGraphqlApiWeb.Resolvers
  alias MediumGraphqlApiWeb.Schema.Middleware

  input_object :user_input_type do
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :password_confirmation, non_null(:string)
  end

  object :user_type do
    field :id, :id
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :role, :string
    field :posts, list_of(:post_type), resolve: assoc(:posts)
  end

  object :user_queries do
    @desc "Get a list of all users"
    field :users, list_of(:user_type) do
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.UserResolver.list_users/3)
    end

    @desc "Get a users"
    field :user, :user_type do
      arg(:id, non_null(:id))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.UserResolver.get_user/3)
    end
  end

  object :user_mutations do
    @desc "Register a new user"
    field :register_user, type: :user_type do
      arg(:input, non_null(:user_input_type))
      resolve(&Resolvers.UserResolver.register_user/3)
    end
  end
end
