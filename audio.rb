##| Initialize variables
use_bpm 70

##| Initialize parts
opening_treble_n = [:d5, :g5, :f5, :e5, :d5, :a5, :f5, :e5].ring
closing_treble_n = [:d4, :g4, :f4, :e4, :d4, :a4, :f4, :e4].ring
opening_bass_n = [:d3, :a3, :d3, :c3].ring
melody_n = [:d5, :f5, :g5, :g5, :a5, :d5, :f5, :e5, :c5, [:d5, :bb4], :f4, :a4].ring
melody_r = [3, 0.5, 0.5, 1.5, 0.5, 2, 1.5, 0.5, 2, 3, 0.5, 0.5].ring
melody_2_n = [[:f4, :a4, :d5], [:f4, :c5], [:f4, :f5], [:c5, :c6], :f5, :e5, :c5, [:bb4, :d5], :f4, :a4]
melody_2_r = [2, 2, 2, 2, 1.5, 0.5, 2, 3, 0.5, 0.5]
bass_1_simple_n = [:d3, :d2, :f2, :c3, :d3, :d2, :f2, :a3,
                   :d3, :d2, :f2, :a3, :d3, :d2, :f2, :c3].ring
bass_1_simple_r = [1, 1.5, 1, 0.5].ring
bass_1_n = [:d3, :f3, :a3, :d2, :f2, :a2, :c3, :e3, :d4, :f4, :a4, :d2, :f2, :a2, :c3, :e3,
            :d3, :f3, :a3, :d2, :f2, :a2, :c3, :e3, :d4, :f4, :a4, :d2, :f2, :a2, :c3, :e3].ring
bass_1_r = [0.5, 0.25, 0.25, 1.5, 0.5, 0.5, 0.25, 0.25].ring
bass_2_n = [:a3, :d4, :a3, :d4, [:a3, :e4], :f4, :bb3, :f3].ring
bass_2_r = [3, 1, 2, 2, 2, 2, 3, 1].ring
treble_1_simple_n = [:f5, :a4, :d5, :a4, :r, :d5, :a4, :c5, :e5,
                     :r, :d5, :a4, :d5, :a4,
                     :f5, :a4, :d5, :a4, :r, :c5, :d5, :c5, :D5,
                     :d5, :d5, :c5, :d5, :r, :d5, :e5, :f5, :a5].ring
treble_1_simple_r = [0.25, 0.25, 0.25, 0.25, 2, 0.25, 0.25, 0.25, 0.25,
                     3, 0.25, 0.25, 0.25, 0.25,
                     0.25, 0.25, 0.25, 0.25, 2, 0.25, 0.25, 0.25, 0.25,
                     0.25, 0.25, 0.25, 0.25, 2, 0.25, 0.25, 0.25, 0.25].ring
treble_1_n = [:f5, :a4, :d5, :a4, :f5, :a4, :d5, :a4, :f5, :a4, :f5, :d5, :a4, :d5, :g5, :a5,
              :d5, :a4, :d5, :a4, :d5, :a4, :d5, :a4, :d5, :a4, :d5, :a4, :f5, :a4, :d5, :a4,
              :e5, :a4, :d5, :a4, :e5, :a4, :d5, :a4, :c5, :a4, :c5, :a4, :c5, :d5, :c5, :d5,
              :d5, :d5, :c5, :d5, :c5, :d5, :c5, :d5, :bb4, :d5, :bb4, :d5, :d5, :e5, :f5, :a5].ring
interlude_n = [:r, :d2, :f2, :a2, :d3, :a2, :d2, :f2, :a2, :d3, :a2].ring
interlude_r = [1, 1.5, 0.5, 0.5, 0.25, 0.25, 2.5, 0.5, 0.5, 0.25, 0.25].ring
bass_3_n = [[:f3, :d4], [:g3, :e4, :g4], [:a3, :d4, :f4], [:g3, :e4], :d4, :a4, :f4, :e4].ring

##| Initialize layer properties with form [notes, rhythmn, synth, volume]
opening_treble = [opening_treble_n, [2].ring, :piano, 0.6]
closing_treble = [closing_treble_n, [2].ring, :piano, 0.6]
opening_bass = [opening_bass_n, [4].ring, :piano, 1]
melody = [melody_n, melody_r, :piano, 1]
melody_2 = [melody_2_n, melody_2_r, :piano, 1]
bass_1_simple = [bass_1_simple_n, bass_1_simple_r, :piano, 0.5]
bass_1 = [bass_1_n, bass_1_r, :piano, 0.8]
bass_2 = [bass_2_n, bass_2_r, :sine, 0.5]
bass_3 = [bass_3_n, [2].ring, :piano, 0.7]
treble_1_simple = [treble_1_simple_n, treble_1_simple_r, :piano, 0.6]
treble_1 = [treble_1_n, [0.25].ring, :piano, 0.9]
interlude = [interlude_n, interlude_r, :piano, 0.8]

##| Plays a layer, repeating the given number of times
##| layer -- layer properties with form [notes, rhythmn, synth, volume]
##| repeat -- number of times to repeat the layer
define :play_layer do |layer, repeat|
  notes = layer[0]
  rythmn = layer[1]
  synth = layer[2]
  volume = layer[3]
  in_thread do
    repeat.times do
      counter = 0
      use_synth synth
      notes.length().times do
        play notes[counter], amp: volume
        sleep rythmn[counter]
        counter += 1
      end
    end
  end
end

##| Plays layers in order, adding one more layer per phrase
##| layer_order -- list of layers in order [[layer, repeat]]
##|             A repeat value of 0 indicates the layer should
##|             continue looping for the entire duration.  
##| total_phrases -- the number of total phrases to play. 
define :gradual_overlay do |layer_order, total_phrases|
  l = 0
  phrases_remaining = total_phrases
  layer_order.length().times do
    layer = layer_order[l][0]
    repeat = layer_order[l][1]
    if repeat == 0
      play_layer(layer, phrases_remaining)
      sleep 16
    else
      play_layer(layer, repeat)
      sleep 16 * repeat
    end
    l += 1
    phrases_remaining -= 1
  end
end


##| PLAY SONG

# Opening
play_layer(opening_treble, 1)
play_layer(opening_bass, 1)
sleep 16
play_layer(bass_1_simple, 1)
sleep 16

# Figure 1
layer_order = [[bass_1, 0], [melody, 0], [bass_2, 0], [treble_1_simple, 2], [treble_1, 2]]
gradual_overlay(layer_order, 7)

# Interlude
play_layer(interlude, 1)
sleep 8

# Generate 2 phrases from 3 sets of random notes
rand_1 = Array.new(8)
rand_2 = Array.new(8)
rand_3 = Array.new(8)
r = 0
rand_1.length().times do
  rand_1[r] = choose(treble_1_n)
  rand_2[r] = choose(treble_1_simple_n)
  rand_3[r] = choose(treble_1_n)
  r += 1
end

rand_n = rand_1 + rand_1 + rand_2 + rand_2
rand_n_2 = rand_3 + rand_3 + rand_3 + rand_3

rand_1 = [rand_n, [0.5].ring, :piano, 0.5]
rand_2 = [rand_n_2, [0.5].ring, :piano, 0.5]

# Figure 2
layer_order = [[bass_1_simple, 0], [bass_2, 0], [rand_1, 0],
               [rand_2, 0], [treble_1_simple, 2], [treble_1, 1]]
gradual_overlay(layer_order, 7)


# Figure 3
parts = [melody_2, bass_1, bass_2, treble_1, rand_1].ring
f = 0
2.times do
  parts.length().times do
    layer = parts[f]
    play_layer(layer, 1)
    f += 1
  end
  sleep 16
end

# Interlude
play_layer(interlude, 1)
sleep 8
bass_2[3] = 0.5

# Ending
play_layer(bass_1_simple, 3)
sleep 16
play_layer(bass_2, 1)
sleep 16
play_layer(bass_3, 1)
sleep 16
play_layer(closing_treble, 1)
play_layer(opening_bass, 1)




