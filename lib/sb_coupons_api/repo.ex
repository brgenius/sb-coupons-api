defmodule SbCouponsApi.Repo do
  use Ecto.Repo,
    otp_app: :sb_coupons_api,
    adapter: Ecto.Adapters.Postgres

  use Ecto.SoftDelete.Repo
end
