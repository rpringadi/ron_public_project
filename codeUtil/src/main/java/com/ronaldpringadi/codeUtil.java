/**
 * 
 */
package com.ronaldpringadi;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * @author pringadi
 *
 */
public class codeUtil {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		System.out.println("Hello from codeUtil!");
		exec("git diff", new File("./"));
	}

	public static void exec(String command, File path) {
		System.out.printf("%s$ %s\n", path.toString(), command);
		try {
			Process process = Runtime.getRuntime().exec(command, null, path);
			printResults(process);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void printResults(Process process) throws IOException {
		BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
		String line = "";
		while ((line = reader.readLine()) != null) {
			System.out.println(line);
		}
	}

}
