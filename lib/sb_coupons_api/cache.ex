defmodule SbCouponsApi.Cache do
  use Nebulex.Cache,
    otp_app: :sb_coupons_api,
    adapter: Nebulex.Adapters.Local
end
