import java.io.*;
import java.util.*;

public class Santa02 {

  public static class PwdInput {
    public int min;
    public int max;
    public char target;
    public String pwd;
  
    public PwdInput(int min, int max, char target, String pwd) {
      this.min = min;
      this.max = max;
      this.target = target;
      this.pwd = pwd;
    }
  
    public boolean isValidStarOne() {
      int targetCount = 0;
      for(int i = 0; i < pwd.length(); i++) {
        if(pwd.charAt(i) == target) targetCount++;
      }
      return targetCount >= min && targetCount <= max;
    }

    public boolean isValidStarTwo() {
      return(pwd.charAt(min-1) == target ^ pwd.charAt(max-1) == target);
    }
  };

  private static int starOne(List<PwdInput> input) {
    int numValidPasswords = 0;

    for(int i = 0; i < input.size(); i++) {
      if(input.get(i).isValidStarOne()) {
        numValidPasswords++;
      }
    }

    return numValidPasswords;
  }

  private static int starTwo(List<PwdInput> input) {
    int numValidPasswords = 0;

    for(int i = 0; i < input.size(); i++) {
      if(input.get(i).isValidStarTwo()) {
        numValidPasswords++;
      }
    }

    return numValidPasswords;
  }

  private static BufferedReader fileReader(String path) throws FileNotFoundException {
    File f = new File(path);
    FileReader fr = new FileReader(f);
    return new BufferedReader(fr);
  }

  public static void main(String args[]) {
    try {
      BufferedReader br = fileReader(args[0]);

      String line;
      List<PwdInput> input = new ArrayList<PwdInput>();
      while((line = br.readLine()) != null) {
        String[] inputs = line.split("\\W");
        input.add(new PwdInput(
          Integer.parseInt(inputs[0]),
          Integer.parseInt(inputs[1]),
          inputs[2].charAt(0),
          inputs[4]
        ));
      };

      System.out.println(starOne(input));
      System.out.println(starTwo(input));

    } catch (IOException e) {
      e.printStackTrace();
    }
  };
}
