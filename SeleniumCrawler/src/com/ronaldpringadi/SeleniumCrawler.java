package com.ronaldpringadi;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;

public class SeleniumCrawler {
	public static void main(String[] args) {
		httpPost("http://www.google.com");
	}

	protected static void httpPost(String url) {
		try {
			System.setProperty("webdriver.gecko.driver", "C:\\dev\\git\\ron_public_project\\SeleniumCrawler\\lib\\geckodriver.exe");
			System.setProperty("webdriver.chrome.driver", "C:\\dev\\git\\ron_public_project\\SeleniumCrawler\\lib\\chromedriver.exe");

			// FirefoxOptions opt = new FirefoxOptions();
			// opt.addArguments("-profile", "C:\\Users\\pringadi\\AppData\\Roaming\\Mozilla\\Firefox\\Profiles\\8o6grbfj.default");
			System.out.println("Browser driver");
			WebDriver driver = new ChromeDriver();
			driver.manage().window().maximize();
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
			String html = driver.getPageSource();
			Document doc = Jsoup.parse(html);
			Elements links = doc.select("div.g h3 a");
			for (Element e : links) {
				System.out.println("Text:" + e.text() + " Link:" + e.attr("href"));
			}

			File scrFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
			// Now you can do whatever you need to do with it, for example copy somewhere
			FileUtils.copyFile(scrFile, new File("c:\\tmp\\screenshot.png"));

			JavascriptExecutor js = ((JavascriptExecutor) driver);
			js.executeScript("window.scrollTo(0, document.body.scrollHeight)");

			scrFile = ((TakesScreenshot) driver).getScreenshotAs(OutputType.FILE);
			// Now you can do whatever you need to do with it, for example copy somewhere
			FileUtils.copyFile(scrFile, new File("c:\\tmp\\screenshot2.png"));
			driver.quit();
			System.out.println("close the browser");
		} catch (IOException iox) {
			System.err.println(iox.getMessage());
		}

	}
}
