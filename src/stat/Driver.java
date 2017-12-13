package stat;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Scanner;

public class Driver {

	public static void main(String[] args) {
		try {
			Scanner sc = new Scanner(new File("top2016.csv"));
			PrintWriter pw = new PrintWriter("top2016-fix.csv");
			
			pw.println(sc.nextLine());
			
			while(sc.hasNextLine()){
				String str = sc.nextLine();
				if(str.contains("Electronic Arts"))
					str += ",0,0,0,0";
				else if(str.contains("Square Enix"))
					str += ",0,0,0,1";
				else if(str.contains("Nintendo"))
					str += ",0,0,1,0";
				else if(str.contains("Sony Computer Entertainment"))
					str += ",0,1,0,0";
				else if(str.contains("Capcom"))
					str += ",1,0,0,0";
				
				String[] p = new String[]{"PS4", "XOne", "WiiU", "3DS", "PC", "PSV"};
				
				if(str.contains(p[0]))
					str += ",0,0,0,0,0,0";
				else if(str.contains(p[1]))
					str += ",0,0,0,0,1,0";
				else if(str.contains(p[2]))
					str += ",0,0,0,1,0,0";
				else if(str.contains(p[3]))
					str += ",0,0,1,0,0,0";
				else if(str.contains(p[4]))
					str += ",0,1,0,0,0,0";
				else if(str.contains(p[5]))
					str += ",1,0,0,0,0,0";
				
				pw.println(str);
			}
			
			sc.close();
			pw.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} 

	}

}
