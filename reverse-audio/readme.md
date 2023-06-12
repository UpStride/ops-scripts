## Reverse Audio Files

Convert audio files from a directory (a-b-c-d) to:
.reversed/ (d-c-b-a)
.palindromic/ (a-b-c-d-d-c-b-a)
.palindromic-50/ (same as palindromic played at 50% speed) 

*Note: only .wav files are supported.*

**run the script**
```bash
bash reverse-audio/run -s target_directory

#Example:
 
bash reverse-audio/run -s /c/Users/marce/Maths/Data/Audio/Mix
```