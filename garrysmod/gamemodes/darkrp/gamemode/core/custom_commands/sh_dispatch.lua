local cityphrases = {
	{
		sound = "retrime/cityvoice/f_anticitizenreport_spkr.wav",
		text = "Вниманию наземных сил! В сообществе найден нарушитель. Код: окружить, клеймить, усмирить."
	},
	{
		sound = "retrime/cityvoice/f_anticivilevidence_3_spkr.wav",
		text = "Отряду Гражданской обороны: признаки антиобщественной деятельности. Код: собрать, окружить, задержать."
	},
	{
		sound = "retrime/cityvoice/f_confirmcivilstatus_1_spkr.wav",
		text = "Внимание! Неопознанное лицо. Немедленно подтвердить статус в отделе гражданской обороны."
	},
	{
		sound = "retrime/cityvoice/f_evasionbehavior_2_spkr.wav",
		text = "Внимание! Уклонистское поведение. Неподчинение обвиняемого. Наземным силам ГО, тревога! Код: изолировать, огласить, исполнить."
	},
	{
		sound = "retrime/cityvoice/f_innactionisconspiracy_spkr.wav",
		text = "Граждане: бездействие преступно. О противоправном поведении немедленно доложить силам ГО."
	},
	{
		sound = "retrime/cityvoice/f_localunrest_spkr.wav",
		text = "Тревога! Подразделениям Гражданской обороны, обнаружены локальные беспорядки. Собрать, исполнить, усмирить."
	},
	{
		sound = "retrime/cityvoice/f_protectionresponse_1_spkr.wav",
		text = "Вниманию отряда Гражданской обороны, обнаружено уклонение от надзора. Отреагировать, изолировать, допросить."
	},
	{
		sound = "retrime/cityvoice/f_protectionresponse_4_spkr.wav",
		text = "Вниманию наземного отряда ГО, задействовано осуждение на месте. Приговор выносить по усмотрению. Код: отсечь, обнулить, подтвердить."
	},
	{
		sound = "retrime/cityvoice/f_trainstation_cooperation_spkr.wav",
		text = "Вниманию жителей! Замечено отклонение численности. Сотрудничество с отрядом ГО награждается полным пищевым рационом."
	},
	{
		sound = "retrime/cityvoice/f_trainstation_inform_spkr.wav",
		text = "Внимание! В квартале потенциальный источник вреда обществу. Донести, содействовать, собрать."
	},
	{
		sound = "retrime/cityvoice/f_trainstation_offworldrelocation_spkr.wav",
		text = "Граждане, отказ в сотрудничестве будет наказан выселением в нежилое пространство."
	},
	{
		sound = "retrime/cityvoice/fprison_missionfailurereminder.wav",
		text = "Внимание наземным силам: провал миссии влечёт выселение в нежилое пространство. Напоминаю код: пожертвовать, остановить, устранить."
	}
}

local radiophrases = {
	{
		sound = "retrime/radiovoice/allunitsapplyforwardpressure.wav",
		text = "Всем силам выдвинуться вперёд."
	},
	{
		sound = "retrime/radiovoice/allunitsbeginwhitnesssterilization.wav",
		text = "Внимание! Начать стерилизацию свидетелей."
	},
	{
		sound = "retrime/radiovoice/allunitsdeliverterminalverdict.wav",
		text = "Всем немедленно осуществить смертную казнь."
	},
	{
		sound = "retrime/radiovoice/completesentencingatwill.wav",
		text = "Всем силам ГО: исполнять приговор по усмотрению.",
		mpf = true
	},
	{
		sound = "retrime/radiovoice/confirmupialert.wav",
		text = "Отряд, подтвердите тревогу."
	},
	{
		sound = "retrime/radiovoice/failuretotreatoutbreak.wav",
		text = "Отряду стабилизации: провал усмирения беспорядков повлечёт отзыв и переработку отряда."
	},
	{
		sound = "retrime/radiovoice/investigateandreport.wav",
		text = "Расследовать и доложить."
	},
	{
		sound = "retrime/radiovoice/leadersreportratios.wav",
		text = "Внимание лидерам команд стабилизации: докладывать о количестве стерилизованных. Последует награда или наказание."
	},
	{
		sound = "retrime/radiovoice/lockdownlocationsacrificecode.wav",
		text = "Отряд ГО: держать позицию. Код: самопожертвования.",
		mpf = true
	},
	{
		sound = "retrime/radiovoice/officerclosingonsuspect.wav",
		text = "Офицер приближается к цели."
	},
	{
		sound = "retrime/radiovoice/prepareforfinalsentencing.wav",
		text = "Приготовится к исполнению приговора."
	},
	{
		sound = "retrime/radiovoice/preparetoinnoculate.wav",
		text = "Всем местным силам ГО: приготовиться к обезвреживанию.",
		mpf = true
	},
	{
		sound = "retrime/radiovoice/reminder100credits.wav",
		text = "Командирам: напоминание, 100 стерилизованных позволяют пройти имитацию биовосстановления."
	},
	{
		sound = "retrime/radiovoice/remindermemoryreplacement.wav",
		text = "Напоминание: замена памяти - первый шаг к должностным привилегиям."
	},
	{
		sound = "retrime/radiovoice/reporton.wav",
		text = "Местным силам ГО: доложить",
		mpf = true
	},
	{
		sound = "retrime/radiovoice/suspendnegotiations.wav",
		text = "Закончить переговоры."
	},
	{
		sound = "retrime/radiovoice/teamsreportstatus.wav",
		text = "Местные отряды ГО: доложите обстановку.",
		mpf = true
	}
}

function DarkRP.GetCityPhrases()

	return cityphrases

end

function DarkRP.GetRadioPhrases()

	return radiophrases

end