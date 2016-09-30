public class BackPropagationMethod {
  public float learningRate;
  // domain
  private float[] rangeMin;
  private float[] rangeMax;
  private TeacherFunction teacher;
  public int generation = 0;
  
  public BackPropagationMethod (float[] rangeMin_, float[] rangeMax_, TeacherFunction teacher, float learningRate) {
    rangeMin = new float[rangeMin_.length];
    rangeMax = new float[rangeMax_.length];
    
    for (int i = 0; i < rangeMin.length; i++) {
      rangeMin[i] = rangeMin_[i];
      rangeMax[i] = rangeMax_[i];
    }
    this.teacher = teacher;
    this.learningRate = learningRate;
  }
  
  // returns teacher function
  public TeacherFunction getTeacherFunction () {
    return teacher;
  }
  
  // do one cycle of back propagation
  public void backPropagate (NeuralNetwork nn, float[] range) {
    float[] randomInput = new float[rangeMin.length];
    for (int i = 0; i < randomInput.length; i++) {
      randomInput[i] = random (rangeMin[i], rangeMax[i]) / (rangeMax[i] - rangeMin[i]);
    }
    
    float[] output = nn.calculateOutput(randomInput);
    
    float[] teacherOutput = new float[teacher.function(randomInput).length];
    
    for (int i = 0; i < teacherOutput.length; i++) {
      teacherOutput[i] = map(teacher.function(randomInput)[i], range[0], range[1], 0, 1);
    }
   
    
    // last layer : renew weight connected to last layer
    for (int n = 0; n < nn.getOutputLayer().size(); n++) {
      for (int p = 0; p < nn.getNthLayer(nn.layers.size() - 2).size(); p++) {
        nn.getOutputLayer().get(n).setDelta(- (teacherOutput[n] - output[n]) * output[n] * (1 - output[n]));
        
        nn.getNthLayer(nn.layers.size() - 2).get(p)
            .renewWeightBy(n, -learningRate * nn.getOutputLayer().get(n).getDelta() * nn.getNthLayer(nn.layers.size() - 2).get(p).getOutputSignal());
      }
    }
    
    float tempSum = 0;
    // other layer
    for (int l = nn.layers.size() - 2; l > 1; l--) {
      for (int j = 0; j < nn.getNthLayer(l).size(); j++) {
        // set delta
        tempSum = 0;
        
        for (int p = 0; p < nn.getNthLayer(l + 1).size(); p++) {
          tempSum += nn.getNthLayer(l + 1).get(p).getDelta() * nn.getNthLayer(l).get(j).getWeight(p);
        } 
        nn.getNthLayer(l).get(j).setDelta(tempSum * nn.getNthLayer(l).get(j).getOutputSignal() * (1 - nn.getNthLayer(l).get(j).getOutputSignal()));
        
        // renew weight
        for (int k = 0; k < nn.getNthLayer(l - 1).size(); k++) {
          nn.getNthLayer(l - 1).get(k).renewWeightBy(j, - learningRate * nn.getNthLayer(l).get(j).getDelta() * nn.getNthLayer(l - 1).get(k).getOutputSignal());
        }
      }
    }
    
    
    
    generation ++;
  }
}