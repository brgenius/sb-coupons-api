defmodule SbCouponsApi.CacheableRepo do
  use NebulexEcto.Repo,
    cache: SbCouponsApi.Cache,
    repo: SbCouponsApi.Repo
end
