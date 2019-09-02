defmodule SbCouponsApi.Auth do
  import Plug.Conn

  def init(options) do
    options
  end

  def call(conn, _opts) do
    headers = Enum.into(conn.req_headers(), %{})

    SbCouponsApi.Services.Auth.check({headers["apikey"], headers["token"]})
    |> IO.inspect()

    # |> send_resp(418, "Hello world")
    conn
  end
end
