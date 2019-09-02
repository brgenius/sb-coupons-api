defmodule SbCouponsApi.API do
  use SbCouponsApi.Maru

  plug(Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Jason,
    parsers: [:json]
  )

  before do
    plug(SbCouponsApi.Auth, at: "/V1")

    mount(Router)
  end

  rescue_from :all do
    conn
    |> IO.inspect()
    |> put_status(500)
    |> text("Server Error")
  end
end
