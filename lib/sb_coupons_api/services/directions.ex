defmodule SbCouponsApi.Services.Directions do
  def validate_boundaries(radius, geolocation, destination) do
    origin = {geolocation[:lat], geolocation[:lon]}
    #
    IO.inspect(radius)
    IO.inspect(origin)
    IO.inspect(destination)
    #
    # valid = Helpers.Haversine.distance(
    #   origin,
    #   destination
    # ) <= 3000
    valid = Distance.distance(origin, destination) <= radius

    %{valid: valid}
  end

  def check_polyline(args) do
    url = "https://maps.googleapis.com/maps/api/directions/json"

    query = %{
      origin: args[:pickup_venue],
      destination: args[:destination_venue],
      key: System.get_env("GOOGLE_DIRECTIONS_API")
    }

    %HTTPotion.Response{
      body: response_json,
      headers: _,
      status_code: response_status_code
    } = HTTPotion.get(url, query: query)

    case response_status_code do
      200 ->
        decoded_response = Jason.decode!(response_json)

        status = decoded_response["status"]

        case status do
          "OK" ->
            [best | _] = decoded_response["routes"]

            overview_polyline = best["overview_polyline"]

            points = overview_polyline["points"]

            %{polyline: points}

          _ ->
            %{polyline: nil}
        end

      _ ->
        %{polyline: nil}
    end
  end

  def check_geolocation(args) do
    url = "https://maps.googleapis.com/maps/api/geocode/json"

    query = %{
      address: args[:destination_venue],
      key: System.get_env("GOOGLE_DIRECTIONS_API")
    }

    %HTTPotion.Response{
      body: response_json,
      headers: _,
      status_code: response_status_code
    } = HTTPotion.get(url, query: query)

    case response_status_code do
      200 ->
        decoded_response = Jason.decode!(response_json)

        status = decoded_response["status"]

        case status do
          "OK" ->
            [best | _] = decoded_response["results"]

            geometry = best["geometry"]

            location = geometry["location"]

            %{destination: %{lat: location["lat"], lon: location["lng"]}}

          _ ->
            %{destination: %{lat: 0, lon: 0}}
        end

      _ ->
        %{destination: %{lat: 0, lon: 0}}
    end
  end
end
