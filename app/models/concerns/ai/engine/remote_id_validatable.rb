module AI
  module Engine
    module RemoteIdValidatable
      extend ActiveSupport::Concern

      REMOTE_ID_PREFIXES = {
        run: "run_",
        message: "msg_",
        assistant: "asst_",
        assistant_thread: "thread_"
      }.freeze

      included do
        # Validate the remote_id format is correct.
        validate :remote_id_format

        def remote_id_format
          prefix = self.class.remote_id_prefix
          return if remote_id.nil? || remote_id.start_with?(prefix)

          errors.add(:remote_id, "ID '#{remote_id}' must start with '#{prefix}'")
        end
      end

      class_methods do
        def remote_id_prefix
          REMOTE_ID_PREFIXES[name.demodulize.underscore.to_sym]
        end
      end
    end
  end
end
