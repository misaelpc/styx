defmodule Styx.Repo.Migrations.CreateLrfc do
  use Ecto.Migration

  def change do
    create table(:rfc_list) do
      add :rfc, :string
      add :sfcn, :string
      add :subcontratacion, :string
    end
  end
end
