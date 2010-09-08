module Adva
  module Views
    class Menu < Minimal::Template
      autoload :Admin, 'adva/views/menu/admin'
      
      def label(text, options = {}, &block)
        li do
          h4(text)
        end
      end
      
      def item(text, url, options = {}, &block)
        li(:class => active?(url, options) ? "active" : nil) do
          link_to(text, url, options)
          yield if block_given?
        end
      end
      
      protected
      
        def persisted?
          resource.try(:persisted?)
        end

        def active?(url, options)
          activate = options.key?(:activate) ? options.delete(:activate) : true
          delete   = options[:method] == :delete
          activate && !delete && active_paths.include?(url)
        end
  
        def active_paths
          @active_paths ||= path_and_parents(controller.request.path)
        end
  
        def path_and_parents(path)
          path.split('/').inject([]) do |paths, segment|
            path = [paths.last == '/' ? '' : paths.last, segment].compact.join('/')
            paths << (path.empty? ? '/' : path)
          end
        end
    end
  end
end