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
          requires(:code, type: :string)
        end

        put do
          json(conn, SbCouponsApi.Services.PromoCode.update(params[:code]))
        end

        desc("Deletes a Promo Code")

        params do
          requires(:code, type: :string)
        end

        delete do
          json(conn, SbCouponsApi.Services.PromoCode.delete(params[:code]))
        end
      end
    end
  end
end
