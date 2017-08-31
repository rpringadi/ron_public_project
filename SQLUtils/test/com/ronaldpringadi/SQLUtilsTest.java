package com.ronaldpringadi;

import java.io.File;
import java.io.IOException;

import org.junit.Test;

public class SQLUtilsTest {

	@Test
	public void flattenSQLTest() {
		try {
			System.out.println(SQLUtils.flattenSQL(new File("resource/CreateTable.sql")));
		} catch (IOException e) {
			System.err.println(e.getMessage());
		}
	}
}
