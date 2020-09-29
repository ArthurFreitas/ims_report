defmodule ImsReport.ProductHelper do
  import Ecto.Query, warn: false
  alias ImsReport.Repo
  alias ImsReport.Product

  def list do
    Repo.all(Product)
  end

  def insert(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end
end
