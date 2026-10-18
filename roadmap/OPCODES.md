# Opcode name index

This appendix maps the opcode constants that appear in `protocol/opcodes.csv` but are only referenced through the client constant tables (`decompiled/core_module/scripts/yishi/datas/consant/ProtocolTypeTable.as`, `ProtocolType.as`, `AcceptProtocolType.as`), or whose roadmap flow is described only by number, to their name, direction, code and meaning. The Chinese gloss is the verbatim description the client ships next to the constant; the English column is the meaning used in this roadmap. Every entry lists the feature that owns it; see the feature folder for the flow.

Codes present in both directions (a `send` and an `accept` entry) share one row; `dir` shows every occurrence.

## account

| Name | dir:code | zh | Meaning |
|---|---|---|---|
| `U_C_SYNCHRONIZED_TIME` | accept:4234 | 同步系统时间 | system time synchronization |
| `C_SYNCHRONIZED_TIME` | send:20008 | 同步系统时间 | client requests the system time |
| `G_ACCELERATOR` | send:20009 | 使用了加速器 | accelerator used notice |
| `C_CHECK_ACCELERATOR` | send:20010 | | accelerator check |
| `U_C_PLAYER_TIME` | accept:4, send:5019 | 领取时间宝箱 | time box claim |
| `U_C_RATE_INFO` | accept:4247 | 经验倍率 | experience rate |
| `U_C_RELOADDIRTY` | accept:4265 | 重新加载脏字符文件 | reload the dirty-word filter files |
| `C_COLLECTINFO` | send:8796 | 玩家信息采集 | player information collection |
| `U_C_ICON_NUM` | accept:4980 | 信息提示(TopToolBar等按钮上的数量提示) | button count badges (top toolbar) |
| `C_ICON_NUM` | send:9550 | 请求提示信息数据 | request the button count data |

## tutorial

| Name | dir:code | zh | Meaning |
|---|---|---|---|
| `U_C_GUID_STRENGY_ADDITEM` | accept:91, send:5009 | 新手引导添加物品强化 | novice guide grants a strengthening item |
| `U_C_PLAYER_GRADE` | accept:2, send:5018 | 领取新手礼包 | claim the newbie gift pack |

## hero

| Name | dir:code | zh | Meaning |
|---|---|---|---|
| `U_C_SEX_CHANGE` | send:4796 | 使用变性卡 | use the sex-change card |
| `U_C_HERO_UPDATESKILL` | accept:63 | 更新英雄技能（升级） | hero skill learned or upgraded |
| `U_C_PLAYER_ADDITION` | accept:4618 | 用户一级属性加成 | player base attribute bonus |
| `U_C_PLAYER_EFFECT` | accept:110 | 科技加成 | technology bonus |
| `U_HERO_TRIAL_IFNO` | accept:4468 | 英雄试炼BUFF信息 | hero trial buff info |
| `C_CHALLENGE_SELF` | send:8635 | 挑战镜像 | challenge your own mirror |
| `C_REQUEST_CHALLENGE_NEEDOFFER` | send:8478 | 请求挑战所需财富 | request the wealth required to challenge |

## fashion

| Name | dir:code | zh | Meaning |
|---|---|---|---|
| `C_HERO_UPDATE_EQUIPMENT` | accept:5008 | 时装更新（合成的时装） | composed fashion update |

## army

| Name | dir:code | zh | Meaning |
|---|---|---|---|
| `C_ARMY_POS_UPDATE` | send:8194 | 客户端发送至服务器端 | client reports the hero army position |
| `U_C_ARMY_ATTACK_CASTLE` | accept:97, send:5159 | 攻打城堡 | army attacks the castle |
| `U_C_ARMY_ISSUPPORT` | accept:53, send:5128 | 自动加兵 | automatic reinforcement |
| `U_C_ARMY_RECALL` | accept:99, send:5162 | 移动中的部队召回 | recall a moving army |
| `U_C_ARMY_SUPPROT` | accept:139 | 补充兵力 | replenish troops |
| `U_C_BATTLE_ARMY_UPDATE` | accept:144 | 更新等待列表中的血量 | update the HP of the waiting list |

## campaign

| Name | dir:code | zh | Meaning |
|---|---|---|---|
| `C_TASK_CAMPAIGN` | accept:8195 | 剧情副本 | story dungeon |
| `U_C_WIN_CONDITIONS` | accept:136 | 更新战役条件信息 | update the campaign win conditions |
| `U_C_ENTER_COPY_NUM_REFRESH` | accept:4240 | 进入多人本次数 | multiplayer dungeon entry count |
| `U_C_ESCORT_NPC_ADD` | accept:4123 | 新增一个NPC | an escort NPC was added |
| `U_C_NODE_HP` | accept:4450 | 同步血量 | node HP synchronization |
| `U_C_SMALL_MAPFOG` | accept:4127 | 小地图迷雾 | small map fog |
| `U_C_SELECT_CAMPAIGN_NODE` | accept:4789 | 查询采集节点信息 | query a gather node |
| `C_LEAVE_WARFIELD` | send:8333 | 离开战场 | leave the war field |
| `U_C_RUSH_CAMPAIGN_TIME` | accept:4623 | | rush campaign timer |
| `U_C_WEEKCAMPAIGN_SKILL` | accept:327 | 废弃法环周副本buffer | deprecated weekly campaign buffer |
| `U_C_TOLLGAGEINFO` | accept:4643 | 诸神降临活动信息 | "Chegada dos Deuses" tollgate info |
| `U_C_TOLLGAGE_GETREWARD` | accept:4644 | 诸神降临活动领取奖励 | tollgate reward claim |

## guild

The altar ("魔神祭坛"), the secret realm ("公会秘境") and the guild war ("公会战") groups.

| Name | dir:code | zh | Meaning |
|---|---|---|---|
| `ARRIVE_ALTAR` | send:8549 | NPC到达 | an NPC arrived at the altar |
| `U_C_OPEN_CONSORTIA__ALTAR` | accept:4436 | 开启公会魔神祭坛返回 | open guild demon altar result |
| `C_OPEN_CONSORTIA__ALTAR` | send:8541 | 开启公会魔神祭坛 | open the guild demon altar |
| `C_ENTER_CONSORTIA_ALTAR` | send:8542 | 进入公会魔神祭坛 | enter the guild demon altar |
| `C_CONSORTIA_ALTAR_GETBUFF` | send:8550 | 公会魔神祭坛领取buff | claim the guild altar buff |
| `C_CONSORTIA_ALTAR_BUY_SCENE` | send:8593 | 公会魔神祭坛使用技能 | use a skill in the guild altar |
| `U_C_CONSORTIA_ALTARINFO` | accept:354 | 收到服务器发送推送魔神祭坛数据 | guild altar data push |
| `U_C_CONSORTIA_ALTAR_BOSS_SYNC_HP` | accept:360 | 公会魔神祭坛BOSS血量同步 | guild altar boss HP sync |
| `C_CALL_TREE` | send:8565 | 召唤公会秘境神树 | summon the guild secret-realm tree |
| `C_FAM_BUFFER` | send:8566 | 获取公会秘境Buff | get the guild secret-realm buff |
| `C_CONSORTIA_FAM_BATTLE` | send:8551 | 公会秘境切磋 | guild secret-realm spar |
| `C_CONSORTIAFARM_OPEN_LORDSNODE` | send:8743 | 召唤公会秘境盗宝者 | summon the guild secret-realm treasure thief |
| `U_C_CONSORTIA_FARM_ORDER` | accept:4632 | 公会秘境采集排名 | guild secret-realm gather ranking |
| `C_GUILD_GROUP` | send:8546 | 公会战分组 | guild war grouping |
| `C_GUILD_BUYBUFFER` | send:8547 | 公会战BUFFER购买 | buy the guild war buffer |
| `C_PLAYER_REFAIRE` | send:8548 | 公会战玩家增援 | guild war player reinforcement |
| `C_ENTER_GUILDCAMPAIGN` | send:8471 | 进入工会战 | enter the guild war |
| `C_CROSS_GUILD_REQUEST` | send:8468 | 跨服公会战客户端请求 | cross guild war client request |
| `U_C_CROSS_GUILD_MAIN` | accept:4377 | 跨服公会战界面主信息 | cross guild war main info |
| `U_C_CROSS_GUILD_SIGN_STATE` | accept:4378 | 跨服公会战界面报名对阵 | cross guild war signup and bracket |
| `U_C_CROSS_GUILD_MEMBER_LIST` | accept:4379 | 跨服公会战成员列表 | cross guild war member list |
| `U_C_CROSS_GUILD_RANK_LIST` | accept:4380 | 跨服公会战排行榜列表 | cross guild war ranking |

## cross-server

| Name | dir:code | zh | Meaning |
|---|---|---|---|
| `C_ASSAULTWAR_CLIENT_OP` | send:9655 | 冲锋陷阵客户端操作 | assault war client operation |
| `U_C_ASSAULT_INFO` | accept:448 | 冲锋陷阵信息 | assault info |
| `U_C_ASSAULT_MOVE` | accept:449 | 冲锋陷阵通道移动信息 | assault channel movement |
| `U_C_ASSAULT_OPENSTATE` | accept:451 | 冲锋陷阵开启信息 | assault open state |
| `U_C_ASSAULT_RANK` | accept:450 | 冲锋陷阵排行榜 | assault ranking |
| `U_C_ASSAULT_TAB` | accept:452 | 冲锋陷阵面板信息 | assault panel info |
| `U_C_ASSAULT_PREORDER` | accept:454 | 冲锋陷阵天空之城雕像 | assault sky-city statue |
| `U_C_CROSSMULTI_MATCHSTATE` | accept:299 | 跨服多人本开放状态 | cross multiplayer dungeon open state |
| `U_C_CROSS_ARMY_UPDATE` | accept:4494 | 批量军队信息更新 | batch army info update |
| `U_C_CROSS_USER_INFO` | accept:4464 | 跨服个人信息 | cross-server player info |
| `U_C_CROSS_SCORE_REWARD_RESULT` | accept:4482 | 跨服积分奖励领取结果 | cross score reward result |
| `C_TAKE_CROSS_SCORE_REWARD` | send:8590 | | claim the cross score reward |
| `U_C_ENERGY_LIST` | accept:4649 | 跨服战场能量缺口 | cross battle field energy gap |

## reward, activity and mail flows

| Feature | Name | dir:code | zh | Meaning |
|---|---|---|---|---|
| daily-activity | `U_C_ACTIVE_CHECK` | accept:4191 | 活动返回值 | activity response |
| daily-activity | `U_C_CLICKADD` | accept:4413 | 返回日常活动点击增加 | daily activity click increment |
| daily-activity | `U_C_OFFLINE_REWARD` | accept:4195 | 离线经验奖励 | offline experience reward |
| daily-activity | `C_TAKE_OFFLINE_REWARD` | send:8287 | 领取离线奖励 | claim the offline reward |
| exchange | `U_C_ACTIVE_EXCHANGE` | accept:4433 | 兑换礼包列表信息 | exchange gift pack list |
| friends | `C_SHARE_TAKEREWARD` | send:9590 | faceBook玩家分享成功领取奖励 | claim the reward after a facebook share |
| friends | `U_C_SHARE` | accept:336 | facebook分享 | facebook share |
| friends | `U_C_FBEVENT2` | accept:4921 | FB分享事件2 | facebook share event 2 |
| returning-players | `C_BACK_PLAYER_REWARD` | send:8634 | 勇士回归领取礼包 | returning warrior claims the gift |
| returning-players | `U_C_KING_INFO` | accept:4900 | 玩家王者之塔挑战信息 | king tower challenge info |
| quiz | `U_C_ENTER_QUIZ_SCENE` | send:8803 | 进入答题副本 | enter the quiz dungeon |
| inventory | `U_C_BOX_REWARD` | accept:4718 | 聚魂炼金领取宝箱返回协议 | soul-alchemy box claim |
| inventory | `U_C_EQUIPMENT_REFINING` | accept:339 | 装备精炼 | equipment refining |

## castle, hook and world

| Feature | Name | dir:code | zh | Meaning |
|---|---|---|---|---|
| castle | `C_ACTIVE_QUEUE_REQUEST` | send:9612 | 请求更新左侧队列 | request the left activity queue refresh |
| castle | `C_BLESSING_WATCH` | send:8485 | 祝福轮盘查看 | view the blessing wheel |
| castle | `C_HANGUP_PVP` | send:8525 | 修行神殿PK | cultivation temple PvP (hook) |
| castle | `U_C_PLAYER_HANGUPSTATE` | accept:4206 | 挂机状态 | player hangup state |
| world-map | `U_C_WORLD_PROSPERITY` | accept:4438 | 世界繁荣度 | world prosperity |
| world-boss | `C_FIGHT_SPECIAL_BOSS` | send:8251 | 触发特殊BOSS战斗 | trigger a special boss battle |
| abyss | `U_C_ABYSS_PRISON_INFO` | accept:4891 | | abyss prison info |
| three-kingdoms | `C_PLAYER_REFAIRE_GODS` | send:9669 | | gods war reinforcement |
| marriage | `C_WARFIELD_MARRIAGE_ENTER` | send:8967 | 夫妻同时进入战场 | couple enters the battlefield together |
| team | `C_TEAM_CONFIRM` | send:5193 | | team confirm |
| team | `U_C_TEAM_CONFIRM` | accept:4883 | | team confirm result |

## einherjar, dragon, mines, artillery, mazes and dungeons

| Feature | Name | dir:code | zh | Meaning |
|---|---|---|---|---|
| einherjar | `U_C_TOP_CHALLENGE_INFO` | accept:4619 | 返回英灵竞技英雄榜 | einherjar arena hero ranking |
| einherjar | `U_C_GUARD_WAR_BOSS_BUFFER` | accept:439 | 守卫战争BOSS携带Buffer | guard war boss carries a buffer |
| dragon | `C_DRAGON_PICK_BOX` | send:8768 | 拾取宝箱 | magic dragon dungeon box pick |
| dragon | `C_DRAGON_ROLL` | send:8769 | 魔龙操作TYPE=1丢色子 | magic dragon dice roll |
| dragon | `U_C_DRAGON_MY_ROLL` | accept:4663 | 投掷色子信息,包括副本所有玩家的 | dice roll of all dungeon players |
| dragon | `U_C_DRAGON_MAX_ROLL` | accept:4664 | 队伍最大点数 | team maximum dice |
| mines | `C_ENTER_MINE_FIELD` | send:8633 | 玩家点击活动图标进入紫晶矿场 | enter the amethyst mine field |
| mines | `U_C_MINE_ACTIVE_STATE` | accept:4549 | 紫晶矿场活动开启关闭 | mine field activity open or close |
| mines | `U_C_SYNC_MINE_TRAMCAR` | accept:4548 | 矿场玩家矿车信息同步 | mine player tramcar sync |
| mines | `C_CANCEL_TRANS` | send:8535 | 取消拉矿 | cancel ore hauling |
| artillery | `C_CAR_CAMPAIGN_START` | send:8583 | 载具副本开始 | vehicle dungeon start |
| artillery | `U_C_VEHICLE_SYNC_POSITION` | accept:4477 | 载具NPC节点信息 | vehicle NPC node info |
| artillery | `U_C_VEHICLE_SWITCH_MONITOR` | accept:4478 | 载具却换怪物监控者 | vehicle monster monitor switch |
| mazes | `U_C_MONOPOLY_LINK_GAME_INFO` | accept:4759 | 大富翁连连看信息 | monopoly link game info |
| mazes | `U_C_MONOPOLY_GEMMAZE_INFO_SEND` | accept:4760 | 大富翁夺宝奇兵面板打开 | monopoly gem maze panel open |
| mazes | `U_C_MONOPOLY_GEMMAZE_UPDATE` | accept:4761 | 大富翁宝石面板更新 | monopoly gem maze panel update |
| mazes | `U_C_MONOPOLY_GEMMAZE_BUYTIMES_RSP` | accept:4864 | 大富翁购买次数 | monopoly gem maze buy attempts result |
| mazes | `C_MONOPOLY_GEMMAZE_BUYTIMES` | send:8878 | 大富翁次数购买 | buy gem maze attempts |
| mazes | `C_MONOPOLY_GEMMAZE_GEMMOVE` | send:8879 | 大富翁宝石移动 | move a gem in the gem maze |
| arena | `C_MATCH_REQUEST` | send:8294 | 竞技场状态请求 | arena state request |
| battle | `U_B_JOIN` | send:10004 | 进入战斗(判断战斗类型) | enter battle (picks the battle type) |
| battle | `C_REVIVE_OVER` | send:10510 | 复活 | revive finished |
| seasonal-events | `U_C_CHRISTMAS_RESULT` | accept:4958 | 圣诞祈福精品展示 | christmas prayer premium reveal |
| seasonal-events | `U_C_CHRISTMAS_TIMES` | accept:4959 | 圣诞祈福开启次数 | christmas prayer open count |
| seasonal-events | `U_C_CHRISTMAS_TIMES_TRUE` | accept:4960 | 圣诞祈福领取积分奖励成功 | christmas prayer points claimed |
| seasonal-events | `U_C_CHRISTMAS_ALL_PASS` | accept:4961 | 圣诞祈福的稀有物品 | christmas prayer rare item |
| seasonal-events | `U_C_CHRISTMAS_COUNT` | accept:4963 | 圣诞祈福的次数 | christmas prayer attempts |

## Notes

- A row whose `zh` is empty means the client constant carries no description; the meaning was taken from the flow that reads it.
- Entries that also exist in the opposite direction are listed with both codes; the feature folder documents the client side, the server replies with the mirror code.
- These names are the link between the numbered routes in each feature module and `protocol/opcodes.csv`.
