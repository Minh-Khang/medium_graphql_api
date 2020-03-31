defmodule MediumGraphqlApiWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias MediumGraphqlApiWeb.Schema

  import_types(Schema.UserType)
  import_types(Schema.SessionType)
  import_types(Schema.PostType)
  import_types(Schema.CommentType)
end
