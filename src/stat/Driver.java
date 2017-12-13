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
			PrintWriter pw = new PrintWriter("top2016.csv");
			
//			ArrayList<String> data = new ArrayList<>();
			pw.println(sc.nextLine());
			while(sc.hasNextLine()){
				String str = sc.nextLine();
				if(str.contains(",2016,")){
					if(str.contains("Square Enix") || 
							str.contains("Nintendo") ||
							str.contains("Sony Computer Entertainment") ||
							str.contains("Capcom") ||
							str.contains("Electronic Arts")){
						pw.println(str);
					}
				}
			}
			
			sc.close();
			pw.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} 

	}

}
