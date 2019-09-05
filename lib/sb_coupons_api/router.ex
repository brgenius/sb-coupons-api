defmodule SbCouponsApi.Router do
  use SbCouponsApi.Maru

  namespace :V1 do
    resource :"promo-codes" do
      desc("List All Promo Codes")

      params do
        optional(:active, type: :boolean, default: true)
        optional(:page, type: :integer, default: 1)
      end

      get do
        json(conn, SbCouponsApi.Services.PromoCode.list(params[:active], params[:page]))
      end

      desc("Creates a Promo Code")

      params do
        requires(:code, type: :string)
        requires(:worths_up_to, type: :integer)
        requires(:expires_at, type: :string)

        requires :event, type: Map do
          requires(:venue, type: :string)
          requires(:radius, type: :integer)
          requires(:lat, type: :float)
          requires(:lon, type: :float)
        end
      end

      post do
        conn
        |> put_status(201)
        |> json(SbCouponsApi.Services.PromoCode.create(params))
      end

      route_param :code, type: :string do
        desc("Gets a Promo Code")

        params do
          requires(:code, type: :string)
        end

        get do
          json(conn, SbCouponsApi.Services.PromoCode.get(params[:code]))
        end

        desc("Updates a Promo Code")

        params do
          requires(:id, type: :integer)
          requires(:code, type: :string)
          requires(:worths_up_to, type: :integer)
          requires(:expires_at, type: :string)

          requires :event, type: Map do
            requires(:id, type: :integer)
            requires(:venue, type: :string)
            requires(:radius, type: :integer)
            requires(:lat, type: :float)
            requires(:lon, type: :float)
          end
        end

        put do
          json(conn, SbCouponsApi.Services.PromoCode.update(params))
        end

        desc("Deletes a Promo Code")

        params do
          requires(:code, type: :string)
        end

        delete do
          json(conn, SbCouponsApi.Services.PromoCode.delete_by_code(params[:code]))
        end
      end
    end
  end
end
