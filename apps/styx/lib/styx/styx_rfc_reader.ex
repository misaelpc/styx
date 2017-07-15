defmodule Styx.RfcReader do

	def parse_lrfc do
	  rfc_path = priv_path() <> "/rfc1.txt"
	  data =
	  rfc_path
	    |> File.stream!
	    |> Stream.map(&(read_line_rfc("#{&1}")))
	    |> Enum.to_list
	  Styx.Repo.insert_all(Styx.RfcList,data)
	end

	def read_line_rfc(line) do
	  cond do
	    String.contains? line, "RFC|SNCF" ->
	      IO.inspect "first line"
	      [rfc: "",sfcn: "",subcontratacion: ""]
	    String.contains? line, "EOF" ->
	      IO.inspect "End of file"
	      [rfc: "",sfcn: "",subcontratacion: ""]
	    String.length(line) == 0 ->
	      IO.inspect "Empty Line"
	      [rfc: "",sfcn: "",subcontratacion: ""]
	    true ->
	      result = line
	        |> String.replace("\n", "")
	        |> String.split("|")
	      [rfc,sncf,subc] = result
	      [rfc: rfc,sfcn: sncf,subcontratacion: subc]
	  end
	end

	defp priv_path do
    Application.app_dir(:styx, "priv")
  end
end