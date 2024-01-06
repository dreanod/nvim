return {
	-- dashboard to greet
	{
		"goolord/alpha-nvim",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			-- Set header
			dashboard.section.header.val = {
[[                           |~~~~~~~|]],
[[                           |       |]],
[[                         |~~~~~~~~~~~| ]],
[[                         |  I N R I  |]],
[[                         |___________|]],
[[                           |       |                             ]],
[[|~.\\\_\~~~~~~~~~~~~~~xx~~~         ~~~~~~~~~~~~~~~~~~~~~/_//;~|]],
[[|  \  o \_         ,XXXXX),                         _..-~ o /  |]],
[[|    ~~\  ~-.     XXXXX`)))),                 _.--~~   .-~~~   |]],
[[ ~~~~~~~`\   ~\~~~XXX' _/ ';))     |~~~~~~..-~     _.-~ ~~~~~~~ ]],
[[          `\   ~~--`_\~\, ;;;\)__.---.~~~      _.-~]],
[[            ~-.       `:;;/;; \          _..-~~]],
[[               ~-._      `''        /-~-~ ]],
[[                   `\              /  /]],
[[                     |         ,   | |]],
[[                      |  '        /  |]],
[[                       \/;          |]],
[[                        ;;          |]],
[[                        `;   .       |]],
[[                        |~~~-----.....|]],
[[                       | \             \]],
[[                      | /\~~--...__    |]],
[[                      (|  `\       __-\|  -Tua Xiong]],
[[                      ||    \_   /~    |]],
[[                      |)     \~-'      |]],
[[                       |      | \      ']],
[[                       |      |  \    :]],
[[                        \     |  |    |]],
[[                         |    )  (    ) ]],
[[                          \  /;  /\  |]],
[[                          |    |/   |]],
[[                          |    |   |]],
[[                           \  .'  ||]],
[[                           |  |  | |]],
[[                           (  | |  |]],
[[                           |   \ \ |]],
[[                           || o `.)|]],
[[                           |`\\\\) |]],
[[                           |       |]],
[[                           |       |]],
[[                           |       |]],
			}

			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
				dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
				dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h<CR>"),
				dashboard.button("q", "󰅚  > Quit NVIM", ":qa<CR>"),
				dashboard.button("p", "󰉋  > Projects", ":Telescope projections<cr>"),
			}

			local fortune = require("alpha.fortune")
			dashboard.section.footer.val = fortune({
				fortune_list = {
          {"Quóniam in me sperávit, liberábo eum: * prótegam eum, quóniam cognóvit nomen meum.", "", "Ps. 90,14"},
          {"Quis sicut Dóminus, Deus noster, qui in altis hábitat, * et humília réspicit in cælo et in terra?", "", "Ps. 112,5"},
          {"Non nobis, Dómine, non nobis: * sed nómini tuo da glóriam.", "", "Ps. 112,9"},
          {"Ecce enim, in iniquitátibus concéptus sum: * et in peccátis concépit me mater mea.", "", "Ps 50,7"},
          {"Iúvenes, et vírgines: senes cum iunióribus laudent nomen Dómini: * quia exaltátum est nomen eius solíus.", "", "Ps 148,12"},
          {"Quid retríbuam Dómino pro ómnibus, quæ retríbuit mihi? Cálicem salutáris accípiam, et nomen Dómini invocábo.", "", ""},
          {"Quotquot autem recepérunt eum, dedit eis potestátem fílios Dei fíeri, his, qui credunt in nómine ejus: qui non ex sanguínibus, neque ex voluntáte carnis, neque ex voluntáte viri, sed ex Deo nati sunt.", "", "John 1"},
          {"Pone, Dómine, custódiam ori meo, et óstium circumstántiæ lábiis meis: ut non declínet cor meum in verba malítiæ, ad excusándas excusatiónes in peccátis.", "", ""}
        },
			})

			-- Send config to alpha
			alpha.setup(dashboard.opts)
		end,
	},
}
