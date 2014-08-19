module RailsMeetAngular
  module Helpers
    class << self

      # Using `context` here is very un-ruby, but it is the cleanest way of accessing
      # the peculiar scope that assets are compiled in.
      def templates(context)
        template_paths(context).each do |path|
          context.depend_on_asset(path)
          asset = context.environment.find_asset(path)
          yield path.sub(/\..*$/, ".slim"), context.escape_javascript(asset.to_s)
        end
      end

      private

      def template_paths(context)
        # @todo: this #include? should be made more robust
        context.assets.logical_paths.select {|path| path.include? '.htm' }
      end
    end
  end
end
