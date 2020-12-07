import java.io.*;
import java.util.*;

public class Santa01 {

  private static int targetSum = 2020;

  private static int starOne(List<Integer> input) {

    int expenseVal = 0;
    HashSet<Integer> targetSums = new HashSet<Integer>();

    for(int i = 0; i < input.size(); i++) {
      if(targetSums.contains(targetSum-input.get(i))) {
        expenseVal = input.get(i)*(targetSum-input.get(i));
        break;
      } else {
        targetSums.add(input.get(i));
      }
    }
    return expenseVal;
  }

  private static int starTwo(List<Integer> input) {
    int expenseVal = 0;
    HashSet<Integer> inputVals = new HashSet<Integer>();

    for(int i = 0; i < input.size(); i++) {
      inputVals.add(input.get(i));
    }

    for(int i = 0; i < input.size(); i++) {
      for(int j = i+1; j < input.size(); j++) {
        int targetRemainder = targetSum - input.get(i) - input.get(j);
        if(inputVals.contains(targetRemainder)) {
          return targetRemainder*input.get(i)*input.get(j);
        }
      }
    }
    return expenseVal;
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
      List<Integer> input = new ArrayList<Integer>();
      while((line = br.readLine()) != null) {
        input.add(Integer.parseInt(line));
      };

      System.out.println(starOne(input));
      System.out.println(starTwo(input));

    } catch (IOException e) {
      e.printStackTrace();
    }
  };
}
