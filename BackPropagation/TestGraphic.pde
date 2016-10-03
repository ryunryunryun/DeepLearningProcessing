// this class is used for see the neural network calcualtion flow visually
// set size(600, 600);
public class TestGraphic {
  // NeuralNetwork (int inputLayerSize, int hiddenLayerNum, int hiddenLayerSize, int outputLayerSize)
  public NeuralNetwork nn = new NeuralNetwork (2, 3, 4, 3);
  public float radius = 10;
  
  public TestGraphic () {
    float[] input = {0.5, 0.4};
    nn.calculateOutput (input);
  }
    
  // draw the input flow
  public void update () {
    background(255);
    
    textAlign(CENTER, CENTER);
    
    for (int i = 0; i < nn.layers.size() - 1; i++) {
      for (int n = 0; n < nn.getNthLayer(i).size(); n++) {
        for (int o = 0; o < nn.getNthLayer(i + 1).size(); o++) {
          fill(100, 10);
          line (600 / (float)(nn.layers.size() + 1) * (i + 1), 600 / (float)(nn.getNthLayer(i).size() + 1) * (n + 1),
                  600 / (float)(nn.layers.size() + 1) * (i + 2), 600 / (float)(nn.getNthLayer(i + 1).size() + 1) * (o + 1));
        }
      }
    }
    
    stroke(0);
   
    for (int i = 0; i < nn.layers.size(); i++) {
      for (int n = 0; n < nn.getNthLayer(i).size(); n++) {
        fill (100);
        ellipse (600 / (float)(nn.layers.size() + 1) * (i + 1), 600 / (float)(nn.getNthLayer(i).size() + 1) * (n + 1), radius, radius);
        fill (0);
        text(nn.getNthLayer(i).get(n).getOutputSignal(), 600 / (float)(nn.layers.size() + 1) * (i + 1),
               600 / (float)(nn.getNthLayer(i).size() + 1) * (n + 1) - radius);
      }
    }
    
    hober ();
  }
  
  // if hobering on certain node, it shows the status
  public void hober () {
    fill(255, 0, 0);
    for (int i = 0; i < nn.layers.size(); i++) {
      for (int n = 0; n < nn.getNthLayer(i).size(); n++) {
        if (sq(mouseX - 600 / (float)(nn.layers.size() + 1) * (i + 1)) + sq (mouseY - 600 / (float)(nn.getNthLayer(i).size() + 1) * (n + 1)) < sq(radius)) {
          if (i == 0) {
            text(nn.getInputLayer().get(n).getInputSignal(0), 600 / (float)(nn.layers.size() + 1) * (i + 1) - radius * 1.5,
                   600 / (float)(nn.getNthLayer(i).size() + 1) * (n + 1));
          }
          else {
            text(nn.getNthLayer(i).get(n).getInputSignalSum(), 600 / (float)(nn.layers.size() + 1) * (i + 1) - radius * 1.5,
                   600 / (float)(nn.getNthLayer(i).size() + 1) * (n + 1));
          }
          
          if (i < nn.layers.size() - 1) {
            for (int o = 0; o < nn.getNthLayer(i + 1).size(); o++) {
              text(nn.getNthLayer(i).get(n).getWeight(o), 
                     (1200 / (float)(nn.layers.size() + 1) * (i + 1) + 600 / (float)(nn.layers.size() + 1) * (i + 2)) / 3.0,
                     (1200 / (float)(nn.getNthLayer(i).size() + 1) * (n + 1) + 600 / (float)(nn.getNthLayer(i + 1).size() + 1) * (o + 1)) / 3);
            }
          }
          return;
        }
      }
    }
  }
}