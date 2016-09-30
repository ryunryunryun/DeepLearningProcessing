public class Node {
  private float[] inputSignalAndWeightCombined;
  private float inputSignalSum;
  public float outputSignal;
  public float[] weightList;
  public float[] weightAndOutputSignalCombined;
  public float delta;
  
  public Node (int inputAmount, int outputAmount) {
    inputSignalAndWeightCombined = new float[inputAmount];
    weightList = new float[outputAmount];
    weightAndOutputSignalCombined = new float[outputAmount];
    
    // randomize weight list at first
    // should be (0, 1 * inputAmount)
    for (int i = 0; i < outputAmount; i++) {
      weightList[i] = random(0.001);
    }
  }
  
  // return output signal
  public float getOutputSignal () {
    return this.outputSignal;
  }
  
  // input!
  public void renewInputSignal (int input, float signalAndWeight) {
    inputSignalAndWeightCombined[input] = signalAndWeight;
  }
  
  // renew weight
  public void renewWeightBy (int n, float weightDiff) {
    weightList[n] += weightDiff;
  }
  
  // get input
  public float getInputSignal (int input) {
    return inputSignalAndWeightCombined[input];
  }
  
  // get weight
  public float getWeight (int which) {
    return weightList[which];
  }
  
  // get weight and ouptut combined
  public float getWeightCombined (int which) {
    return weightAndOutputSignalCombined[which];
  }
   
  // get sum of input signal 
  public float getInputSignalSum () {
    return inputSignalSum;
  }
  
  // set delta
  public void setDelta (float delta) {
    this.delta = delta;
  }
  
  // get delta
  public float getDelta () {
    return this.delta;
  }
  
  
  // calculate output signal using a sigmoid function
  public void calculateOutputSignal () {
    float sum = 0;
    for (int i = 0; i < inputSignalAndWeightCombined.length; i++) {
      sum += inputSignalAndWeightCombined[i];
    }
    
    inputSignalSum = sum;
    
    outputSignal = 1 / (1 + exp(sum));
    
    for (int i = 0; i < weightAndOutputSignalCombined.length; i++) {
      weightAndOutputSignalCombined[i] = weightList[i] * outputSignal;
    }
  }
  
  // get ith output signal
  public float getNthOutputSignal(int n) {
    return weightAndOutputSignalCombined[n];
  }
}