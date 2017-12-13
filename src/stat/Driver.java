package stat;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Scanner;

public class Driver {

	public static void main(String[] args) {
		try {
			Scanner sc = new Scanner(new File("out.csv"));
			PrintWriter pw = new PrintWriter("year2010.csv");
			
//			ArrayList<String> data = new ArrayList<>();
			while(sc.hasNextLine()){
				String str = sc.nextLine();
				if(str.contains(",2010,")){
					pw.println(str);
				}
			}
			
			sc.close();
			pw.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} 

	}

}
