return {
    "goolord/alpha-nvim",
    dependencies = {
        "echasnovski/mini.icons",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[  ⠀⡀⣀⣀⠤⠤⠤⠀            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⠤⣀⣀⠀ ⠀  ]],
            [[  ⡏⡍⠉⠀⠀⠀⠀⠀            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡘⡚⠻⢼  ]],
            [[ ⢀⡎⠀⠀⠀⠀⠀⠀⠀            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⡀ ]],
            [[ ⢸⠀⠀⡈⠀⠀⠀⠀⠀        ⣼⣿⣿⣳⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡥⠀⠃ ]],
            [[  ⠀⠀⡨⠀⠀⠀⠀⠀       ⡼⣿⠁ ⠈⣿⣳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣎⠀  ]],
            [[  ⠀⠀⡵⠀⠀⠀⠀⠀      ⣼⣿⠁   ⠈⣿⣳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡊⠀  ]],
            [[  ⠀⠀⢁⠀⠀⠀⠀⠀     ⢸⣿⠁     ⠈⣿⡇⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⣘⠀  ]],
            [[  ⠀⠀⡄⠀⠀⠀⠀⠀     ⢸⣿⡀     ⢀⣿⡇⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢓⠀  ]],
            [[  ⠀⠀⢬⠀⠀⠀⠀⠀      ⢛⣿⡀   ⢀⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢼⠀  ]],
            [[  ⠀⠀⣕⠀⠀⠀⠀⠀       ⢟⣿⡀ ⢀⣿⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡪⠀  ]],
            [[  ⠀⠀⢃⠀⠀⠀⠀⠀        ⢻⣿⣿⣿⡟ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡄⠀  ]],
            [[ ⢸⠀⠀ ⠀⠀⠀⠀⠀            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⡇ ]],
            [[  ⠷⣀⣄ ⠀⠀⠀⠀            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢄⢄⣸⠁ ]],
            [[  ⠀⠀⠉⠉⠓⠒⠀⠀            ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠒⠒⠚⠉⠉⠉⠀  ]],
        }

        dashboard.section.buttons.val = {
            dashboard.button("b", "⡣  > Browse files", ":Oil<CR>"),
            dashboard.button("z", "⢵  > Browse Directories", ":Telescope zoxide list<CR>"),
            dashboard.button("f", "⢏  > Find file", ":Telescope find_files<CR>"),
            dashboard.button("r", "⡧  > Recent", ":Telescope oldfiles<CR>"),
        }

        dashboard.config.layout = {
            { type = "padding", val = 10 },
            dashboard.section.header,
            { type = "padding", val = 5 },
            dashboard.section.buttons,
            dashboard.section.footer,
        }

        alpha.setup(dashboard.opts)
    end,
}

-- ⠁ 	⠂ 	⠃ 	⠄ 	⠅ 	⠆ 	⠇ 	⠈ 	⠉ 	⠊ 	⠋ 	⠌ 	⠍ 	⠎ 	⠏
--
-- ⠐ 	⠑ 	⠒ 	⠓ 	⠔ 	⠕ 	⠖ 	⠗ 	⠘ 	⠙ 	⠚ 	⠛ 	⠜ 	⠝ 	⠞ 	⠟
--
-- ⠠ 	⠡ 	⠢ 	⠣ 	⠤ 	⠥ 	⠦ 	⠧ 	⠨ 	⠩ 	⠪ 	⠫ 	⠬ 	⠭ 	⠮ 	⠯
--
-- ⠰ 	⠱ 	⠲ 	⠳ 	⠴ 	⠵ 	⠶ 	⠷ 	⠸ 	⠹ 	⠺ 	⠻ 	⠼ 	⠽ 	⠾ 	⠿


-- ⡀ 	⡁ 	⡂ 	⡃ 	⡄ 	⡅ 	⡆ 	⡇ 	⡈ 	⡉ 	⡊ 	⡋ 	⡌ 	⡍ 	⡎ 	⡏
--
-- ⡐ 	⡑ 	⡒ 	⡓ 	⡔ 	⡕ 	⡖ 	⡗ 	⡘ 	⡙ 	⡚ 	⡛ 	⡜ 	⡝ 	⡞ 	⡟
--
-- ⡠ 	⡡ 	⡢ 	⡣ 	⡤ 	⡥ 	⡦ 	⡧ 	⡨ 	⡩ 	⡪ 	⡫ 	⡬ 	⡭ 	⡮ 	⡯
--
-- ⡰ 	⡱ 	⡲ 	⡳ 	⡴ 	⡵ 	⡶ 	⡷ 	⡸ 	⡹ 	⡺ 	⡻ 	⡼ 	⡽ 	⡾ 	⡿
--
-- ⢀ 	⢁ 	⢂ 	⢃ 	⢄ 	⢅ 	⢆ 	⢇ 	⢈ 	⢉ 	⢊ 	⢋ 	⢌ 	⢍ 	⢎ 	⢏
--
-- ⢐ 	⢑ 	⢒ 	⢓ 	⢔ 	⢕ 	⢖ 	⢗ 	⢘ 	⢙ 	⢚ 	⢛ 	⢜ 	⢝ 	⢞ 	⢟
--
-- ⢠ 	⢡ 	⢢ 	⢣ 	⢤ 	⢥ 	⢦ 	⢧ 	⢨ 	⢩ 	⢪ 	⢫ 	⢬ 	⢭ 	⢮ 	⢯
--
-- ⢰ 	⢱ 	⢲ 	⢳ 	⢴ 	⢵ 	⢶ 	⢷ 	⢸ 	⢹ 	⢺ 	⢻ 	⢼ 	⢽ 	⢾ 	⢿
--
-- ⣀ 	⣁ 	⣂ 	⣃ 	⣄ 	⣅ 	⣆ 	⣇ 	⣈ 	⣉ 	⣊ 	⣋ 	⣌ 	⣍ 	⣎ 	⣏
--
-- ⣐ 	⣑ 	⣒ 	⣓ 	⣔ 	⣕ 	⣖ 	⣗ 	⣘ 	⣙ 	⣚ 	⣛ 	⣜ 	⣝ 	⣞ 	⣟
--
-- ⣠ 	⣡ 	⣢ 	⣣ 	⣤ 	⣥ 	⣦ 	⣧ 	⣨ 	⣩ 	⣪ 	⣫ 	⣬ 	⣭ 	⣮ 	⣯
--
-- ⣰ 	⣱ 	⣲ 	⣳ 	⣴ 	⣵ 	⣶ 	⣷ 	⣸ 	⣹ 	⣺ 	⣻ 	⣼ 	⣽ 	⣾ 	⣿
--
