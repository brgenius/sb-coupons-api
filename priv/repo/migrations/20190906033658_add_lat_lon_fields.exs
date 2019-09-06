defmodule SbCouponsApi.Repo.Migrations.AddLatLonFields do
  use Ecto.Migration

  def change do
    alter table("events") do
      add(:lat, :float)
      add(:lon, :float)
    end
  end
end
