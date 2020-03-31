defmodule MediumGraphqlApiWeb.Schema.PostType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: MediumGraphqlApi.Repo

  alias MediumGraphqlApiWeb.Resolvers
  alias MediumGraphqlApiWeb.Schema.Middleware

  input_object :post_input_type do
    field :title, non_null(:string)
    field :content, non_null(:string)
    field :published, non_null(:boolean)
  end

  object :post_type do
    field :id, :id
    field :title, :string
    field :content, :string
    field :published, :boolean
    field :user, :user_type, resolve: assoc(:user)
  end

  object :post_queries do
    @desc "Get a list of posts"
    field :posts, list_of(:post_type) do
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.PostResolver.list_post/3)
    end
  end

  object :post_mutations do
    @desc "Create a post"
    field :create_post, type: :post_type do
      arg(:input, non_null(:post_input_type))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.PostResolver.create_post/3)
    end
  end
end
