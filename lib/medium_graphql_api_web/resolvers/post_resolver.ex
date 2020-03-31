defmodule MediumGraphqlApiWeb.Resolvers.PostResolver do
  alias MediumGraphqlApi.Blog

  def create_post(__parent, %{input: input}, %{context: %{current_user: current_user}}) do
    post_input = Map.merge(input, %{user_id: current_user.id})
    Blog.create_post(post_input)
  end

  def list_post(_parent, _args, _resolution) do
    {:ok, Blog.list_posts()}
  end
end
