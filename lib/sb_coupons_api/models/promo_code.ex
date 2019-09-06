require Helpers.MoneyEncoder

defmodule SbCouponsApi.Modules.PromoCode do
  alias SbCouponsApi.Modules.PromoCode, as: PromoCode

  use Ecto.Schema

  import Ecto.SoftDelete.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  import SbCouponsApi.Helpers.Pager

  @derive {Jason.Encoder, except: [:__meta__, :deleted_at]}
  schema "promo_codes" do
    field(:code, :string)
    field(:active, :boolean)
    field(:expires_at, :utc_datetime)
    field(:worths_up_to, Money.Ecto.Amount.Type)
    belongs_to(:event, SbCouponsApi.Modules.Event)

    timestamps(type: :utc_datetime)
    soft_delete_schema()
  end

  def all_actives(active \\ true, page \\ 1) do
    from(p in __MODULE__,
      join: e in assoc(p, :event),
      where: [active: ^active],
      order_by: [desc: :expires_at],
      preload: [event: e]
    )
    |> paginate(page, 30)
    |> SbCouponsApi.Repo.all()
  end

  def get_cached_by_code(code) do
    __MODULE__
    |> SbCouponsApi.CacheableRepo.get_by(code: code)
    |> SbCouponsApi.Repo.preload(:event)
  end

  def create(promo_code) do
    prepare_castset(%PromoCode{}, promo_code)
    |> SbCouponsApi.CacheableRepo.insert_or_update()
  end

  def update(args) do
    __MODULE__
    |> SbCouponsApi.Repo.get!(args[:id])
    |> SbCouponsApi.Repo.preload(:event)
    |> prepare_changeset(args)
    |> SbCouponsApi.CacheableRepo.update()
  end

  def delete_by_code(code) do
    __MODULE__
    |> SbCouponsApi.CacheableRepo.get_by(code: code)
    |> SbCouponsApi.Cache.delete()
    |> SbCouponsApi.Repo.soft_delete()
  end

  def validate(args) do
    promo_code =
      __MODULE__
      |> SbCouponsApi.CacheableRepo.get_by!(code: args[:code])
      |> SbCouponsApi.Repo.preload(:event)

    destination = SbCouponsApi.Services.Directions.check_geolocation(args)
    polyline = SbCouponsApi.Services.Directions.check_polyline(args)
    valid = SbCouponsApi.Services.Directions.validate_boundaries(
      promo_code.event.radius,
      destination[:destination],
      {promo_code.event.lat, promo_code.event.lon}
    )

    Map.from_struct(promo_code)
    |> Map.pop(:__meta__)
    |> elem(1)
    |> Map.merge(destination)
    |> Map.merge(polyline)
    |> Map.merge(valid)
  end

  def prepare_castset(promo_code, attrs \\ %{}) do
    promo_code
    |> cast(attrs, [:code, :active, :expires_at, :worths_up_to])
    |> validate_required([:code, :expires_at, :worths_up_to])
    |> unique_constraint(:code)
    |> cast_assoc(:event)
  end

  def prepare_changeset(promo_code, attrs \\ %{}) do
    promo_code
    |> change(attrs)
    |> cast_assoc(:event)
    |> unique_constraint(:code)
    |> validate_required([:expires_at, :worths_up_to])
  end
end
