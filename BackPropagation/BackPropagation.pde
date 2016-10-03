BackPropagationTest bpt;
TeacherFunction tf;
TestGraphic tg;

public class Function implements TeacherFunction {
  public float[] function (float[] input) {
    float[] out = {sin(input[0])};
    //float[] out = {input[0]};
    return out;
  }
}

void setup () {
  size(600, 600);
  tf = new Function();
  tg = new TestGraphic();
  
  // float domainMin, float domainMax, TeacherFunction teacher, float learningRate, float dx,
  // int inputLayerSize, int hiddenLayerNum, int hiddenLayerSize, int outputLayerSize
  bpt = new BackPropagationTest(-PI, PI, tf, 0.75, 0.01, 1, 2, 6, 1);
  frameRate(200);
}

void draw () {
  //tg.update();
  bpt.update();
}