# i18n-checker

[![Build Status](https://travis-ci.org/holyshared/i18n-checker.svg?branch=master)](https://travis-ci.org/holyshared/i18n-checker)
[![Coverage Status](https://coveralls.io/repos/github/holyshared/i18n-checker/badge.svg?branch=master)](https://coveralls.io/github/holyshared/i18n-checker?branch=master)

![Screen shot](https://github.com/holyshared/i18n-checker/blob/master/screenshot.png?raw=true)

This gem provides a **Rake task** to check translation file mistakes and translated text references from template files etc.

Current version supports Ruby source code, Haml template file.

* Ruby source
* Haml template

## Basic usage

Add the following tasks to your **Rakefile**.

```ruby
require 'i18n_checker/rake_task'

I18nChecker::RakeTask::LocaleCheck.new do |task|
  task.source_paths = FileList['app/models/*', 'app/views/*'] # haml templates, ruby sources
  task.locale_file_paths = FileList['config/locales/*'] # locale file paths
end
```

After that we just execute the task.

```shell
bundle exec rake locale_check
```

## Delete unused translated text

Using the **locale_clean** task you can delete unused translated text from the file.  
Since you can delete translated text that you do not use safely, you can reduce the maintenance cost by running it periodically.

```ruby
require 'i18n_checker/rake_task'

I18nChecker::RakeTask::Clean do |task|
  task.source_paths = FileList['app/models/*', 'app/views/*'] # haml templates, ruby sources
  task.locale_file_paths = FileList['config/locales/*'] # locale file paths
end
```

After that we just execute the task.

```shell
bundle exec rake locale_clean
```

## Run the test

```shell
bundle install
bundle exec rake spec
```
