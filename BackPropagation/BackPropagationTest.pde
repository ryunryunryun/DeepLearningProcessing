public class BackPropagationTest {
  public Graph g;
  public NeuralNetwork nn;
  public BackPropagationMethod bp;
  
  public BackPropagationTest (float domainMin, float domainMax, TeacherFunction teacher, float learningRate, float dx, int inputLayerSize, int hiddenLayerNum, int hiddenLayerSize, int outputLayerSize) {
    float[] rangeMin = new float[1];
    float[] rangeMax = new float[1];
    rangeMin[0] = domainMin;
    rangeMax[0] = domainMax;
    
    nn = new NeuralNetwork (inputLayerSize, hiddenLayerNum, hiddenLayerSize, outputLayerSize);
    g = new Graph (domainMin, domainMax, dx, teacher);
    bp = new BackPropagationMethod(rangeMin, rangeMax, teacher, learningRate);
  }
  
  public void update () {
    g.drawThisFunction ();
    g.drawNeuralNetwork(nn);
    
    text("GENERATION: " + bp.generation, 50, 50);
    //if (frameCount % 100 == 0) {
      bp.backPropagate(nn, g.range);
    //}
    
  }
}