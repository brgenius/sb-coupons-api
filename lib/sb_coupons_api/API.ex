defmodule SbCouponsApi.API do
  use SbCouponsApi.Maru

  plug(Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Jason,
    parsers: [:json]
  )

  mount(SbCouponsApi.SystemRouter)

  before do
    plug(SbCouponsApi.Auth, at: "/V1")

    mount(SbCouponsApi.Router)
  end

  # rescue_from :all do
  #   conn
  #   |> IO.inspect()
  #   |> put_status(500)
  #   |> text("Server Error")
  # end
end
