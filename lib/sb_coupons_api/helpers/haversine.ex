defmodule Helpers.Haversine do
  @v :math.pi() / 180
  # km for the earth radius
  @r 6372.8
  def distance({lat1, long1}, {lat2, long2}) do
    dlat = :math.sin((lat2 - lat1) * @v / 2)
    dlong = :math.sin((long2 - long1) * @v / 2)
    a = dlat * dlat + dlong * dlong * :math.cos(lat1 * @v) * :math.cos(lat2 * @v)
    @r * 2 * :math.asin(:math.sqrt(a))
  end
end
