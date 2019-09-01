# sb-coupons-api

[![Apiary Documentation](https://img.shields.io/badge/Apiary-Documented-blue.svg)](https://sbcouponsapi.docs.apiary.io/)

sb-coupons-api is the API for SafeBoda for promo codes. Here is possible to do the following:
* List all promo codes, with a activated codes filter

* Generation of new promo codes for events, with the features:
    * Can worth a specific amount of ride
    * Can expire
    * Can be deactivated
    * Can be valid when user’s pickup or destination is within x radius of the event venue:
        * The event contains its venue
        * A maximum radius area
        * Lattitude and Longittude references

* Updates, deletes promo codes

* Tests the validity of the promo code by passing a pickup origin and destination

## Docs
Check the usage full docs [here](https://sbcouponsapi.docs.apiary.io/)