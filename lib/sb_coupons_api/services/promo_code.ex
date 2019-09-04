defmodule SbCouponsApi.Services.PromoCode do
  def list(active, page) do
    SbCouponsApi.Modules.PromoCode.all_actives(active, page)
  end

  def get(code) do
  end

  def create(code) do
  end

  def update(code) do
  end

  def delete(code) do
  end
end
