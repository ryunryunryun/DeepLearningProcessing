public class NeuralNetwork {
  public ArrayList<ArrayList<Node>> layers;
  
  public NeuralNetwork (int inputLayerSize, int hiddenLayerNum, int hiddenLayerSize, int outputLayerSize) {
    layers = new ArrayList<ArrayList<Node>>();
    
    // initialization
    for (int l = 0; l < hiddenLayerNum + 2; l++) {
      layers.add(new ArrayList<Node>());
    }
    
    // inputLayer initialization
    for (int i = 0; i < inputLayerSize; i++) {
      layers.get(0).add(new Node(1, hiddenLayerSize));
    }
    
    // hiddenLayer initialization
    for (int h = 0; h < hiddenLayerNum; h++) {
      for (int s = 0; s < hiddenLayerSize; s++) {
        // at first hidden layer
        if (h == 0) {
          if (hiddenLayerNum > 1) {
            layers.get(h + 1).add(new Node(inputLayerSize, hiddenLayerSize));
          }
          else {
            layers.get(h + 1).add(new Node(inputLayerSize, outputLayerSize));
          }
        }
        // at last hiddenlayer
        else if (h == hiddenLayerNum - 1) {
          layers.get(h + 1).add(new Node(hiddenLayerSize, outputLayerSize));
        }
        // other hidden layers
        else {
          layers.get(h + 1).add(new Node(hiddenLayerSize, hiddenLayerSize));
        }
      }
    }
    
    // output layer initialization
    for (int o = 0; o < outputLayerSize; o++) {
      layers.get(layers.size() - 1).add(new Node(hiddenLayerSize, 1));
    }
  }
  
  // calculate this system with given input
  public float[] calculateOutput (float[] input) {
    float[] output = new float[getOutputLayer().size()];
    
    // input signal
    for (int i = 0; i < getInputLayer().size(); i++) {
      getInputLayer().get(i).renewInputSignal(0, input[i]);
      
      // pass all the values to next layer
      for (int h = 0; h < getNthLayer(1).size(); h++) {
        getNthLayer(1).get(h).renewInputSignal(i, input[i] * getInputLayer().get(i).getWeight(h));
      }
    }
    
    // manipulate hidden layer signals
    for (int l = 1; l < layers.size() - 1; l++) {
      for (int n = 0; n < getNthLayer(l).size(); n++) {
        getNthLayer(l).get(n).calculateOutputSignal();
        
        // put nth layers output to (n + 1)th layers input
        for (int a = 0; a < getNthLayer(l + 1).size(); a++) {
          getNthLayer(l + 1).get(a).renewInputSignal(n, getNthLayer(l).get(n).getNthOutputSignal(a));
        }
      }
    }
    
    // calculate and get output signal of output layer
    for (int n = 0; n < getOutputLayer().size(); n++) {
      getOutputLayer().get(n).calculateOutputSignal();
      
      output[n] = getOutputLayer().get(n).getOutputSignal();
    }
    
    return output;
  }
  
  // return input layer
  private ArrayList<Node> getInputLayer () {
    return layers.get(0);
  }
  
  // return nth layer
  private ArrayList<Node> getNthLayer (int n) {
    return layers.get(n);
  }
  
  // return output layer
  private ArrayList<Node> getOutputLayer () {
    return layers.get(layers.size() - 1);
  }
}