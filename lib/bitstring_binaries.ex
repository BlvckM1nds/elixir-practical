defmodule BitstringBinaries do
  def palette_bit_size(color_count), do: calculate_bits(color_count, 0)

  defp calculate_bits(color_count, bits) do
    if Integer.pow(2, bits) >= color_count, do: bits, else: calculate_bits(color_count, bits + 1)
  end

  def empty_picture(), do: <<>>

  def test_picture(), do: <<0::2, 1::2, 2::2, 3::2>>

  def prepend_pixel(picture, color_count, pixel_color_index) do
    bit_size = palette_bit_size(color_count)
    <<pixel_color_index::size(bit_size), picture::bitstring>>
  end

  defguardp no_picture(picture) when picture == <<>>

  def get_first_pixel(picture, _color_count) when no_picture(picture), do: nil

  def get_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<first_pixel::size(bit_size), _rest::bitstring>> = picture
    first_pixel
  end

  def drop_first_pixel(picture, _color_count) when no_picture(picture), do: <<>>

  def drop_first_pixel(picture, color_count) do
    bit_size = palette_bit_size(color_count)
    <<_first_pixel::size(bit_size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) when no_picture(picture1) and no_picture(picture2),
    do: <<>>

  def concat_pictures(picture1, picture2) when no_picture(picture2), do: picture1
  def concat_pictures(picture1, picture2) when no_picture(picture1), do: picture2
  def concat_pictures(picture1, picture2), do: <<picture1::bitstring, picture2::bitstring>>

  defmodule DNA do
    def encode_nucleotide(code_point) do
      case code_point do
        ?\s -> 0b0000
        ?A -> 0b0001
        ?C -> 0b0010
        ?G -> 0b0100
        ?T -> 0b1000
      end
    end

    def decode_nucleotide(encoded_code) do
      case encoded_code do
        0b0000 -> ?\s
        0b0001 -> ?A
        0b0010 -> ?C
        0b0100 -> ?G
        0b1000 -> ?T
      end
    end

    def encode(dna), do: do_encode(dna, <<>>)

    defp do_encode([], acc), do: acc

    defp do_encode([nucleotide | rest_of_dna], acc),
      do: do_encode(rest_of_dna, <<acc::bitstring, encode_nucleotide(nucleotide)::4>>)

    def decode(dna), do: do_decode(dna, [])

    defp do_decode(<<>>, acc), do: acc

    defp do_decode(<<nucleotide::4, rest_of_dna::bitstring>>, acc),
      do: do_decode(rest_of_dna, acc ++ [decode_nucleotide(nucleotide)])
  end

  defmodule FileSniffer do
    @file_map %{
      "exe" => %{
        media_type: "application/octet-stream",
        binary: <<0x7F, 0x45, 0x4C, 0x46>>
      },
      "bmp" => %{
        media_type: "image/bmp",
        binary: <<0x42, 0x4D>>
      },
      "png" => %{
        media_type: "image/png",
        binary: <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>
      },
      "jpg" => %{
        media_type: "image/jpg",
        binary: <<0xFF, 0xD8, 0xFF>>
      },
      "gif" => %{
        media_type: "image/gif",
        binary: <<0x47, 0x49, 0x46>>
      }
    }

    def type_from_extension(extension) do
      @file_map[extension]
    end

    def type_from_binary(file_binary) when is_binary(file_binary) do
      @file_map
      |> Enum.find(fn {_ext, %{binary: signature}} ->
        String.starts_with?(file_binary, signature)
      end)
      |> case do
        {_, %{media_type: media_type}} -> media_type
        _ -> nil
      end
    end

    def type_from_binary(_file_binary), do: nil

    def verify(file_binary, extension) do
      ext_type = type_from_extension(extension)
      binary_type = type_from_binary(file_binary)

      if not is_nil(ext_type) and not is_nil(binary_type) and ext_type == binary_type do
        {:ok, ext_type}
      else
        {:error, "Warning, file format and file extension do not match."}
      end
    end
  end
end
