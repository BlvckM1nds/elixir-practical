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
end
