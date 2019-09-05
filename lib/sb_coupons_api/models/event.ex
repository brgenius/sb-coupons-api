defmodule SbCouponsApi.Modules.Event do
  use Ecto.Schema

  import Ecto.SoftDelete.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__, :promo_codes, :deleted_at]}
  schema "events" do
    field(:name, :string)
    field(:venue, :string)
    field(:radius, :integer)

    has_many(:promo_codes, SbCouponsApi.Modules.PromoCode)

    timestamps(type: :utc_datetime)
    soft_delete_schema()
  end

  def changeset(event, attrs \\ %{}) do
    event
    |> cast(attrs, [:name, :venue, :radius])
    |> validate_required([:venue, :radius])
  end
end
