// only for f: R -> R
// size(600, 600);
public class Graph {
  public float[] domain;
  public float[] range;
  public float dx;
  public float[] fValues;
  
  public float[] shrinkedfValues;
  public float[] neuralNetworkValues;
  
  public Graph (float domainMin, float domainMax, float dx, TeacherFunction teacher) {
    domain = new float[2];
    domain[0] = domainMin;
    domain[1] = domainMax;
    range = new float[2];
    range[0] = 0;
    range[1] = 0;
    
    this.dx = dx;
    
    fValues = new float[(int)((domainMax - domainMin) / dx)];
    shrinkedfValues = new float[fValues.length];
    neuralNetworkValues = new float[fValues.length];
    
    float[] input = new float[1];
    
    for (int i = 0; i < fValues.length; i++) {
      input[0] = i * dx + domainMin;
      fValues[i] = teacher.function(input)[0];
      
      range[0] = min(range[0], fValues[i]);
      range[1] = max(range[1], fValues[i]);
    }
    
    for (int i = 0; i < fValues.length; i++) {
      shrinkedfValues[i] = map(fValues[i], range[0], range[1], 0, 1);
    }
  }
  
  // draw given function
  public void drawThisFunction () {
    stroke(0);
    background(255);
    fill (255);
    rect (100, 100, 400, 400);
    
    fill(0);
    
    
    for (int i = 0; i < fValues.length - 1; i++) {
      line(map(i * dx + domain[0], domain[0], domain[1], 100, 500), map(shrinkedfValues[i], 0, 1, 500, 100),
             map((i + 1) * dx + domain[0], domain[0], domain[1], 100, 500), map(shrinkedfValues[i + 1], 0, 1, 500, 100));
    }
  }
  
  // draw neural network
  public void drawNeuralNetwork (NeuralNetwork nn) {
    float[] input = new float[1];
    for (int i = 0; i < neuralNetworkValues.length; i++) {
      input[0] = i * dx + domain[0];
      nn.calculateOutput(input);
      
      neuralNetworkValues[i] = nn.getOutputLayer().get(0).getOutputSignal();
    }
    
    stroke (255, 0, 0);
    for (int i = 0; i < neuralNetworkValues.length - 1; i++) {
      line(map(i * dx + domain[0], domain[0], domain[1], 100, 500), map(neuralNetworkValues[i], 0, 1, 500, 100),
             map((i + 1) * dx + domain[0], domain[0], domain[1], 100, 500), map(neuralNetworkValues[i + 1], 0, 1, 500, 100));
    }
  }
}