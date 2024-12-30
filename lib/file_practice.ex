defmodule FilePractice do
  defmodule Newsletter do
    def read_emails(path), do: File.read!(path) |> String.split()

    def open_log(path), do: File.open!(path, [:write])

    def log_sent_email(pid, email), do: IO.puts(pid, email)

    def close_log(pid), do: File.close(pid)

    def send_newsletter(emails_path, log_path, send_fun) do
      log_pid = open_log(log_path)

      read_emails(emails_path)
      |> Enum.each(fn email ->
        if send_fun.(email) == :ok, do: log_sent_email(log_pid, email)
      end)

      close_log(log_pid)
    end
  end
end
