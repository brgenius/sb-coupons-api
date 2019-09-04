defmodule SbCouponsApi.Modules.PromoCode do
  use Ecto.Schema

  import Ecto.SoftDelete.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  import SbCouponsApi.Helpers.Pager

  schema "promo_codes" do
    field(:code, :string)
    field(:active, :boolean)
    field(:expiration, :utc_datetime)
    field(:worths_up_to, Money.Ecto.Amount.Type)
    belongs_to(:event, SbCouponsApi.Modules.Event)

    timestamps(type: :utc_datetime)
    soft_delete_schema()
  end

  def all_actives(active \\ true, page \\ 1) do
    from(p in __MODULE__,
      join: e in assoc(p, :event),
      where: [active: ^active],
      order_by: [desc: :expiration],
      preload: [event: e]
    )
    |> paginate(page, 30)
    |> SbCouponsApi.Repo.all()
  end

  def get_cached_by_code(code) do
    SbCouponsApi.CacheableRepo.get_by(__MODULE__, code: code)
  end

  def delete_by_code(code) do
    SbCouponsApi.Repo.get_by(__MODULE__, code: code)
    |> SbCouponsApi.Cache.delete()
    |> SbCouponsApi.Repo.soft_delete()
  end

  def changeset(promo_code, attrs) do
    promo_code
    |> cast(attrs, [:code, :active, :expiration, :worths_up_to, :event_id])
    |> validate_required([:code, :expiration, :worths_up_to, :event_id])
    |> unique_constraint(:code)
  end
end
