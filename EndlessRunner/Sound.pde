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
  //The fft object
  FFT fft;
  //Amt of bands on the FFT spectrum
  int bands = 32;
  //The float that contains the spectrum analysis
  float[] spectrum = new float[bands];
  float[] smoothSpectrum = new float[bands];
  //The width of one band on the eq
  float bandWidth;

  //Load the first sounds
  public Sound(PApplet parent) {
    //Load all sound files
    playMusic = new SoundFile(parent, "background.wav");
    menuMusic = new SoundFile(parent, "menumusic.wav");
    impact1 = new SoundFile(parent, "impact1.wav");
    impact2 = new SoundFile(parent, "impact2.wav");
    //Create the FFT with 'bands' amount of bands
    fft = new FFT(parent, bands);
    bandWidth = width / bands;
  }

  //Stary playing the in game music
  void startPlay() {
    //Change BG music
    menuMusic.stop();
    if (!playMusic.isPlaying())playMusic.loop();
    //And play the impact
    impact1.play();
    //Set the playMusic to be the analyzed source
    fft.input(playMusic);
  }
  
  //Draw FFT spectrum analysis
  void render(){
    //Do the analysis
    fft.analyze(spectrum);
    //Smooth with the display spectrum
    for(int i = 0; i < bands; i++){
      //Make the spectrum ease between values
      smoothSpectrum[i] += (spectrum[i] - smoothSpectrum[i]) * 0.2f;
    }
    //Now draw all the bars
    fill(gameColor, 30);
    noStroke();
    //stroke(gameColor, 100);
    strokeWeight(2);
    int i = 0;
    for(float x = width / 2; x > circle.radius; x -= bandWidth){
      rect(x - bandWidth / 2, 0, bandWidth, smoothSpectrum[i] * 1000 * (i + 1));
      rect(-x + bandWidth / 2, 0, bandWidth, smoothSpectrum[i] * 1000 * (i + 1));
      i++;
    }
    
  }

  //Start playing the tranquil menu music
  void startMenu() {
    if (!menuMusic.isPlaying()) menuMusic.loop();
    playMusic.stop();
    //Set the menuMusic to be the analyzed music
    fft.input(menuMusic);
    //And play the impact, if we have just lost
    if (player != null && player.score > 0) impact2.play();
  }
}
