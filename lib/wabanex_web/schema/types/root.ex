defmodule WabanexWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  alias WabanexWeb.Schema.Types
  alias WabanexWeb.Resolvers

  alias Resolvers.User, as: UserResolver
  alias Resolvers.Training, as: TrainingResolver

  alias Crudry.Middlewares.TranslateErrors

  import_types WabanexWeb.Schema.Types.Custom.UUID4
  import_types Types.User
  import_types Types.Training

  object :root_query do
    field :get_user, type: :user do
      arg :id, non_null(:uuid4)

      resolve &UserResolver.get/2
    end
  end

  object :root_mutation do
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)

      resolve &UserResolver.create/2
      middleware TranslateErrors
    end

    field :delete_user, type: :user do
      arg :id, non_null(:uuid4)

      resolve &UserResolver.delete/2
    end

    field :update_user, type: :user do
      arg :id, non_null(:uuid4)
      arg :input, non_null(:create_user_input)

      resolve &UserResolver.update/2
    end

    field :create_training, type: :training do
      arg :input, non_null(:create_training_input)

      resolve &TrainingResolver.create/2
      middleware TranslateErrors
    end

    # field :delete_training, type: :training  do
    #   arg :id, non_null(:uuid4)

    #   resolve &TrainingResolver.delete/2
    # end

    # field :update_training, type: :training do
    #   arg :id, non_null(:uuid4)
    #   arg :input, non_null(:create_training_input)

    #   resolve &TrainingResolver.update/2
    # end
  end
end
