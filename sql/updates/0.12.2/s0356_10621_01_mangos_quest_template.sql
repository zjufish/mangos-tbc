ALTER TABLE db_version CHANGE COLUMN required_s0346_10629_01_mangos_mangos_string required_s0356_10621_01_mangos_quest_template bit;

ALTER TABLE quest_template ADD COLUMN RequiredClasses smallint(5) unsigned NOT NULL default '0' AFTER Type;

UPDATE quest_template
  SET RequiredClasses = RequiredClasses|
    CASE SkillOrClass
      WHEN  -1 THEN    1 -- warrior
      WHEN  -2 THEN    2 -- paladin
      WHEN  -3 THEN    4 -- hunter
      WHEN  -4 THEN    8 -- rogue
      WHEN  -5 THEN   16 -- priest
      WHEN  -7 THEN   64 -- shaman
      WHEN  -8 THEN  128 -- mage
      WHEN  -9 THEN  256 -- warlock
      WHEN -11 THEN 1024 -- druid
      ELSE 0
    END
  WHERE SkillOrClass < 0;

UPDATE quest_template
  SET RequiredClasses = RequiredClasses|
    CASE ZoneOrSort
      WHEN  -81 THEN    1 -- warrior
      WHEN -141 THEN    2 -- paladin
      WHEN -261 THEN    4 -- hunter
      WHEN -162 THEN    8 -- rogue
      WHEN -262 THEN   16 -- priest
      WHEN  -82 THEN   64 -- shaman
      WHEN -161 THEN  128 -- mage
      WHEN  -61 THEN  256 -- warlock
      WHEN -263 THEN 1024 -- druid
      ELSE 0
    END
  WHERE ZoneOrSort < 0;

UPDATE quest_template SET SkillOrClass=0 WHERE SkillOrClass<0;
ALTER TABLE quest_template CHANGE COLUMN SkillOrClass RequiredSkill smallint(5) unsigned NOT NULL default '0' AFTER RequiredRaces;
