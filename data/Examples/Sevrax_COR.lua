-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    gs c toggle LuzafRing -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    
    Weaponskill mode, if set to 'Normal', is handled separately for melee and ranged weaponskills.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Melee','Ranged','Acc')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.RAbullet = "Divine Bullet"
    gear.WSbullet = "Decimating Bullet"
    gear.MAbullet = "Bronze Bullet"
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 10

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
	
    sets.precast.JA['Snake Eye'] = {legs=""}
	
    sets.precast.JA['Wild Card'] = {feet="Commodore Bottes +2"}
	
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
    
    sets.precast.CorsairRoll = {
		    head={ name="Lanun Tricorne", augments={'Enhances "Winning Streak" effect',}},
			hands="Chasseur's Gants +1",
			left_ring="Barataria Ring",
			right_ring="Luzaf's Ring",
			back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
			}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +2"})
	
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
	
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +1"})
	
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
	
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
	
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}
    
    sets.precast.CorsairShot = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
			head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
			body={ name="Taeon Tabard", augments={'Accuracy+17','"Fast Cast"+3','Crit. hit damage +2%',}},
			hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
			legs={ name="Taeon Tights", augments={'Accuracy+18 Attack+18','"Fast Cast"+3','STR+6 AGI+6',}},
			feet={ name="Carmine Greaves", augments={'HP+60','MP+60','Phys. dmg. taken -3',}},
			neck="Voltsurge Torque",
			left_ear="Enchntr. Earring +1",
			right_ear="Loquac. Earring",
			left_ring="Weather. Ring",
			right_ring="Lebeche Ring",
			}

    sets.precast.RA = {
			head={ name="Taeon Chapeau", augments={'Accuracy+24','"Snapshot"+5','AGI+7',}},
			body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}},
			hands={ name="Lanun Gants +1", augments={'Enhances "Fold" effect',}},
			legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
			waist="Impulse Belt",
			back="Navarch's Mantle",
			}
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
			sets.precast.WS = {
		    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
			body="Abnoba Kaftan",
			hands="Meg. Gloves +1",
			legs={ name="Herculean Trousers", augments={'Accuracy+28','Weapon skill damage +2%','DEX+13',}},
			feet={ name="Herculean Boots", augments={'Attack+29','Weapon skill damage +5%','Accuracy+11',}},
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Mache Earring",
			right_ear="Telos Earring",
			left_ring="Petrov Ring",
			right_ring="Rufescent Ring",
			back="Rancorous Mantle",
			}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = sets.precast.WS

    sets.precast.WS['Exenterator'] = sets.precast.WS

    sets.precast.WS['Requiescat'] = sets.precast.WS

    sets.precast.WS['Last Stand'] = {
			gear.WSbullet,
			head="Meghanada Visor +1",
			body={ name="Herculean Vest", augments={'Rng.Acc.+24','Crit.hit rate+3','AGI+7','Rng.Atk.+8',}},
			hands="Meg. Gloves +1",
			legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Enervating Earring",
			right_ear="Telos Earring",
			left_ring="Hajduk Ring",
			right_ring="Rufescent Ring",
			back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
			}

    sets.precast.WS['Last Stand'].Acc = {
			gear.WSbullet,
		    head="Meghanada Visor +1",
			body={ name="Herculean Vest", augments={'Rng.Acc.+24','Crit.hit rate+3','AGI+7','Rng.Atk.+8',}},
			hands="Meg. Gloves +1",
			legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
			neck="Fotia Gorget",
			waist="Fotia Belt",
			left_ear="Enervating Earring",
			right_ear="Telos Earring",
			left_ring="Hajduk Ring",
			right_ring="Rufescent Ring",
			back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
			}

    sets.precast.WS['Wildfire'] = {
			ammo=gear.MAbullet,
		    head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','STR+9','"Mag.Atk.Bns."+6',}},
			body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
			hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
			legs={ name="Herculean Trousers", augments={'CHR+6','STR+10','Magic burst mdg.+5%','Accuracy+13 Attack+13','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
			feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+5','Mag. Acc.+8',}},
			neck="Sanctity Necklace",
			waist="Kwahu Kachina Belt",
			left_ear="Friomisi Earring",
			right_ear="Novio Earring",
			left_ring="Fenrir Ring +1",
			right_ring="Arvina Ringlet +1",
			back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
			}

    sets.precast.WS['Wildfire'].Brew = {
			ammo=gear.MAbullet,
		    head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','STR+9','"Mag.Atk.Bns."+6',}},
			body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
			hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
			legs={ name="Herculean Trousers", augments={'CHR+6','STR+10','Magic burst mdg.+5%','Accuracy+13 Attack+13','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
			feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+5','Mag. Acc.+8',}},
			neck="Sanctity Necklace",
			waist="Kwahu Kachina Belt",
			left_ear="Friomisi Earring",
			right_ear="Novio Earring",
			left_ring="Fenrir Ring +1",
			right_ring="Arvina Ringlet +1",
			back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
			}

    sets.precast.WS['Leaden Salute'] = {
			ammo=gear.MAbullet,
		    head="Pixie Hairpin +1",
			body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
			hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
			legs={ name="Herculean Trousers", augments={'CHR+6','STR+10','Magic burst mdg.+5%','Accuracy+13 Attack+13','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
			feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+5','Mag. Acc.+8',}},
			neck="Sanctity Necklace",
			waist="Kwahu Kachina Belt",
			left_ear="Friomisi Earring",
			right_ear="Novio Earring",
			left_ring="Fenrir Ring +1",
			right_ring="Arvina Ringlet +1",
			back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
			}

    -- Midcast Sets
    sets.midcast.FastRecast = {
			head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
			body={ name="Taeon Tabard", augments={'Accuracy+17','"Fast Cast"+3','Crit. hit damage +2%',}},
			hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
			legs={ name="Taeon Tights", augments={'Accuracy+18 Attack+18','"Fast Cast"+3','STR+6 AGI+6',}},
			feet={ name="Carmine Greaves", augments={'HP+60','MP+60','Phys. dmg. taken -3',}},
			neck="Voltsurge Torque",
			left_ear="Enchntr. Earring +1",
			right_ear="Loquac. Earring",
			left_ring="Weather. Ring",
			right_ring="Lebeche Ring",
			}
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {
			ammo=gear.QDbullet,
		    head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','STR+9','"Mag.Atk.Bns."+6',}},
			body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
			hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
			legs={ name="Herculean Trousers", augments={'CHR+6','STR+10','Magic burst mdg.+5%','Accuracy+13 Attack+13','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
			feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+5','Mag. Acc.+8',}},
			neck="Sanctity Necklace",
			waist="Kwahu Kachina Belt",
			left_ear="Friomisi Earring",
			right_ear="Novio Earring",
			left_ring="Fenrir Ring +1",
			right_ring="Arvina Ringlet +1",
			back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
			}

    sets.midcast.CorsairShot.Acc = {
			ammo=gear.QDbullet,
		    head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','STR+9','"Mag.Atk.Bns."+6',}},
			body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
			hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
			legs={ name="Herculean Trousers", augments={'CHR+6','STR+10','Magic burst mdg.+5%','Accuracy+13 Attack+13','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
			feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+5','Mag. Acc.+8',}},
			neck="Sanctity Necklace",
			waist="Kwahu Kachina Belt",
			left_ear="Friomisi Earring",
			right_ear="Novio Earring",
			left_ring="Fenrir Ring +1",
			right_ring="Arvina Ringlet +1",
			back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
			}

    sets.midcast.CorsairShot['Light Shot'] = {
			ammo=gear.QDbullet,
		    head={ name="Herculean Helm", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','STR+9','"Mag.Atk.Bns."+6',}},
			body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
			hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
			legs={ name="Herculean Trousers", augments={'CHR+6','STR+10','Magic burst mdg.+5%','Accuracy+13 Attack+13','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
			feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+5','Mag. Acc.+8',}},
			neck="Sanctity Necklace",
			waist="Kwahu Kachina Belt",
			left_ear="Friomisi Earring",
			right_ear="Novio Earring",
			left_ring="Fenrir Ring +1",
			right_ring="Arvina Ringlet +1",
			back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
			}

    sets.midcast.CorsairShot['Dark Shot'] = {
			ammo=gear.QDbullet,
			head="Pixie Hairpin +1",
			body={ name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}},
			hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+14','"Mag.Atk.Bns."+15','"Fast Cast"+2',}},
			legs={ name="Herculean Trousers", augments={'CHR+6','STR+10','Magic burst mdg.+5%','Accuracy+13 Attack+13','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
			feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+5','Mag. Acc.+8',}},
			neck="Sanctity Necklace",
			waist="Kwahu Kachina Belt",
			left_ear="Friomisi Earring",
			right_ear="Novio Earring",
			left_ring="Fenrir Ring +1",
			right_ring="Arvina Ringlet +1",
			back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
			}

    -- Ranged gear
    sets.midcast.RA = {
			gear.RAbullet,
			head="Meghanada Visor +1",
			body={ name="Herculean Vest", augments={'Rng.Acc.+24','Crit.hit rate+3','AGI+7','Rng.Atk.+8',}},
			hands="Meg. Gloves +1",
			legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
			neck="Combatant's Torque",
			waist="Kwahu Kachina Belt",
			left_ear="Enervating Earring",
			right_ear="Telos Earring",
			left_ring="Hajduk Ring",
			right_ring="Longshot Ring",
			back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
			}

    sets.midcast.RA.Acc = {
			gear.RAbullet,
			head="Meghanada Visor +1",
			body={ name="Herculean Vest", augments={'Rng.Acc.+24','Crit.hit rate+3','AGI+7','Rng.Atk.+8',}},
			hands="Meg. Gloves +1",
			legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
			neck="Combatant's Torque",
			waist="Kwahu Kachina Belt",
			left_ear="Enervating Earring",
			right_ear="Telos Earring",
			left_ring="Hajduk Ring",
			right_ring="Longshot Ring",
			back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
			}

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
			gear.RAbullet,
			head="Rawhide Mask",
			neck="Sanctity Necklace",
			left_ear={name="Moonshade Earring", augments={'Mag. Acc.+4','Latent effect: "Refresh"+1',}},
			right_ear="Infused Earring",
			left_ring="Sheltered Ring",
			right_ring="Paguroidea Ring",
			}

    -- Idle sets
    sets.idle = {
			gear.RAbullet,
			head="Rawhide Mask",
			body={ name="Herculean Vest", augments={'Rng.Acc.+24','Crit.hit rate+3','AGI+7','Rng.Atk.+8',}},
			hands="Meg. Gloves +1",
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Herculean Boots", augments={'Attack+13','"Triple Atk."+4','STR+3','Accuracy+15',}},
			neck="Sanctity Necklace",
			waist="Flume Belt",
			left_ear="Infused Earring",
			right_ear={ name="Moonshade Earring", augments={'Mag. Acc.+4','Latent effect: "Refresh"+1',}},
			left_ring={ name="Dark Ring", augments={'Breath dmg. taken -4%','Phys. dmg. taken -4%',}},
			right_ring="Defending Ring",
			back="Solemnity Cape",
			}
	
    sets.idle.Town = {
			gear.RAbullet,
			head="Rawhide Mask",
			body={ name="Herculean Vest", augments={'Rng.Acc.+24','Crit.hit rate+3','AGI+7','Rng.Atk.+8',}},
			hands="Meg. Gloves +1",
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Herculean Boots", augments={'Attack+13','"Triple Atk."+4','STR+3','Accuracy+15',}},
			neck="Sanctity Necklace",
			waist="Flume Belt",
			left_ear="Infused Earring",
			right_ear={ name="Moonshade Earring", augments={'Mag. Acc.+4','Latent effect: "Refresh"+1',}},
			left_ring={ name="Dark Ring", augments={'Breath dmg. taken -4%','Phys. dmg. taken -4%',}},
			right_ring="Defending Ring",
			back="Solemnity Cape",
			}
    
    -- Defense sets
    sets.defense.PDT = {
			head="Rawhide Mask",
			body={ name="Herculean Vest", augments={'Rng.Acc.+24','Crit.hit rate+3','AGI+7','Rng.Atk.+8',}},
			hands="Meg. Gloves +1",
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Herculean Boots", augments={'Attack+13','"Triple Atk."+4','STR+3','Accuracy+15',}},
			neck="Sanctity Necklace",
			waist="Flume Belt",
			left_ear="Infused Earring",
			right_ear={ name="Moonshade Earring", augments={'Mag. Acc.+4','Latent effect: "Refresh"+1',}},
			left_ring={ name="Dark Ring", augments={'Breath dmg. taken -4%','Phys. dmg. taken -4%',}},
			right_ring="Defending Ring",
			back="Solemnity Cape",
			}

    sets.defense.MDT = {
			head="Rawhide Mask",
			body={ name="Herculean Vest", augments={'Rng.Acc.+24','Crit.hit rate+3','AGI+7','Rng.Atk.+8',}},
			hands="Meg. Gloves +1",
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Herculean Boots", augments={'Attack+13','"Triple Atk."+4','STR+3','Accuracy+15',}},
			neck="Sanctity Necklace",
			waist="Flume Belt",
			left_ear="Infused Earring",
			right_ear={ name="Moonshade Earring", augments={'Mag. Acc.+4','Latent effect: "Refresh"+1',}},
			left_ring={ name="Dark Ring", augments={'Breath dmg. taken -4%','Phys. dmg. taken -4%',}},
			right_ring="Defending Ring",
			back="Solemnity Cape",
			}

    sets.Kiting = {legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged.Melee = {
			gear.RAbullet,
			head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
			body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
			hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
			legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
			feet={ name="Herculean Boots", augments={'Attack+13','"Triple Atk."+4','STR+3','Accuracy+15',}},
			neck="Combatant's Torque",
			waist="Kentarch Belt +1",
			left_ear="Suppanomimi",
			right_ear="Telos Earring",
			left_ring="Petrov Ring",
			right_ring="Epona's Ring",
			back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
			}

	sets.engaged.Acc ={
			gear.RAbullet,
			head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
			body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
			hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+3','Accuracy+15','Attack+13',}},
			neck="Combatant's Torque",
			waist="Kentarch Belt +1",
			left_ear="Mache Earring",
			right_ear="Telos Earring",
			left_ring="Begrudging Ring",
			right_ring="Epona's Ring",
			back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
			}

    sets.engaged.Melee.DW = {
			gear.RAbullet,
			head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
			body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
			hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
			legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
			feet={ name="Herculean Boots", augments={'Attack+13','"Triple Atk."+4','STR+3','Accuracy+15',}},
			neck="Combatant's Torque",
			waist="Kentarch Belt +1",
			left_ear="Suppanomimi",
			right_ear="Telos Earring",
			left_ring="Petrov Ring",
			right_ring="Epona's Ring",
			back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
			}
    
    sets.engaged.Acc.DW = {
			gear.RAbullet,
			head={ name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}},
			body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
			hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
			legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
			feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+3','Accuracy+15','Attack+13',}},
			neck="Combatant's Torque",
			waist="Kentarch Belt +1",
			left_ear="Mache Earring",
			right_ear="Telos Earring",
			left_ring="Begrudging Ring",
			right_ring="Epona's Ring",
			back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}},
			}

    sets.engaged.Ranged = {
			gear.RAbullet,
			head="Meghanada Visor +1",
			body={ name="Herculean Vest", augments={'Rng.Acc.+24','Crit.hit rate+3','AGI+7','Rng.Atk.+8',}},
			hands="Meg. Gloves +1",
			legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
			feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}},
			neck="Combatant's Torque",
			waist="Kwahu Kachina Belt",
			left_ear="Enervating Earring",
			right_ear="Telos Earring",
			left_ring="Hajduk Ring",
			right_ring="Longshot Ring",
			back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
			}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Transcendancy'] then
        return 'Brew'
    end
end


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    if newStatus == 'Engaged' and player.equipment.main == 'Chatoyant Staff' then
        state.OffenseMode:set('Ranged')
    end
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    
    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and 'Large') or 'Small'

    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 1
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.warned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end
        
        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(5, 1)
end