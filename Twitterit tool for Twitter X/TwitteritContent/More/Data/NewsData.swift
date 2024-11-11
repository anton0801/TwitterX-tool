import Foundation

struct Article: Identifiable {
    var id: String = UUID().uuidString
    var date: String
    var text: String
}

let newsList = [
    Article(date: "04 nov, 2024", text: "Twitter has introduced a new feature called \"Who Reads Your Tweets,\" allowing users to see exactly who views their posts, enhancing platform interactivity."),
    Article(date: "01 Nov, 2024", text: "Twitter announces new features for enhanced user engagement, aiming to improve content discovery on the platform."),
    Article(date: "28 oct, 2024", text: "The social network has updated its timeline algorithm to improve content personalization, offering users more relevant posts and trends based on their interests."),
    Article(date: "28 Oct, 2024", text: "Elon Musk hints at introducing AI-powered tools to detect misinformation on Twitter, potentially changing the landscape of social media verification."),
    Article(date: "25 oct, 2024", text: "Twitter announced the implementation of a tweet editing feature that allows users to correct mistakes or update information within 30 minutes of posting."),
    Article(date: "20 oct, 2024", text: "The platform has launched a \"Groups\" feature, enabling users to create private communities for sharing content and discussing topics with a limited audience."),
    Article(date: "15 Oct, 2024", text: "Twitter reveals upcoming subscription model updates, offering exclusive features for premium users."),
    Article(date: "05 Oct, 2024", text: "New Twitter policies allow for increased user customization in feeds, giving users control over the types of content they see."),
    Article(date: "29 Sep, 2024", text: "Twitter expands collaboration with news agencies, making it easier for journalists to share verified updates directly with users."),
    Article(date: "20 Sep, 2024", text: "Musk announces a vision for Twitter to become a comprehensive media platform, featuring not just text but also video and interactive content."),
    Article(date: "10 Sep, 2024", text: "Twitter rolls out new tools to fight bots and automated spamming, aiming to provide a more authentic experience."),
    Article(date: "30 Aug, 2024", text: "Platform launches test for 'Community Topics,' allowing users to join groups with shared interests, similar to sub-communities."),
    Article(date: "21 Aug, 2024", text: "A major interface update for Twitter was released, with improved accessibility features and a refined design layout for better readability."),
    Article(date: "12 Aug, 2024", text: "Twitter plans to experiment with AI-curated news feeds tailored to user preferences, sparking interest and debate among users."),
    Article(date: "05 Aug, 2024", text: "Twitter announces improvements in data transparency, allowing users to see more details on how their data is used."),
    Article(date: "28 Jul, 2024", text: "Elon Musk hints at Twitter integrating blockchain features for enhanced privacy and secure user verification."),
    Article(date: "20 Jul, 2024", text: "New content guidelines are released to curb misinformation and promote respectful interactions across the platform."),
    Article(date: "12 Jul, 2024", text: "Twitter adds a 'Read Later' feature, enabling users to save tweets for future reading."),
    Article(date: "01 Jul, 2024", text: "An update to Twitter's notification system lets users set custom alerts for important topics and profiles."),
    Article(date: "23 Jun, 2024", text: "Musk hints at a potential collaboration with major news agencies to provide exclusive content on Twitter."),
    Article(date: "15 Jun, 2024", text: "Twitter expands video length for verified accounts, allowing longer video content for media creators."),
    Article(date: "06 Jun, 2024", text: "New advertising tools are launched, giving businesses enhanced targeting options to reach specific audiences."),
    Article(date: "28 May, 2024", text: "Twitter tests end-to-end encryption for direct messages in select regions, aiming to enhance privacy."),
    Article(date: "19 May, 2024", text: "Platform introduces a scheduling feature, letting users plan tweet postings ahead of time."),
    Article(date: "10 May, 2024", text: "New 'Topic Trends' functionality highlights emerging topics based on user interests and global events."),
    Article(date: "01 May, 2024", text: "Twitter expands its Spaces feature with options for live video broadcasts alongside audio."),
    Article(date: "22 Apr, 2024", text: "Elon Musk discusses potential subscription options that remove ads and provide other exclusive benefits."),
    Article(date: "15 Apr, 2024", text: "New updates to Twitter Blue offer advanced customization for feeds, including personalized filters."),
    Article(date: "07 Apr, 2024", text: "Platform releases an API update to provide developers with more data access for app integrations."),
    Article(date: "30 Mar, 2024", text: "Twitter announces improvements to the 'Explore' section, making trending topics easier to follow."),
    Article(date: "21 Mar, 2024", text: "Musk introduces AI-driven content moderation aimed at reducing hate speech and abusive behavior."),
    Article(date: "13 Mar, 2024", text: "Twitter unveils a streamlined onboarding process for new users to set preferences and interests."),
    Article(date: "03 Mar, 2024", text: "Platform expands character limits for premium users, allowing for more detailed posts."),
    Article(date: "24 Feb, 2024", text: "Twitter begins testing a 'Verified for Organizations' feature, making verification easier for companies."),
    Article(date: "14 Feb, 2024", text: "Elon Musk reveals plans to reduce bot activity on Twitter by enhancing CAPTCHA checks for sign-ups."),
    Article(date: "05 Feb, 2024", text: "Twitter announces 'Smart Replies' feature, powered by AI, to help users respond quickly to messages."),
    Article(date: "25 Jan, 2024", text: "A new 'Content Warnings' feature allows users to tag sensitive content before posting."),
    Article(date: "16 Jan, 2024", text: "Twitter tests live polls in Spaces, enabling audience engagement during audio discussions."),
    Article(date: "07 Jan, 2024", text: "Platform introduces advanced search filters, giving users better control over search results."),
    Article(date: "30 Dec, 2023", text: "Year-end recap: Twitter shares 2023's top trends and most-engaged tweets across the platform."),
    Article(date: "21 Dec, 2023", text: "Musk mentions plans for a potential edit feature, allowing users to make corrections within a limited time."),
    Article(date: "12 Dec, 2023", text: "Twitter updates its anti-spam policies, focusing on reducing fake accounts and spammy content."),
    Article(date: "05 Dec, 2023", text: "Platform launches a revamped analytics dashboard, giving creators insights into post engagement."),
    Article(date: "27 Nov, 2023", text: "Twitter announces partnership with top publishers for exclusive news articles and breaking updates."),
    Article(date: "18 Nov, 2023", text: "Musk announces new features in Twitter Spaces, allowing for audience engagement and live Q&A sessions."),
    Article(date: "09 Nov, 2023", text: "Twitter tests a 'Communities' tab, letting users join groups with shared interests for discussions.")
]
