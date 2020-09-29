defmodule ImsReport.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "products" do
    field :SKU
    field :description
    field :name
    field :barcode, :string, default: "00000000"
    field :price, :float, default: 0/1 #0 as float
    field :quantity, :integer
  end

  @doc false
  def changeset(product \\ %ImsReport.Product{}, attrs) do
    product
    |> cast(attrs, [:SKU, :name, :description, :quantity, :price, :barcode])
    |> validate_required([:SKU, :name])
    |> validate_number(:price, greater_than: 0)
    |> validate_format(:SKU, ~r/^[a-zA-Z0-9\-]+$/)
    |> validate_format(:barcode, ~r/^[0-9]+$/)
    |> validate_length(:barcode, min: 8, max: 13)
  end
end
