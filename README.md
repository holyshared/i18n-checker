# i18n-checker

[![Build Status](https://travis-ci.org/holyshared/i18n-checker.svg?branch=master)](https://travis-ci.org/holyshared/i18n-checker)
[![Coverage Status](https://coveralls.io/repos/github/holyshared/i18n-checker/badge.svg?branch=master)](https://coveralls.io/github/holyshared/i18n-checker?branch=master)

![Screen shot](https://github.com/holyshared/i18n-checker/blob/master/screenshot.png?raw=true)

This gem provides a **Rake task** to check translation file mistakes and translated text references from template files etc.

In the current version you can check the translation text reference from Haml's template file.

## Basic usage

Add the following tasks to your **Rakefile**.

```ruby
require 'i18n_checker/rake_task'

I18nChecker::RakeTask.new do |task|
  task.locale_file_paths = FileList['spec/fixtures/locales/**'] # locale file paths
  task.haml_template_paths = FileList['spec/fixtures/*'] # haml template paths
end
```

After that we just execute the task.

```shell
bundle exec rake locale_check
```

## Run the test

```shell
bundle install
bundle exec rake spec
```
