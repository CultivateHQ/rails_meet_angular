module Rang
  module Helpers
    class << self
      include ActionView::Helpers::JavaScriptHelper

      # Using `context` here is very un-ruby, but it is the cleanest way of accessing
      # the peculiar scope that assets are compiled in.
      def templates(context)
        template_paths(context).each do |path|
          transformed_path = path.sub(/\..*$/, ".html")
          context.depend_on_asset(transformed_path)
          asset = context.environment.find_asset(transformed_path.sub(/\..*$/, ".html"))
          yield transformed_path.sub(/\..*$/, ".html"), escape_javascript(asset.to_s)
        end
      end

      private

      def template_paths(context)
        # @todo: this #include? should be made more robust
        logical_paths(context).select {|path| path.include? '.htm' }
      end

      def logical_paths(context)
        if defined? context.assets.logical_paths
          context.assets.logical_paths
        else
          paths = []
          context.assets.each_logical_path {|path| paths << path }
          paths
        end
      end
    end
  end
end
