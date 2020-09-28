defmodule ImsReport.ProductHelper do
  import Ecto.Query, warn: false
  alias ImsReport.Repo
  alias ImsReport.Product

  def list do
    Repo.all(Product)
  end
end
