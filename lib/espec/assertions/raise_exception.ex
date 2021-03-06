defmodule ESpec.Assertions.RaiseException do

  use ESpec.Assertions.Interface

  defp match(subject, []) do
    try do
      subject.()
      {false, false}
    rescue
      _error -> {true, false}
    end
  end

  defp match(subject, [module]) do
    try do
      subject.()
      {false, {false, nil}}
    rescue
      error ->
        if error.__struct__ == module do
          {true, error.__struct__}
        else
          {false, error.__struct__}
        end
    end
  end

  defp match(subject, [module, mes]) do
    try do
      subject.()
      {false, false}
    rescue
      error ->
        if error.__struct__ == module && Exception.message(error) == mes do
          {true, [error.__struct__, Exception.message(error)]}
        else
          {false, [error.__struct__, Exception.message(error)]}
        end
    end
  end

  defp success_message(subject, [], _result, positive) do
    to = if positive, do: "raises", else: "doesn't raise"
    "#{inspect subject} #{to} an exception."
  end

  defp success_message(subject, [module], _result, positive) do
    to = if positive, do: "raises", else: "doesn't raise"
    "#{inspect subject} #{to} the `#{module}` exception."
  end

  defp success_message(subject, [module, message], _result, positive) do
    to = if positive, do: "raises", else: "doesn't raise"
    "#{inspect subject} #{to} the `#{module}` exception with the message `#{message}`."
  end

  defp error_message(subject, [], false, positive) do
    if positive do
      "Expected #{inspect subject} to raise an exception, but nothing was raised."
    else
      "Expected #{inspect subject} to not raise an exception, but an exception was raised."
    end
  end

  defp error_message(subject, [module], err_module, positive) do
    if positive do
      "Expected #{inspect subject} to raise the `#{module}` exception, but nothing was raised."
    else
      "Expected #{inspect subject} to not raise the `#{module}` exception, but the `#{err_module}` exception was raised."
    end
  end

  defp error_message(subject, [module, message], false, positive) do
    to = if positive, do: "to", else: "not to"
    "Expected #{inspect subject} #{to} raise the `#{module}` exception with the message `#{message}`, but nothing was raised."
  end

  defp error_message(subject, [module, message], [err_module, err_message], positive) do
    to = if positive, do: "to", else: "not to"
    "Expected #{inspect subject} #{to} raise the `#{module}` exception with the message `#{message}`, but the `#{err_module}` exception was raised with the message `#{err_message}`."
  end

end
