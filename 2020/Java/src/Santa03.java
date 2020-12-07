import java.io.*;
import java.util.*;

public class Santa03 {

  public static final char TREE = '#';

  // moves in format of across, and down
  public static final int[][] MOVE_MAP = {
    { 3, 1 },
    { 1, 1 },
    { 5, 1 },
    { 7, 1 },
    { 1, 2 },
  };

  public static int slopeTraversal(List<List<Character>> input, int movesDown, int movesAcross) {
    int treesEncountered = 0;

    int stepsAcross = 0;
    for(int i = 0; i < input.size(); i += movesDown) {
      List<Character> row = input.get(i);

      if(row.get(stepsAcross % row.size()) == TREE) treesEncountered++;
      stepsAcross += movesAcross;
    }
    return treesEncountered;
  }

  public static int starOne(List<List<Character>> input) {
    return slopeTraversal(input, MOVE_MAP[0][1], MOVE_MAP[0][0]);
  }

  public static long starTwo(List<List<Character>> input) {
    long treesEncountered = 1;
    for(int i = 0; i < MOVE_MAP.length; i++) {
      treesEncountered *= (long)slopeTraversal(input, MOVE_MAP[i][1], MOVE_MAP[i][0]);
    }
    return treesEncountered;
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
      List<List<Character>> input = new ArrayList<List<Character>>();
      while((line = br.readLine()) != null) {
        List<Character> inputRow = new ArrayList<Character>();

        for(int i = 0; i < line.length(); i++) {
          inputRow.add(line.charAt(i));
        }
        input.add(inputRow);
      };

      System.out.println(starOne(input));
      System.out.println(starTwo(input));

    } catch (IOException e) {
      e.printStackTrace();
    }
  };
}
