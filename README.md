# TestFixtureBoy

This is a test utility tool to copy active records from rails console and generate a fixture file consisting of those records.
You can print the fixtures to a yaml file.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'test_fixture_boy'
```

And then execute:

    $ bundle install

## Usage

Open you rails console:

```ruby
  # require this gem.
  > require 'test_fixture_boy'
```

Scan all the db records you want to copy.
```ruby
  # Scan all the User records to TFBoy.
  > TFBoy.scan { User.all }
```

You can except some attributes when scanning, such as credentials.(Of course you can select when querying or after it. )
```ruby
  # Scan User 1's all the Account records except password attribute to TFBoy.
  > TFBoy.except(:password).scan { Account.where(user_id: 1).all }
  # ATTN:: Queries for the same Model will be overwritten.
  > TFBoy.except([:password, :id]).scan { Account.where(user_id: 1).all }
```

You can select some attributes when scanning, like exception.
```ruby
  # Scan User 1's all the Account records with only name and status attributes to TFBoy.
  > TFBoy.select([:name, :status]).scan { Account.where(user_id: 1).all }
```

You can clear scan cache if you pass true when scanning.
```ruby
  # Scan User 1's all the Foo records and clear the current cache.
  > TFBoy.scan(true) { Foo.where(user_id: 1).all }
```

After you scan all the records. You can print the records to a yaml file.
Some other fixtures or seeds file formats will be added in the future.
```ruby
  # Print all the records scanned to a yaml file.
  > TFBoy.print :yaml
```

Then you can copy the files or copy the contents to your fixture file. The default directory is "/tmp/tfboy/<model name>s.yaml"

One example of how to use those fixtures:
```ruby
  path = File.join Rails.root, "spec/fixtures/instances.yaml"
  instances = YAML.parse(File.open(fix_path, 'r').read).to_ruby
  instances.each do |attrs|
    FactoryGirl.create(:instance, attrs)
  end
```

The usage procedure is not very convenient. But if you want to create fixtures with many detailed attributes, and you need to copy data from db, using this gem will help you somehow.

Also, if you want to see the introduction from TFBoy:
```ruby
  # This will print a brief usage introduction.
  > TFBoy.show_time
```

## Development

No tests exist in this project. I will add rspec for it later. The current development way is to get the source code, install this gem through local path. Run it with an rails app or a dummy app.
If you have any ideas about improving this gem. Email me: xhan@wpi.edu

## Contributing

1. Fork it ( https://github.com/[my-github-username]/test_fixture_boy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
