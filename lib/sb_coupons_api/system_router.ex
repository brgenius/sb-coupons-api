defmodule SbCouponsApi.SystemRouter do
  use SbCouponsApi.Maru

  desc("Checks the api health status")

  get :health do
    conn
    |> json(%{status: :ok})
  end
end
