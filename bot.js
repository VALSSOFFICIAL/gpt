require("dotenv").config();
const TelegramBot = require("node-telegram-bot-api");
const axios = require("axios");

// Ambil dari .env
const TELEGRAM_BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN;
const OPENAI_API_KEY = process.env.OPENAI_API_KEY;

// Inisialisasi Bot
const bot = new TelegramBot(TELEGRAM_BOT_TOKEN, { polling: true });

// Fungsi ChatGPT
async function askGPT(prompt) {
  try {
    const response = await axios.post(
      "https://api.openai.com/v1/chat/completions",
      {
        model: "gpt-4o-mini",
        messages: [{ role: "user", content: prompt }],
      },
      {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${OPENAI_API_KEY}`,
        },
      }
    );

    return response.data.choices[0].message.content.trim();
  } catch (err) {
    console.error(err.response?.data || err.message);
    return "❌ Error: Gagal menghubungi ChatGPT API.";
  }
}

// Command /start
bot.onText(/\/start/, (msg) => {
  const chatId = msg.chat.id;
  const text = `
╔══✦❘༻༺❘✦══╗
     🤖 *FNZ_DEV AI*
╚══✦❘༻༺❘✦══╝

👋 Selamat datang *${msg.from.first_name || "User"}*  
Saya asisten AI yang terhubung langsung ke *ChatGPT*  

🚀 Ketik pertanyaanmu langsung, saya akan jawab secepat kilat!

_— Powered by FNZ_DEV_
`;

  bot.sendMessage(chatId, text, { parse_mode: "Markdown" });
});

// Chat handler
bot.on("message", async (msg) => {
  const chatId = msg.chat.id;
  const text = msg.text;

  if (text.startsWith("/start")) return;

  bot.sendChatAction(chatId, "typing");

  const reply = await askGPT(text);

  const fancyReply = `
✦─────────────────────✦
💬 *FNZ_DEV AI Answer*
✦─────────────────────✦

${reply}

⚡ _FNZ_DEV — AI Assistant_
`;

  bot.sendMessage(chatId, fancyReply, { parse_mode: "Markdown" });
});

console.log("🚀 FNZ_DEV Bot aktif!");
