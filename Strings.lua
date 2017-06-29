local strings = {
	GNEVSMERISM_BINDING_CATEGORY_TITLE = "|c70C0DEGnevsmerism|r",
	SI_BINDING_NAME_GNEVSMERISM_TOGGLE = "Hide or Show",
}

for key, value in pairs(strings) do
	ZO_CreateStringId(key, value)
	SafeAddVersion(key, 1)
end