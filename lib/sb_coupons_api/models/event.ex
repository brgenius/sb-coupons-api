defmodule SbCouponsApi.Modules.Event do
  use Ecto.Schema
  import Ecto.SoftDelete.Schema

  schema "events" do
    field(:name, :string)
    field(:venue, :string)
    field(:radius, :integer)

    has_many(:promo_codes, SbCouponsApi.Modules.PromoCode)

    timestamps(type: :utc_datetime)
    soft_delete_schema()
  end
end
