# Google Analytics Setup Guide

## Step 1: Create a Google Analytics Account

1. Go to [Google Analytics](https://analytics.google.com/)
2. Sign in with your Google account
3. Click "Start measuring"

## Step 2: Create a Property

1. **Account Setup:**
   - Account name: "Sachin Kalsi Portfolio" (or your choice)
   - Click "Next"

2. **Property Setup:**
   - Property name: "Portfolio Website"
   - Reporting time zone: Select your timezone
   - Currency: USD (or your preference)
   - Click "Next"

3. **Business Information:**
   - Industry category: Select appropriate (e.g., "Technology")
   - Business size: Select appropriate
   - How you intend to use Google Analytics: Select options
   - Click "Create"

4. **Accept Terms:**
   - Accept the terms and conditions

## Step 3: Get Your Measurement ID

1. After creating the property, you'll see **"Data Streams"**
2. Click **"Add stream"** → **"Web"**
3. Enter:
   - Website URL: `https://sachinkalsi.github.io`
   - Stream name: "Portfolio Website"
4. Click **"Create stream"**
5. You'll see your **Measurement ID** (format: `G-XXXXXXXXXX`)
   - Copy this ID

## Step 4: Add Measurement ID to Your Site

1. Open `_config.yml` in your project
2. Find the line: `google_analytics: ""`
3. Add your Measurement ID:
   ```yaml
   google_analytics: "G-XXXXXXXXXX"  # Replace with your actual ID
   ```
4. Save the file
5. Commit and push to GitHub:
   ```bash
   git add _config.yml
   git commit -m "Add Google Analytics tracking"
   git push
   ```

## Step 5: Verify It's Working

1. Wait 1-2 minutes for GitHub Pages to rebuild
2. Visit your website: `https://sachinkalsi.github.io`
3. Go to Google Analytics → **Reports** → **Realtime**
4. You should see yourself as a visitor within a few seconds!

## What You Can Track

### Overview Metrics
- **Users**: Total number of visitors
- **Sessions**: Total visits to your site
- **Page views**: Total pages viewed
- **Average session duration**: How long people stay
- **Bounce rate**: Percentage who leave after one page

### Blog-Specific Tracking
- **Most popular blog posts**: See which posts get the most views
- **Blog post performance**: Track individual post views
- **User flow**: See how people navigate through your site
- **Traffic sources**: Where visitors come from (Google, social media, direct, etc.)

### Detailed Reports Available
1. **Realtime**: See live visitors right now
2. **Acquisition**: Where your traffic comes from
3. **Engagement**: How people interact with your site
4. **Demographics**: Age, gender, location of visitors
5. **Technology**: Devices, browsers used
6. **Events**: Track specific actions (clicks, downloads, etc.)

## Viewing Your Analytics

1. Go to [Google Analytics](https://analytics.google.com/)
2. Select your property
3. Use the left sidebar to navigate:
   - **Reports** → See overview and detailed metrics
   - **Realtime** → See live visitors
   - **Explore** → Create custom reports

## Privacy Note

Google Analytics is GDPR compliant when properly configured. The tracking code I added respects user privacy and doesn't collect personal information.

## Troubleshooting

**Not seeing data?**
- Wait 24-48 hours for data to appear (Realtime works immediately)
- Make sure you added the Measurement ID correctly in `_config.yml`
- Check that your site is live and the code is deployed
- Use browser developer tools to check if the GA script is loading

**Want to test?**
- Visit your site and check Google Analytics Realtime report
- You should see yourself as a visitor within seconds

