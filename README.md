# Spree Elta Courier

This is an Elta Courier extension for [Spree Commerce](https://spreecommerce.org), an open‑source e-commerce platform built with Ruby on Rails. It adds the ability to manage Elta Courier vouchers.

[![Gem Version](https://badge.fury.io/rb/spree_elta_courier.svg)](https://badge.fury.io/rb/spree_elta_courier)

## Installation

1. Add this extension to your Gemfile with this line:

   ```bash
   bundle add spree_elta_courier
   ```

2. Run the install generator

   ```bash
   bundle exec rails g spree_elta_courier:install
   ```

3. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Usage (Creating & Printing Vouchers)

Prerequisites for an order:

- Shipping and billing addresses present
- Payment completed
- Order state: ready (so shipments exist and are ready to ship)

Workflow:

1. Open the order in Spree Admin.
2. If the order meets the prerequisites, the “Create Voucher” option appears in the top‑right dropdown.
3. Click “Create Voucher” (creates one voucher per shipment or split shipment).
4. After successful creation, the “Print Voucher” option becomes available.
5. Click “Print Voucher”: a merged (or single) PDF opens in a new tab for download/printing.

Notes:

- Multiple shipment vouchers are merged into one PDF.
- If no voucher can be created (e.g. order not ready), the button does not appear.
- Errors will return and log details server‑side.

## Developing

1. Create a dummy app

   ```bash
   bundle update
   bundle exec rake test_app
   ```

2. Add your new code

3. Run tests

   ```bash
   bundle exec rspec
   ```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_elta_courier/factories'
```

## Releasing a new version

```bash
bundle exec gem bump -p -t
bundle exec gem release
```

For more options please see [gem-release README](https://github.com/svenfuchs/gem-release)

## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2026 OlympusOne, released under the MIT License.
