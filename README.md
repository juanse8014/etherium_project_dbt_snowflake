# etherium_project

A dbt project that models Ethereum blockchain activity in Snowflake. The project builds staging, intermediate, and mart layers from Ethereum source tables, enriches transactions with token transfer metadata, and computes activity metrics for ETH and stablecoins.

## Project Structure

- `models/staging/`
  - `stg_transactions.sql` — incremental load from `eth.transactions`
  - `stg_token_transfers.sql` — incremental load from `eth.token_transfers`
  - `stg_contracts.sql` — staging model for `eth.contracts`

- `models/intermediate/`
  - `int_token_transfer_agg.sql` — aggregates token transfer counts by transaction
  - `int_transactions_enriched_append.sql` — incremental append enriched transactions
  - `int_transactions_enriched_delete_insert.sql` — incremental delete+insert enriched transactions
  - `int_transactions_enriched_merge.sql` — incremental merge enriched transactions
  - `int_transactions_enriched_microbatch.sql` — incremental microbatch enriched transactions

- `models/marts/`
  - `eth_activity_per_day.sql` — daily ETH activity metrics by transaction category
  - `fiat_back_activity_per_day.sql` — daily fiat-backed stablecoin activity
  - `stablecoin_activity_per_day_v1.sql` / `stablecoin_activity_per_day_v2.sql` — versioned stablecoin activity models
  - `confirmed_fraud.sql` — private model for flagged suspicious transactions

- `models/sources.yml`
  - Defines source `eth` with tables `transactions`, `token_transfers`, `contracts`, and `contracts_clone`
  - Includes an `airbnb` source used for snapshot examples

- `seeds/stablecoins.csv`
  - Stablecoin catalog with `contract_address`, `symbol`, `type`, and `decimals`
  - Used to classify tokens and compute USD-equivalent values

- `dbt_project.yml`
  - Project name: `etherium_project`
  - Profile: `etherium_project`
  - Default model materialization: `table`
  - `marts` configured as tables
  - `stablecoin_activity_per_day` includes grant hooks
  - Project variable: `begin_date: '2026-07-01'`

- `packages.yml`
  - `dbt-labs/codegen`
  - `dbt-labs/dbt_utils`
  - `dbt-labs/audit_helper`

## Purpose

This project:
- extracts Ethereum source data from Snowflake
- builds staging models for transactions, token transfers, and contracts
- creates intermediate models that enrich transactions with token transfer counts and categories
- computes daily analytics for ETH transaction activity and stablecoin behavior
- uses a seed file to classify stablecoins and calculate USD-equivalent token values
- includes fraud-risk analysis via a private mart model

## Requirements

- dbt with `dbt-snowflake`
- Snowflake profile configured as `etherium_project`
- Environment variables expected in `.dbt/profiles.yml`:
  - `DBT_SNOWFLAKE_IDENTIFIER`
  - `DBT_SNOWFLAKE_ROLE`
  - `DBT_SNOWFLAKE_USER`

## Common Commands

```bash
dbt deps
dbt seed
dbt run
dbt test