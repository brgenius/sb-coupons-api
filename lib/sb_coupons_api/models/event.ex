defmodule SbCouponsApi.Modules.Event do
  use Ecto.Schema

  import Ecto.SoftDelete.Schema
  import Ecto.Changeset

  import Helpers.Haversine

  @derive {Jason.Encoder, except: [:__meta__, :promo_codes, :deleted_at]}
  schema "events" do
    field(:name, :string)
    field(:venue, :string)
    field(:radius, :integer)
    field(:lat, :float)
    field(:lon, :float)

    has_many(:promo_codes, SbCouponsApi.Modules.PromoCode)

    timestamps(type: :utc_datetime)
    soft_delete_schema()
  end

  def changeset(event, attrs \\ %{}) do
    event
    |> cast(attrs, [:name, :venue, :radius, :lat, :lon])
    |> validate_required([:venue, :radius, :lat, :lon])
  end
end
