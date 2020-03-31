defmodule MediumGraphqlApiWeb.Schema do
  use Absinthe.Schema

  # import Types
  import_types(MediumGraphqlApiWeb.Schema.Types)

  query do
    import_fields(:user_queries)
    import_fields(:post_queries)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:session_mutations)
    import_fields(:post_mutations)
    import_fields(:comment_mutations)
  end

  # subscription do
  # end
end
