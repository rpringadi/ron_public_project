package com.ronaldpringadi;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;

public class SeleniumCrawler {
	public static void main(String[] args) {
		httpPost("http://www.google.com");
	}

	protected static void httpPost(String url) {
		System.setProperty("webdriver.gecko.driver", "C:\\dev\\git\\ron_public_project\\SeleniumCrawler\\lib\\geckodriver.exe");

//		FirefoxOptions opt = new FirefoxOptions();
//	 	opt.addArguments("-profile", "C:\\Users\\pringadi\\AppData\\Roaming\\Mozilla\\Firefox\\Profiles\\8o6grbfj.default");
		System.out.println("Firefox");
	 	WebDriver driver = new FirefoxDriver();
	 	
	 	System.out.println("Get");
		driver.get("https://www.google.ca");
		System.out.println("get done");
		
		WebElement element = driver.findElement(By.cssSelector("input[name=q]:first-child"));
		System.out.println("Sending keys");
		element.sendKeys("Cheese!");
		System.out.println("Sending keys done");
		element.submit();
		System.out.println("Page title is: " + driver.getTitle());

		(new WebDriverWait(driver, 10)).until(new ExpectedCondition<Boolean>() {
			public Boolean apply(WebDriver d) {
				return d.getTitle().toLowerCase().startsWith("cheese!");
			}
		});

		// Should see: "cheese! - Google Search"
		System.out.println("Page title is: " + driver.getTitle());

		// Close the browser
		driver.quit();

	}
}
