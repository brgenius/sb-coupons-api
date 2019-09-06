# SbCouponsApi

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

## Solution

The API is published at https://sb-coupons-api.herokuapp.com/ for test proposals with the doc suplied endpoints

## Architeture
It uses a [CQRS](https://martinfowler.com/bliki/CQRS.html) aproach via nebulex_ecto, wich will act as a man in middle between elixir ETS and the Postgres repository.
The endpoint that validates the promo code will check Google directions api for results on how to draw the polyline between the two provided venues ( origin and destination )

## Local Setup

[Docker](https://docs.docker.com/install/) and [Docker compose](https://docs.docker.com/compose/install/) are required to run easyly this application locally. After installed, run:

```make setup```

```make compose-build```

```make compose-run```
