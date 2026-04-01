import { chromium } from "playwright";

const [, , targetUrl, outputPath] = process.argv;

if (!targetUrl || !outputPath) {
  console.error("Usage: node capture_screenshot.mjs <url> <outputPath>");
  process.exit(1);
}

const browser = await chromium.launch({ headless: true });
const page = await browser.newPage({
  viewport: { width: 1440, height: 960 },
});

try {
  await page.goto(targetUrl, { waitUntil: "networkidle", timeout: 60000 });
  await page.screenshot({
    path: outputPath,
    fullPage: true,
  });
} finally {
  await browser.close();
}
