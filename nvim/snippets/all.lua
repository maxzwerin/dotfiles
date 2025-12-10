---@diagnostic disable: undefined-global

return {
	s("date", t(os.date("%Y/%m/%d"))),
	s("mail", t("maxzwerin@gmail.com")),
	s("email", t("maxzwerin@gmail.com")),
	s("gh", t("github.com/maxzwerin")),
	s("(", { t("("), i(1), t(")") }),
	s("[", { t("["), i(1), t("]") }),
	s("{", { t("{"), i(1), t("}") }),
	s("$", { t("$"), i(1), t("$") }),
}
