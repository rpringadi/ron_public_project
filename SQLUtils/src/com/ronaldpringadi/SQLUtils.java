package com.ronaldpringadi;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public class SQLUtils {
	public static void main(String[] args) {

	}

	protected static String flattenSQL(File fin) throws IOException {
		Map <String, Integer> duplicateDetection = new HashMap<>();

		if (!fin.exists()) {
			throw new IOException("File '" + fin.getAbsolutePath() + "' does not exists");
		}
		StringBuilder result = new StringBuilder();
		StringBuilder temp1Line = new StringBuilder();
		result.append("-- WARNING: Please execute the lines below using pgScript, the one-by-one, execution. \n");
		result.append("--          This is needed in order for the schema_change_log.query to be recorded nicely. \n");

		FileInputStream fis = new FileInputStream(fin);

		// Construct BufferedReader from InputStreamReader
		BufferedReader br = new BufferedReader(new InputStreamReader(fis));
		String line = null;
		while ((line = br.readLine()) != null) {
			line = line.trim();
			if (line.length() == 0 || line.startsWith("--")) {
				continue;
			}

			// Line white space adjustment
			line = line.replaceAll("\\s{2,}", " ");

			// Line appending
			if (line.contains(";")) {
				temp1Line.append(line).append("\n");
				
				String newLine = "";
				// Evaluate if this line contains a speial command such as CREATE, GRANT, TRIGGER, etc
				if (temp1Line.toString().toUpperCase().contains("CREATE TABLE") && !temp1Line.toString().toUpperCase().contains("CREATE TABLE IF NOT EXISTS")) {
					// CREATE
					newLine = temp1Line.toString().replaceAll("(?i)CREATE TABLE", "CREATE TABLE IF NOT EXISTS");
				} else if (temp1Line.toString().toUpperCase().contains("GRANT ")) {
					// GRANT
					newLine = temp1Line.toString().replaceAll("(?i)\\s+TO\\s+\\w+\\s?;", " TO public;");
				} else if (Pattern.compile("(?i)CREATE\\s+TRIGGER\\s+\\w+_(audit|log_changes)\\s+").matcher(temp1Line.toString()).find()) {
					// TRIGGER
					newLine = "-- " + temp1Line.toString();
				} else {
					newLine = temp1Line.toString();
				}
					
				if (duplicateDetection.get(newLine) == null) {
					duplicateDetection.put(newLine, 0);
					result.append(newLine);
				}
				temp1Line.setLength(0);
			} else {
				temp1Line.append(line).append(" ");
			}

		}
		br.close();
		fis.close();

		return result.toString();
	}
}
