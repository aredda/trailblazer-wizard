# trailblazer-wizard

A helper to aid you with generating blank Trailblazer concept files including: operations, contracts, finders, and  representables.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add trailblazer-wizard

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install trailblazer-wizard

## Usage

All concept files are generated inside the `app/concepts` directory.

To generate files, simply run this command:

    $ wizard [--model] [--actions] [--only] [--except] [--context]

| Argument | Type   | Presence     | Description                                           |
|----------|--------|--------------|-------------------------------------------------------|
| model    | String | **Required** | The model.                                            |
| actions  | Array  | **Required** | The files' names.                                     |
| only     | Array  | Optional     | Only the specified *concept types*.                   |
| except   | Array  | Optional     | Except the specified *concept types*.                 |
| context  | String | Optional     | A directory to group concept files, `nil` by default. |

Allowed concept types are: `operation | finder | form (meant for contracts) | view (meant for representables)`

#### Example 1:

    wizard --model=User --actions=create --only=operation,form

This command will generate:

    app/concepts/user/operation/create.rb
    app/concepts/user/form/create.rb

#### Example 2: with context

    wizard --model=User --context=admin --actions=index --only=operation

Generates:

    app/concepts/user/admin/operation/index.rb

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aredda/trailblazer-wizard. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/wizard/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Wizard project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/wizard/blob/main/CODE_OF_CONDUCT.md).
