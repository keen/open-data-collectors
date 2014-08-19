# Open Data Collectors

A set of [Pushpop](https://github.com/pushpop-project/pushpop) jobs that collect data from various APIs over time and push data into [Keen IO](https://keen.io).

There are 2 ways to use this project:

+ Use the Keen IO Project ID and Read Key specified in each collector's documentation to use the data.
+ Capture the data yourself by cloning and deploying this repository pointing to your own project ID.

### Collectors

##### Bitcoin Prices

Uses the [BitcoinAverage](https://api.bitcoinaverage.com) API to capture Bitcoin
price trends over time.

+ Code – [jobs/bitcoin_prices.rb](jobs/bitcoin_prices_job.rb)
+ Interval - Every minute
+ Contact Info - [@dzello](https://twitter.com/dzello)
+ Runs On – Heroku
+ Example Event - [Extract One](https://api.keen.io/3.0/projects/53f3a8687d8cb95095000001/queries/extraction?latest=1&event_collection=bitcoin-prices&api_key=99a06e48fd7fb1279bc40995160eb0b61a9e0efaab8b651b029f0d895f77c0a804ba089282eff28bf8ad07f337422441d0542b7feaac9fea1e92fc153ee7efc51afad3276bda8d7754a338b349d540bfb402cba0dfdc82498c217054efd8abd0f47a0c0bc963bbdf0dc938c91b17d9f2)
+ Keen IO Data Set Information
  + Project ID: `53f3a8687d8cb95095000001`
  + Read Key: `99a06e48fd7fb1279bc40995160eb0b61a9e0efaab8b651b029f0d895f77c0a804ba089282eff28bf8ad07f337422441d0542b7feaac9fea1e92fc153ee7efc51afad3276bda8d7754a338b349d540bfb402cba0dfdc82498c217054efd8abd0f47a0c0bc963bbdf0dc938c91b17d9f2`
  + Collection Name: `bitcoin-prices`

**Example CLI Queries**

Note: Make sure to set environment variables in `.env` or specify `--project` and `--read-key` parameters.

```
# price last 30 minutes piped to spark
$ keen average -c bitcoin-prices -y "USD.averages.last" -t last_30_minutes -i minutely --spark | spark
▄███▄▄▄▄▄▁▄▄▄▄▄▄▄▁▁▁▄▄▄▄██▄

# highest USD price today
$ keen maximum -c bitcoin-prices -y "USD.averages.last"
481.77

# total USD volume last 24 hours
$ keen extraction -c bitcoin-prices --property-names "USD.averages.total_vol" --latest 1
[
  {
    "USD": {
      "averages": {
        "total_vol": 38276.39
      }
    }
  }
]
```

### Contributing

More jobs! More open data sets!

If you add a job please fill out all the details (use Bitcoin Prices as a guide).
Keen IO project and credentials are not required if you expect someone to capture
the data on their own and not use a shared project.
