defmodule MediumGraphqlApiWeb.Schema.CommentType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: MediumGraphqlApi.Repo

  alias MediumGraphqlApiWeb.Resolvers
  alias MediumGraphqlApiWeb.Schema.Middleware

  input_object :comment_input_type do
    field :content, non_null(:string)
    field :post_id, non_null(:id)
  end

  object :comment_type do
    field :id, :id
    field :content, :string
    field :user, :user_type, resolve: assoc(:user)
    field :post, :post_type, resolve: assoc(:post)
  end

  object :comment_mutations do
    @desc "Create a comment"
    field :create_comment, type: :comment_type do
      arg(:input, non_null(:comment_input_type))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.CommentResolver.create_comment/3)
    end
  end
end
