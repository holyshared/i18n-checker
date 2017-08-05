module Example
  class Example
    def foo
      t('nested.foo')
    end

    def bar
      I18n.t('nested.bar')
    end
  end
end
