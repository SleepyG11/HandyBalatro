local old_attention_text = attention_text
function attention_text(...)
	local old_speedfactor = G.SPEEDFACTOR
	G.SPEEDFACTOR = G.HANDY_REAL_SPEEDFACTOR or G.SPEEDFACTOR
	local r = old_attention_text(...)
	G.SPEEDFACTOR = old_speedfactor
	return r
end
