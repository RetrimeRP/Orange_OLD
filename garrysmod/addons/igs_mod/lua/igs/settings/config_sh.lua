IGS.C.CURRENCY_NAME = "Рубли"
IGS.C.CURRENCY_SIGN = "руб"

IGS.C.CurrencyPlurals = {
	"рубль",
	"рубля",
	"рублей"
}

IGS.C.MENUBUTTON = KEY_F6

IGS.C.COMMANDS = {
	["donate"] = true
}

IGS.C.Inv_Enabled = true
IGS.C.Inv_AllowDrop = true
IGS.C.BroadcastPurchase = false

if SERVER then return end

IGS.C.NotifyAboutNewItems = false
IGS.C.DefaultIcon = "https://i.imgur.com/mLoHaCE.jpg"

IGS.C.Help = {
}

IGS.C.DisabledFrames = {
	["faq_and_help"] = true,
	["purchases"] = true
}

IGS.C.DATE_FORMAT = "%d.%m.%y %H:%M:%S"
IGS.C.DATE_FORMAT_SHORT = "%d.%m.%y"