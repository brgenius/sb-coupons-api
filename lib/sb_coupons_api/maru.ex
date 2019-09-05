defmodule SbCouponsApi.Maru do
  use Maru.Server, otp_app: :sb_coupons_api

  def init(_type, opts) do
    Confex.Resolver.resolve(opts)
  end
end
