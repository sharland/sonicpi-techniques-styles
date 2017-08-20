#slidiing arpeggios by Robin Newman 7th December 2014
#This piece generates major and minor arpeggios in C major and Minor
#created with different random octave settings
#and incorporates them with a sliding note and a variable cutoff
#each with a rising volume,
#using three separate synth voices, which is repeated 10 times
#before finishing with a C major chord
#the whole has a reverb effect added
maj=[:c4,:e4,:g4,:c5,:e5,:g5,:c6]
min=[:c4,:eb4,:g4,:c5,:eb5,:g5,:c6]
with_fx :reverb,room: 0.8 do
  10.times do
    cur=[maj,min].choose #choose major or minor chords
    sh=rrand_i(-7,7) #set transpose shift
    in_thread do
      use_synth :dsaw #first synth
      m=play :c3,note_slide: 0.1,sustain: 5,amp: 1.0/25, cutoff: 67,cutoff_slide: 0.1

      1.upto(25) do |v1| #swell volume (convert to float before dividing by 25 later)a
        sleep 0.2
        control m, note: note(cur.choose)+sh,cutoff: [60,70].choose,amp:  v1.to_f/25,pan: [-1,0,1].choose
      end
    end
    sleep 0.1
    in_thread do
      use_synth :fm #second synth
      n=play :c3,note_slide: 0.1,sustain: 5,amp: 1.0/25, cutoff: 67,cutoff_slide: 0.1
      1.upto(25) do |v2| #swell volume (convert to float before dividing by 25 later)
        sleep 0.2
        control n, note: note(cur.choose)+sh,cutoff: [60,70].choose,amp:  v2.to_f/25,pan: [-1,0,1].choose
      end
    end
    sleep 0.1
    use_synth :tb303 #third synth
    o=play :c3,note_slide: 0.1,sustain: 5,amp: 1.0/25, cutoff: 67,cutoff_slide: 0.1
    1.upto(25) do |v3| #swell volume (convert to float before dividing by 25 later)
      sleep 0.2
      control o, note: note(cur.choose)+sh,cutoff: [60,70].choose,amp: v3.to_f/25,pan: [-1,0,1].choose
    end
    sleep 0.1
  end
  sleep 1
  play maj,amp: 0.4,attack: 2,release: 2 #final chord rises and falls
end
