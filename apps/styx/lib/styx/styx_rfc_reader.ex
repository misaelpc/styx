defmodule Styx.RfcReader do
	require Logger

	def load_files do
		Task.async(fn ->
			parse_lrfc_flow(:l_rfc1,"/l_RFC_2017_10_29_1.txt")
		end)

		Task.async(fn ->
			parse_lrfc_flow(:l_rfc2,"/l_RFC_2017_10_29_2.txt")
		end)
	end

	def load_files_2 do
		Task.async(fn ->
			parse_lrfc_flow(:l_rfc3,"/l_RFC_2017_10_29_3.txt")
		end)

		Task.async(fn ->
			parse_lrfc_flow(:l_rfc4,"/l_RFC_2017_10_29_4.txt")
		end)
	end

	def load_files_3 do
		Task.async(fn ->
			parse_lrfc_flow(:l_rfc5,"/l_RFC_2017_10_29_5.txt")
		end)
	end


	def parse_lrfc_flow(table_name,file_path) do
	  rfc_path = priv_path() <> file_path
	  data =
	  rfc_path
			|> File.stream!
			|> Flow.from_enumerable()
			|> Flow.map(&(read_line_rfc("#{&1}",table_name)))
			|> Flow.partition()
	    |> Flow.run()
	  #Styx.Repo.insert_all(Styx.RfcList,data)
	end

	def parse_lrfc do
	  rfc_path = priv_path() <> "/rfc1.txt"
	  data =
	  rfc_path
	    |> File.stream!
	    |> Stream.map(&(read_line_rfc("#{&1}",:lrfc1)))
	    |> Enum.to_list
	end

	def read_line_rfc(line,table_name) do
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
						ConCache.dirty_put(table_name,rfc, {sncf,subc})
					_ ->
						[rfc: "",sfcn: "",subcontratacion: ""]					
				end
	  end
	end

	defp priv_path do
    Application.app_dir(:styx, "priv")
  end
end