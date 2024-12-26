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
        ?A -> 0b0001
        ?C -> 0b0010
        ?G -> 0b0100
        ?T -> 0b1000
        " " -> 0b0000
      end
    end

    def decode_nucleotide(encoded_code) do
      case encoded_code do
        0b0001 -> ?A
        0b0010 -> ?C
        0b0100 -> ?G
        0b1000 -> ?T
        0b0000 -> " "
      end
    end

    def encode(dna) do
      dna
      |> Enum.map(&encode_nucleotide/1)
      |> Enum.reduce(<<>>, fn encoded, acc -> <<acc::bitstring, encoded::4>> end)
    end

    def decode(dna) do
      dna
      |> Enum.map(&decode_nucleotide/1)
      |> Enum.reduce(<<>>, fn decoded, acc -> <<acc::bitstring, decoded::8>> end)
    end
  end
end
