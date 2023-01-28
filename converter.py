import easygui
from mido import MidiFile
import damp11113

stime = 0.1

# -----------------------------------------------
midi_file = easygui.fileopenbox(filetypes=['*.mid', '*.midi'], title='Select a MIDI file', default='*.mid')
try:
    if midi_file.endswith('.mid'):
        pass
    elif midi_file.endswith('.midi'):
        pass
    else:
        print('File type not supported')
        exit()
except:
    exit()

filename = midi_file.split("\\")[-1].split('.')[0].replace(' ', '_')

# -----------------------------------------------
sccmidi = easygui.filesavebox(filetypes=['*.ccmidi'], title='Select a Save ccmidi file path', default=f'{filename}.ccmidi')
try:
    sccmidi.split('.')[1]
except:
    sccmidi = sccmidi + '.ccmidi'
# -----------------------------------------------
p1 = damp11113.loading1('loading midi', "[OK] loaded", fail="[FAIL] cannot load midi").start()
try:
    mididata = MidiFile(midi_file, clip=True)
    p1.stop()
except:
    p1.stopfail()
# -----------------------------------------------
p2 = damp11113.loading1('converting midi to ccmidi', "[OK] converted", fail="[FAIL] convert fail").start()
datalist = []
count = 0
try:
    for key in mididata:
        if key.type == 'note_on':
            note = damp11113.number2note(key.note)
            note = str(note[0])
            time = key.time
            if time == 0:
                data = f'note_on {key.channel} {note} {stime} {count}'
            elif time <= 0.1:
                time = time + stime
                data = f'note_on {key.channel} {note} {time} {count}'
            else:
                data = f'note_on {key.channel} {note} {time} {count}'
            datalist.append(data)
            count += 1
        elif key.type == 'note_off':
            note = damp11113.number2note(key.note)
            note = str(note[0])
            time = key.time
            if time == 0:
                data = f'note_off {key.channel} {note} {stime} {count}'
            elif time <= 0.1:
                time = time + stime
                data = f'note_off {key.channel} {note} {time} {count}'
            else:
                data = f'note_off {key.channel} {note} {time} {count}'
            datalist.append(data)
            count += 1
    p2.stop()
except Exception as e:
    print(e)
    p2.stopfail()
# -----------------------------------------------
p3 = damp11113.loading1('writing ccmidi', "[OK] ccmidi", fail="[FAIL] cannot write ccmidi").start()

try:
    newdatalist = []

    countlist = len(datalist)-1

    newdatalist.append(f'{datalist[0]} {countlist} {filename} start')

    for i in datalist[1:]:
        newdatalist.append(f'{i} {countlist} {filename} playing')

    last = newdatalist.pop(-1)

    newdatalist.append(last.replace('playing', 'stop'))

    damp11113.writefile2(sccmidi, damp11113.list2str(newdatalist))
    p3.stop()
except:
    p3.stopfail()
