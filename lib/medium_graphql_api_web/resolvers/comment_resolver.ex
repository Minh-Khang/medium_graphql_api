defmodule MediumGraphqlApiWeb.Resolvers.CommentResolver do
  alias MediumGraphqlApi.Blog

  def create_comment(_parent, %{input: input}, %{context: %{current_user: current_user}}) do
    comment_input = Map.merge(input, %{user_id: current_user.id})
    Blog.create_comment(comment_input)
  end
end
