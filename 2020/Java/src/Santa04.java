import java.io.*;
import java.util.*;
import java.util.function.Function;

public class Santa04 {

  private static final String[] FIELDS = {
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid",
  };

  private static boolean isValidByr(String val) {
    if(val == null) return false;
    int year = Integer.parseInt(val);
    return (year >= 1920 && year <= 2002);
  }

  private static boolean isValidIyr(String val) {
    if(val == null) return false;
    int year = Integer.parseInt(val);
    return (year >= 2010 && year <= 2020);
  }

  private static boolean isValidEyr(String val) {
    if(val == null) return false;
    int year = Integer.parseInt(val);
    return (year >= 2020 && year <= 2030);
  }

  private static boolean isValidHgt(String val) {
    if(val == null) return false;
    String[] inchSplit = val.split("in");
    String[] cmSplit = val.split("cm");

    if(cmSplit[0].length() == val.length() - 2 &&
      Integer.parseInt(cmSplit[0]) >= 150 &&
      Integer.parseInt(cmSplit[0]) <= 193
    ) {
      return true;
    }

    if(inchSplit[0].length() == val.length() - 2 &&
      Integer.parseInt(inchSplit[0]) >= 59 &&
      Integer.parseInt(inchSplit[0]) <= 76
    ) {
      return true;
    }

    return false;
  }

  private static boolean isValidHcl(String val) {
    if(val == null) return false;
    return val.length() == 7 && val.matches("#([a-f]|\\d){6}");
  }

  private static boolean isValidEcl(String val) {
    if(val == null) return false;

    return (
      val.equals("amb") ||
      val.equals("blu") ||
      val.equals("brn") ||
      val.equals("gry") ||
      val.equals("grn") ||
      val.equals("hzl") ||
      val.equals("oth")
    );
  }

  private static boolean isValidPid(String val) {
    if(val == null) return false;
    return val.length() == 9;
  }

  private static boolean isValidPassportStarTwo(HashMap<String, String> passportData) {
    return (
      isValidByr(passportData.get("byr")) &&
      isValidIyr(passportData.get("iyr")) &&
      isValidEyr(passportData.get("eyr")) &&
      isValidHgt(passportData.get("hgt")) &&
      isValidHcl(passportData.get("hcl")) &&
      isValidEcl(passportData.get("ecl")) &&
      isValidPid(passportData.get("pid"))
    );
  }

  private static boolean isValidPassportStarOne(HashMap<String, String> passportData) {
    for(int i = 0; i < FIELDS.length; i++) {
      if(!passportData.containsKey(FIELDS[i])) {
        return false;
      }
    }
    return true;
  }

  private static int countValidPassports(
    List<HashMap<String, String>> input,
    Function<HashMap<String, String>, Boolean> fn
  ) {
    int validPassportCount = 0;
    for(int i = 0; i < input.size(); i++) {
      if(fn.apply(input.get(i))) validPassportCount++;
    }
    return validPassportCount;
  }

  private static HashMap<String, String> parseInput(BufferedReader br) throws IOException{
    String line;
    if((line = br.readLine()) == null) return null;

    HashMap<String, String> passportData = new HashMap<String, String>();

    do {
      String[] data = line.split("\\s|:");
      for(int i = 0; i < data.length; i += 2) {
        // if it's a passport field
        passportData.put(data[i], data[i+1]);
      }
    } while((line = br.readLine()) != null && line.length() > 0);

    return passportData;
  }

  private static BufferedReader fileReader(String path) throws FileNotFoundException {
    File f = new File(path);
    FileReader fr = new FileReader(f);
    return new BufferedReader(fr);
  }

  public static void main(String args[]) {
    try {
      BufferedReader br = fileReader(args[0]);

      List<HashMap<String, String>> input = new ArrayList<HashMap<String, String>>();
      while(true) {

        HashMap<String, String> passportData = parseInput(br);
        if(passportData == null) break;
        input.add(passportData);
      };

      System.out.println(countValidPassports(input, Santa04::isValidPassportStarOne));
      System.out.println(countValidPassports(input, Santa04::isValidPassportStarTwo));
    } catch (IOException e) {
      e.printStackTrace();
    }
  };
}
