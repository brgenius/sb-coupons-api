defmodule SbCouponsApi.Modules.PromoCode do
  use Ecto.Schema
  import Ecto.SoftDelete.Schema

  schema "promo_codes" do
    field(:code, :string)
    field(:active, :boolean)
    field(:expiration, :utc_datetime)
    field(:worths_up_to, Money.Ecto.Amount.Type)
    belongs_to(:event, SbCouponsApi.Event)

    timestamps(type: :utc_datetime)
    soft_delete_schema()
  end
end
