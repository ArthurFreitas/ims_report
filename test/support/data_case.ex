defmodule ImsReport.DataCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's data layer.

  You may define functions here to be used as helpers in
  your tests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias ImsReport.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import ImsReport.DataCase
    end
  end

  setup tags do
    unless tags[:async] do
      Mongo.Ecto.truncate(ImsReport.Repo, [])
    end
    :ok
  end
end
