defmodule Styx.RfcReader do
	require Logger
	def parse_lrfc_flow do
	  rfc_path = priv_path() <> "/rfc1.txt"
	  data =
	  rfc_path
			|> File.stream!
			|> Flow.from_enumerable()
			|> Flow.map(&(read_line_rfc("#{&1}")))
			|> Flow.partition()
	    |> Flow.run()
	  #Styx.Repo.insert_all(Styx.RfcList,data)
	end

	def parse_lrfc do
	  rfc_path = priv_path() <> "/rfc1.txt"
	  data =
	  rfc_path
	    |> File.stream!
	    |> Stream.map(&(read_line_rfc("#{&1}")))
	    |> Enum.to_list
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
				case result do
					[rfc,sncf,subc] ->
						Logger.info rfc
						ConCache.put(:l_rfc, rfc, {sncf,subc})
					_ ->
						[rfc: "",sfcn: "",subcontratacion: ""]					
				end
	  end
	end

	defp priv_path do
    Application.app_dir(:styx, "priv")
  end
end