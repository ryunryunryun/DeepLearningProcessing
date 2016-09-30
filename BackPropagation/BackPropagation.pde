BackPropagationTest bpt;
TeacherFunction tf;

public class Function implements TeacherFunction {
  public float[] function (float[] input) {
    float[] out = {1 / (1 + exp(input[0]))};
    //float[] out = {exp(input[0])};
    return out;
  }
}

void setup () {
  size(600, 600);
  tf = new Function();
  
  // float domainMin, float domainMax, TeacherFunction teacher, float learningRate, float dx,
  // int inputLayerSize, int hiddenLayerNum, int hiddenLayerSize, int outputLayerSize
  bpt = new BackPropagationTest(0, PI, tf, 1, 0.01, 1, 2, 10, 1);
}

void draw () {
  bpt.update();
}