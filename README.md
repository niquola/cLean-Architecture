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

## Ideas
APPLICATION can be described as *black box* by set of USE CASES it implements.
The potential of application is possibility to quickly implement more new USE CASES.

Modeling is hard!
Especially on early stages of system development.

Refactoring wrong model is pain,
especially when this model is everywhere in all layers of application.



Rails problems:

* rails does not have USE CASE artifacts in code,
  so the USE CASE logic is distributed between ui, controllers and models

* rails force you do modeling on early stage of development


IDEAS:

1. UseCase Layer gathering application behavior.
2. Map use cases directly into code artifacts.
3. Consolidate inter use case dependencies in specs.
4. Prototype using simple use case implementation to get feedback as soon as possible.
5. Use Cases is testable only by use cases (as black box)
5. Responsibility of Models just to implement use cases and dependencies between them.
6. Models can be refactored toward Deeper Insight under guard of use cases tests.

Arguments:

* BDD (duck typing) - behavior is matter - what the system does is more important than how the system does it
* Red - Green - Refactor: Design Use Cases -> KISS implementation -> Refactor to deep insight (when requirements is clear)
* Lean - do hard thinks as late as possible
* See what is your application (do u go into interface to understand what app do?)
* wrong model refactoring pain
* early modeling pain
* controllers is technical thing, models is one layer up of abstraciton

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
