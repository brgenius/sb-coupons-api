defmodule SbCouponsApi.Services.PromoCode do
  alias SbCouponsApi.Modules.PromoCode, as: PromoCode

  def list(active, page) do
    PromoCode.all_actives(active, page)
  end

  def get(code) do
    PromoCode.get_cached_by_code(code)
  end

  def create(promo_code) do
    promo_code
    |> IO.inspect()
    |> PromoCode.create()
  end

  def update(promo_code) do
    promo_code
    |> PromoCode.update()
  end

  def delete_by_code(code) do
    PromoCode.delete_by_code(code)
  end
end
