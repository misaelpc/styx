defmodule Styx.RfcList do
  use Ecto.Schema

  schema "rfc_list" do
    field :rfc
    field :sfcn
    field :subcontratacion
  end
end