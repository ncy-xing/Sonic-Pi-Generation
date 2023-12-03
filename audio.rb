# Initialize variables
use_bpm 70

# Initialize parts
opening_treble = [:d5, :g5, :f5, :e5, :d5, :a5, :f5, :e5].ring
closing_treble = [:d4, :g4, :f4, :e4, :d4, :a4, :f4, :e4].ring
opening_bass = [:d3, :a3, :d3, :c3].ring
melody = [:d5, :f5, :g5, :g5, :a5, :d5, :f5, :e5, :c5, [:d5, :bb4], :f4, :a4].ring
melody_r = [3, 0.5, 0.5, 1.5, 0.5, 2, 1.5, 0.5, 2, 3, 0.5, 0.5].ring
melody_2 = [[:f4, :a4, :d5], [:f4, :c5], [:f4, :f5], [:c5, :c6], :f5, :e5, :c5, [:bb4, :d5], :f4, :a4]
melody_2_r = [2, 2, 2, 2, 1.5, 0.5, 2, 3, 0.5, 0.5]


bass_1_simple = [:d3, :d2, :f2, :c3, :d3, :d2, :f2, :a3,
                 :d3, :d2, :f2, :a3, :d3, :d2, :f2, :c3].ring
bass_1_simple_r = [1, 1.5, 1, 0.5].ring
bass_1 = [:d3, :f3, :a3, :d2, :f2, :a2, :c3, :e3, :d4, :f4, :a4, :d2, :f2, :a2, :c3, :e3,
          :d3, :f3, :a3, :d2, :f2, :a2, :c3, :e3, :d4, :f4, :a4, :d2, :f2, :a2, :c3, :e3].ring
bass_1_r = [0.5, 0.25, 0.25, 1.5, 0.5, 0.5, 0.25, 0.25].ring
bass_2 = [:a3, :d4, :a3, :d4, [:a3, :e4], :f4, :bb3, :f3].ring
bass_2_r = [3, 1, 2, 2, 2, 2, 3, 1].ring

treble_1_simple = [:f5, :a4, :d5, :a4, :r, :d5, :a4, :c5, :e5,
                   :r, :d5, :a4, :d5, :a4,
                   :f5, :a4, :d5, :a4, :r, :c5, :d5, :c5, :D5,
                   :d5, :d5, :c5, :d5, :r, :d5, :e5, :f5, :a5].ring
treble_1_simple_r = [0.25, 0.25, 0.25, 0.25, 2, 0.25, 0.25, 0.25, 0.25,
                     3, 0.25, 0.25, 0.25, 0.25,
                     0.25, 0.25, 0.25, 0.25, 2, 0.25, 0.25, 0.25, 0.25,
                     0.25, 0.25, 0.25, 0.25, 2, 0.25, 0.25, 0.25, 0.25].ring
treble_1 = [:f5, :a4, :d5, :a4, :f5, :a4, :d5, :a4, :f5, :a4, :f5, :d5, :a4, :d5, :g5, :a5,
            :d5, :a4, :d5, :a4, :d5, :a4, :d5, :a4, :d5, :a4, :d5, :a4, :f5, :a4, :d5, :a4,
            :e5, :a4, :d5, :a4, :e5, :a4, :d5, :a4, :c5, :a4, :c5, :a4, :c5, :d5, :c5, :d5,
            :d5, :d5, :c5, :d5, :c5, :d5, :c5, :d5, :bb4, :d5, :bb4, :d5, :d5, :e5, :f5, :a5].ring

interlude = [:r, :d2, :f2, :a2, :d3, :a2, :d2, :f2, :a2, :d3, :a2].ring
interlude_r = [1, 1.5, 0.5, 0.5, 0.25, 0.25, 2.5, 0.5, 0.5, 0.25, 0.25].ring

bass_3 = [[:f3, :d4], [:g3, :e4, :g4], [:a3, :d4, :f4], [:g3, :e4], :d4, :a4, :f4, :e4].ring


define :play_layer do |notes, rythmn, synth, repeat|
  in_thread do
    repeat.times do
      counter = 0
      use_synth synth
      notes.length().times do
        play notes[counter]
        sleep rythmn[counter]
        counter += 1
      end
    end
  end
end

# 0 means loop until the end of the figure
layer_order = [[bass_1, bass_1_r, 0], [melody, melody_r, 0], [bass_2, bass_2_r, 0],
               [treble_1_simple, treble_1_simple_r, 2], [treble_1, [0.25].ring, 2]]

# Opening
play_layer(opening_treble, [2].ring, :piano, 1)
play_layer(opening_bass, [4].ring, :piano, 1)
sleep 16
play_layer(bass_1_simple, bass_1_simple_r, :piano, 1)
sleep 16

# Figure 1
l = 0
phrases_remaining = 7
layer_order.length().times do
  layer = layer_order[l]
  repeat = layer[2]
  if repeat == 0
    play_layer(layer[0], layer[1], :piano, phrases_remaining)
    sleep 16
  else
    play_layer(layer[0], layer[1], :piano, repeat)
    sleep 16 * repeat
  end
  l += 1
  phrases_remaining -= 1
end

# Interlude
play_layer(interlude, interlude_r, :piano, 1)
sleep 8

# Generate 2 phrases from 3 sets of random notes
rand_1 = Array.new(8)
rand_2 = Array.new(8)
rand_3 = Array.new(8)
r = 0
rand_1.length().times do
  rand_1[r] = choose(treble_1)
  rand_2[r] = choose(treble_1_simple)
  rand_3[r] = choose(treble_1)
  r += 1
end

rand_phrase = rand_1 + rand_1 + rand_2 + rand_2
rand_phrase_2 = rand_3 + rand_3 + rand_3 + rand_3

layer_order = [[bass_1_simple, bass_1_simple_r, 0], [bass_2, bass_2_r, 0],
               [rand_phrase, [0.5].ring, 0], [rand_phrase_2, [0.5].ring, 0],
               [treble_1, [0.25].ring, 2]]

# Generated Interlude
l = 0
phrases_remaining = 6
layer_order.length().times do
  layer = layer_order[l]
  repeat = layer[2]
  if repeat == 0
    play_layer(layer[0], layer[1], :piano, phrases_remaining)
    sleep 16
  else
    play_layer(layer[0], layer[1], :piano, repeat)
    sleep 16 * repeat
  end
  l += 1
  phrases_remaining -= 1
end

# Figure 2
parts = [[closing_treble, [2].ring, :piano, 2], [bass_1, bass_1_r, 0],
         [rand_phrase, [0.5].ring, 0]]
f = 0
parts.length().times do
  layer = parts[f]
  play_layer(layer[0], layer[1], :piano, 2)
  f += 1
end

# Figure 3
parts = [[melody_2, melody_2_r, :piano, 2], [bass_1, bass_1_r, 0],
         [bass_2, bass_2_r, 0], [treble_1, [0.25].ring, 2],
         [rand_phrase, [0.5].ring, 0]]
f = 0
parts.length().times do
  layer = parts[f]
  play_layer(layer[0], layer[1], :piano, 2)
  f += 1
end
sleep 32

# Interlude
play_layer(interlude, interlude_r, :piano, 1)
sleep 8

# Ending
play_layer(bass_1_simple, bass_1_simple_r, :piano, 3)
sleep 16
play_layer(bass_2, bass_2_r, :piano, 1)
sleep 16
play_layer(bass_3, [2].ring, :piano, 1)
sleep 16
play_layer(closing_treble, [2].ring, :piano, 1)
play_layer(opening_bass, [4].ring, :piano, 1)



