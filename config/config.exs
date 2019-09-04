# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# third-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :sb_coupons_api, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:sb_coupons_api, :key)
#
# You can also configure a third-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"

config :sb_coupons_api, ecto_repos: [SbCouponsApi.Repo]

config :sb_coupons_api, SbCouponsApi.Repo,
  database: "sb_coupons_#{Mix.env()}",
  username: System.get_env("POSTGRES_USER"),
  password: System.get_env("POSTGRES_PASSWORD"),
  hostname: System.get_env("POSTGRES_HOSTNAME"),
  port: System.get_env("POSTGRES_PORT") || "5432"

config :postgrex, :json_library, Jason

config :money, default_currency: :UGX

config :sb_coupons_api, SbCouponsApi.Maru,
  adapter: Plug.Adapters.Cowboy,
  plug: SbCouponsApi.API,
  scheme: :http,
  ip: {0, 0, 0, 0},
  port: System.get_env("PORT") || 4000

config :sb_coupons_api, maru_servers: [SbCouponsApi.Maru]

config :sb_coupons_api, SbCouponsApi.Cache,
  n_shards: 2,
  gc_interval: 600

config :logger, handle_sasl_reports: true

config :logger, level: :debug
