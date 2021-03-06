# encoding: utf-8
module Moped

  # Provides behaviour around readable objects.
  #
  # @since 2.0.0
  module Readable

    private

    # Convenience method for getting the cluster from the session.
    #
    # @api private
    #
    # @example Get the cluster from the session.
    #   database.cluster
    #
    # @return [ Cluster ] The cluster.
    #
    # @since 2.0.0
    def cluster
      session.cluster
    end

    # Execute a read operation on the correct node.
    #
    # @api private
    #
    # @example Execute a read.
    #   database.read(operation)
    #
    # @param [ Protocol::Command ] operation The read operation.
    #
    # @return [ Object ] The result of the operation.
    #
    # @since 2.0.0
    def read(operation)
      read_preference.with_node(cluster) do |node|
        Operation::Read.new(operation).execute(node)
      end
    end

    # Convenience method for getting the read preference from the session.
    #
    # @api private
    #
    # @example Get the read preference.
    #   database.read_preference
    #
    # @return [ Object ] The session's read preference.
    #
    # @since 2.0.0
    def read_preference
      session.read_preference
    end

    # Get the query options from the read preference.
    #
    # @api private
    #
    # @example Get the query options.
    #   database.query_options
    #
    # @param [ Hash ] options The existing options on the query.
    #
    # @return [ Hash ] The new query options.
    #
    # @since 2.0.0
    def query_options(options = {})
      read_preference.query_options(options)
    end
  end
end
