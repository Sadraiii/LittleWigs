--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Altar of Fangs Trash", 2993)
if not mod then return end
mod:SetTrashModule(true)
mod:SetAuraData({
	{1306669, note = CL.debuffHitByCastNote:format(mod:SpellName(1306668)), dispel = "Poison", tip = "A poison DoT applied by Toxic Breath, dispel it before it stacks too high."}, -- Toxic Breath
	{1294569, soundOnAppliedDose = "none", tip = "You've been paralyzed and cannot act until it wears off."}, -- Paralyzing Shots
	{1306232, soundOnApplied = "underyou", note = CL.debuffUnderYouNote, dispel = "Poison", tip = "You're standing in Septic Spatter, move out of it."}, -- Septic Spatter
	{1306550, tip = "A sacrificial effect channeled by the caster, be ready to react to the follow-up."}, -- Blood Sacrifice
	{1294845, dispel = "Poison", tip = "A poison DoT from Corrosive Fangs, dispel it or heal through it."}, -- Corrosive Fangs
	{1307531, soundOnApplied = "underyou", note = CL.debuffUnderYouNote, tip = "You're bleeding from Bloodletting, standing in the resulting blood pool deals ongoing damage."}, -- Bloodletting
	{1307571, soundOnAppliedDose = "none", dispel = "Poison", tip = "A stacking poison DoT from Envenom, dispel it before it gets out of hand."}, -- Envenom
	{1308518, dispel = "Poison", tip = "A poisoned weapon coating applied by Laced Edge, dispel it or heal through it."}, -- Laced Edge
	{1297422, note = CL.debuffUnderYouNote, dispel = "Poison", tip = "You're standing in Deadly Venom, move out of it."}, -- Deadly Venom
	{1308865, soundOnApplied = "alert", dispel = "Disease", tip = "You've been infested, dispel this before it spreads."}, -- Infest
})

--------------------------------------------------------------------------------
-- Localization
--

mod:SetDefaultLocale({
	custom_on_mixture_autotalk = CL.autotalk,
	custom_on_mixture_autotalk_desc = "|cFFFF0000Requires 25 skill in Midnight Cooking or Midnight Alchemy.|r Automatically select the NPC dialog option to gain the 'Mutating Elixir' buff.\n\n|T136242:16|tMutating Elixir\n{1310012}",
	custom_on_mixture_autotalk_icon = mod:GetMenuIcon("SAY"),
})

--------------------------------------------------------------------------------
-- Renames
--

mod:SetRenames({
	[1310012] = {1310012}, -- Mutating Elixir
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_mixture_autotalk",
		1310012, -- Mutating Elixir
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_mixture_autotalk") and self:GetGossipID(141730) then
		-- 141730:<Carefully complete the mixture.> \r\n[Requires at least 25 skill in Midnight Cooking or Midnight Alchemy.]
		self:SelectGossipID(141730)
		self:Message(1310012, "green", CL.on_group:format(self:SpellName(1310012)))
		self:PlaySound(1310012, "info")
	end
end
