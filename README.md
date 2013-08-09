# cLean Architecure

Academic architectural experiments.

* Modeling is hard, so do models as late as possible
* UseCases as code artifacts, tested against each other - they describe system
* System as black box with command/query interactions on surface
* Rails is just frontend - not your application


## Project layout


* use_cases - use cases in code
* interactions - atoms for use cases 
* messaging -  outgoing messages
* domain - models for use cases implementation
* web_ui - rails frontend

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
