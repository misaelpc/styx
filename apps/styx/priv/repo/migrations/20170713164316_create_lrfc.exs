defmodule Styx.Repo.Migrations.CreateLrfc do
  use Ecto.Migration

  def change do
    create table(:rfc_list,primary_key: false) do
      add :rfc, :string
      add :sfcn, :string
      add :subcontratacion, :string
    end
    #create index(:rfc_list, [:rfc])
  end
end
