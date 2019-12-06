require "open3"
require "geny/error"

module Geny
  class Shell
    def initialize(ui:)
      @ui = ui
    end

    def capture(*args, **opts)
      cmd = build(*args, **opts)
      cmd_str = stringify(args)
      out, _err, status = Open3.capture3(*cmd)
      assert!(status, cmd_str)
      out.chomp
    rescue Errno::ENOENT
      raise ExitError.new(command: cmd_str, code: 127)
    end

    def run(*args, verbose: true, **opts)
      cmd = build(*args, **opts)
      cmd_str = stringify(args)

      @ui.status("run", cmd_str) if verbose

      Kernel.system(*cmd)
      assert!($?, cmd_str)
    end

    private

    def build(*args, env: nil, **opts)
      [*env, *args, **opts]
    end

    def stringify(args)
      args.map { |arg| arg.match?(/\s/) ? arg.inspect : arg }.join(" ")
    end

    def assert!(status, cmd)
      unless status.success?
        raise ExitError.new(command: cmd, code: status.exitstatus)
      end
    end
  end
end
