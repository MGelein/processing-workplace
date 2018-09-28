/**
 Holds all the sound methods
 **/
class Sound {
  //The music during play
  AudioSample playMusic;
  //The music during menu
  AudioSample menuMusic;
  //The first impact
  AudioSample impact1;
  //The second impact
  AudioSample impact2;

  //Load the first sounds
  public Sound(PApplet parent) {
    //Load all sound files
    playMusic = new SoundFile(parent, "background.wav");
    menuMusic = new SoundFile(parent, "menumusic.wav");
    impact1 = new SoundFile(parent, "impact1.wav");
    impact2 = new SoundFile(parent, "impact2.wav");
  }

  //Stary playing the in game music
  void startPlay() {
    //Change BG music
    menuMusic.stop();
    if (!playMusic.isPlaying())playMusic.loop();
    //And play the impact
    impact1.play();
  }

  //Start playing the tranquil menu music
  void startMenu() {
    if (!menuMusic.isPlaying()) menuMusic.loop();
    playMusic.stop();
    //And play the impact, if we have just lost
    if (player != null && player.score > 0) impact2.play();
  }
}
