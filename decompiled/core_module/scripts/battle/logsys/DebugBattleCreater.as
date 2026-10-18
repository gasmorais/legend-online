package battle.logsys
{
   import battle.BattleManager;
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.battle.ArmyMsg;
   import com.road.yishi.proto.battle.BattleCreateMsg;
   import com.road.yishi.proto.battle.BattleItemMsg;
   import com.road.yishi.proto.battle.HeroMsg;
   import com.road.yishi.proto.battle.SoldierMsg;
   import com.road.yishi.proto.battle.StarBufferMsg;
   import mvc.module.pet.PetData;
   import mvc.module.star.StarInfo;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleDictionary;
   
   public class DebugBattleCreater
   {
      
      public function DebugBattleCreater()
      {
         super();
      }
      
      public static function send(param1:Array, param2:Array, param3:int) : void
      {
         var _loc9_:HeroMsg = null;
         var _loc17_:* = null;
         var _loc18_:HeroMsg = null;
         var _loc6_:Array = null;
         var _loc5_:Array = null;
         var _loc7_:int = 0;
         var _loc10_:PackageOut = new PackageOut(10003);
         var _loc4_:BattleCreateMsg = new BattleCreateMsg();
         _loc4_.mapTempId = param3;
         _loc4_.attackerNum = 1;
         _loc4_.userSide = 1;
         _loc4_.army = [];
         var _loc11_:int = PlayerManager.instance.currentPlayerModel.userInfo.userId;
         var _loc19_:Array = [];
         var _loc15_:Array = [];
         var _loc12_:Array = [];
         for each(_loc17_ in param1)
         {
            if(_loc17_.isHero == 1)
            {
               if(_loc17_.isSelf)
               {
                  _loc18_ = createHero(_loc17_);
               }
               else
               {
                  _loc19_.push(createHero(_loc17_));
               }
            }
            else if(_loc17_.isHero == 0)
            {
               _loc15_.push(createSoldier(_loc17_));
            }
            else if(_loc17_.isHero == 2)
            {
               _loc9_ = createHero(_loc17_);
               _loc12_.push(_loc9_);
            }
         }
         var _loc16_:ThaneInfo = ArmyManager.instance.thane;
         if(_loc16_.battleGuardInfo)
         {
            _loc6_ = _loc16_.battleGuardInfo.getAllPoint();
         }
         if(_loc16_.enterWarPet)
         {
            _loc5_ = [];
            _loc5_[0] = 0;
            _loc5_[1] = _loc16_.enterWarPet.resFire;
            _loc5_[2] = _loc16_.enterWarPet.resWater;
            _loc5_[3] = _loc16_.enterWarPet.resWind;
            _loc5_[4] = _loc16_.enterWarPet.resElect;
            _loc5_[5] = _loc16_.enterWarPet.resLight;
            _loc5_[6] = _loc16_.enterWarPet.resDark;
         }
         var _loc8_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < 7)
         {
            if(_loc6_)
            {
               _loc8_[_loc7_] = int(_loc6_[_loc7_]);
            }
            if(_loc5_)
            {
               var _loc21_:int = _loc7_;
               var _loc20_:Number = _loc8_[_loc21_] + int(_loc5_[_loc7_]);
               _loc8_[_loc21_] = _loc20_;
            }
            _loc7_++;
         }
         if(_loc18_.reduceResi == 0)
         {
            _loc18_.reduceResi = _loc8_[0];
         }
         if(_loc18_.fireResi == 0)
         {
            _loc18_.fireResi = _loc8_[1];
         }
         if(_loc18_.waterResi == 0)
         {
            _loc18_.waterResi = _loc8_[2];
         }
         if(_loc18_.windResi == 0)
         {
            _loc18_.windResi = _loc8_[3];
         }
         if(_loc18_.electResi == 0)
         {
            _loc18_.electResi = _loc8_[4];
         }
         if(_loc18_.lightResi == 0)
         {
            _loc18_.lightResi = _loc8_[5];
         }
         if(_loc18_.darkResi == 0)
         {
            _loc18_.darkResi = _loc8_[6];
         }
         var _loc13_:String = ArmyManager.instance.army.nickName;
         var _loc14_:ArmyMsg = createArmy(1,0,"10001",2,1,1,_loc19_,_loc15_,1,2);
         _loc14_ = createArmy(2,_loc11_,_loc13_,1,1,0,[_loc18_],[],1,1,_loc12_);
         _loc4_.army.push(_loc14_);
         _loc19_ = [];
         _loc15_ = [];
         for each(_loc17_ in param2)
         {
            if(_loc17_.isHero)
            {
               _loc19_.push(createHero(_loc17_));
            }
            else
            {
               _loc15_.push(createSoldier(_loc17_));
            }
         }
         _loc14_ = createArmy(3,0,"222",2,2,1,_loc19_,_loc15_,1,2);
         _loc4_.army.push(_loc14_);
         if(BattleManager.getInstance().started || _loc19_.length == 0 && _loc15_.length == 0)
         {
            return;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc10_,_loc4_);
      }
      
      private static function createArmy(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int, param7:Array, param8:Array, param9:int, param10:int, param11:Array = null) : ArmyMsg
      {
         var _loc14_:PetData = null;
         var _loc13_:HeroMsg = null;
         var _loc12_:ArmyMsg = new ArmyMsg();
         _loc12_.id = param1;
         _loc12_.userId = param2;
         _loc12_.name = param3;
         _loc12_.type = param4;
         _loc12_.side = param5;
         _loc12_.formation = param6;
         _loc12_.hero = param7;
         _loc12_.soldier = param8;
         _loc12_.result = param9;
         _loc12_.isJoin = true;
         _loc12_.armyType = param10;
         if(param2 == PlayerManager.instance.currentPlayerModel.userInfo.userId)
         {
            _loc14_ = PlayerManager.instance.currentPlayerModel.playerInfo.enterWarPet;
            if(_loc14_)
            {
               _loc13_ = createPet(_loc14_,param7[0]);
               _loc12_.pet = [_loc13_];
            }
         }
         if(param11)
         {
            _loc12_.childs = param11;
         }
         return _loc12_;
      }
      
      private static function createHero(param1:Object) : HeroMsg
      {
         var _loc2_:* = null;
         var _loc3_:HeroMsg = new HeroMsg();
         _loc3_.heroId = param1.heroId;
         _loc3_.livingId;
         _loc3_.userId = param1.userId;
         _loc3_.userPics = param1.userPics;
         _loc3_.tempId = param1.tempId;
         _loc3_.type = param1.type;
         _loc3_.nickName = param1.nickName;
         _loc3_.grade = param1.grade;
         _loc3_.side = param1.side;
         _loc3_.pos = param1.pos;
         _loc3_.maxHp = Int64Utils.numberToInt64(param1.maxHp);
         _loc3_.initHp = Int64Utils.numberToInt64(param1.initHp);
         _loc3_.hp = Int64Utils.numberToInt64(param1.hp);
         _loc3_.initHp2;
         _loc3_.hp2;
         _loc3_.sp;
         _loc3_.slotAvata;
         _loc3_.clothAvate;
         _loc3_.captain;
         _loc3_.res;
         _loc3_.qteTime;
         _loc3_.castTime;
         _loc3_.pics;
         _loc3_.job = param1.job;
         _loc3_.phyAttack = param1.phyAttack;
         _loc3_.phyDefence = param1.phyDefence;
         _loc3_.magAttack = param1.magAttack;
         _loc3_.magDefence = param1.magDefence;
         _loc3_.forceHit = param1.forceHit;
         _loc3_.parry = param1.parry;
         if(param1.waterResi != 0)
         {
            _loc3_.waterResi = param1.waterResi;
         }
         if(param1.fireResi != 0)
         {
            _loc3_.fireResi = param1.fireResi;
         }
         if(param1.windResi != 0)
         {
            _loc3_.windResi = param1.windResi;
         }
         if(_loc3_.lightResi != 0)
         {
            _loc3_.lightResi = param1.lightResi;
         }
         if(param1.darkResi != 0)
         {
            _loc3_.darkResi = param1.darkResi;
         }
         if(param1.reduceResi != 0)
         {
            _loc3_.reduceResi = param1.reduceRes;
         }
         if(param1.isHero == 2)
         {
            _loc3_.defaultSkills = param1.DefaultSkills;
            _loc3_.growthGrade = param1.growthGrade;
         }
         _loc3_.skillScript = param1.skillScript;
         _loc2_ = _loc2_;
         if(_loc2_.userId == _loc3_.userId && _loc2_.talentData.talentScript)
         {
            _loc3_.skillScript += _loc2_.talentData.talentScript;
         }
         if(param1.skill1)
         {
            _loc3_.skillScript += "," + param1.skill1;
         }
         if(param1.skill2)
         {
            _loc3_.skillScript += "," + param1.skill2;
         }
         if(param1.skill3)
         {
            _loc3_.skillScript += "," + param1.skill3;
         }
         if(param1.skill4)
         {
            _loc3_.skillScript += "," + param1.skill4;
         }
         _loc3_.skillScript += enchantSkillScript;
         _loc3_.pawnTempId = param1.pawnTempId;
         _loc3_.skillId = param1.skillId;
         _loc3_.starBuffer = createStarBuffers(param1);
         if(param1.type == 1)
         {
         }
         return _loc3_;
      }
      
      private static function get enchantSkillScript() : String
      {
         var _loc3_:GoodsInfo = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:String = "";
         var _loc4_:int = ArmyManager.instance.thane.id;
         _loc1_ = 4;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc3_ = GoodsManager.instance.getItemByPOB(_loc2_,_loc4_,_loc1_);
            if(_loc3_ && _loc3_.enchantSkillId > 0)
            {
               _loc5_ += "," + _loc3_.enchantSkillId;
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private static function createPet(param1:PetData, param2:HeroMsg) : HeroMsg
      {
         if(!param1)
         {
            return null;
         }
         var _loc3_:HeroMsg = new HeroMsg();
         _loc3_.heroId = param1.petId;
         _loc3_.nickName = param1.name;
         _loc3_.tempId = param1.templateId;
         _loc3_.grade = param1.grade;
         _loc3_.maxHp = Int64Utils.numberToInt64(param1.Live);
         _loc3_.hp = Int64Utils.numberToInt64(param1.Live);
         _loc3_.pos = param2.pos;
         _loc3_.sites = param2.sites;
         _loc3_.type = param1.template.PetType;
         _loc3_.phyAttack = param1.Attack;
         _loc3_.phyDefence = param1.Defence;
         _loc3_.magAttack = param1.MagicAttack;
         _loc3_.magDefence = param1.MagicDefence;
         _loc3_.fireResi = param1.resFire;
         _loc3_.waterResi = param1.resWater;
         _loc3_.electResi = param1.resElect;
         _loc3_.windResi = param1.resWind;
         _loc3_.darkResi = param1.resDark;
         _loc3_.lightResi = param1.resLight;
         _loc3_.defaultSkills = param1.template.DefaultSkills;
         _loc3_.followSkills = param1.followSkills;
         _loc3_.changeSkills = param1.changeSkills;
         return _loc3_;
      }
      
      private static function createSoldier(param1:Object) : SoldierMsg
      {
         var _loc2_:SoldierMsg = new SoldierMsg();
         _loc2_.livingId;
         _loc2_.tempId = param1.tempId;
         _loc2_.type;
         _loc2_.side = param1.side;
         _loc2_.pos = param1.pos;
         _loc2_.initHp = param1.initHp;
         _loc2_.hp = param1.hp;
         _loc2_.qteTime;
         _loc2_.castTime;
         _loc2_.armyPawnId = param1.armyPawnId;
         _loc2_.grade = param1.grade;
         _loc2_.phyAttack = param1.phyAttack;
         _loc2_.phyDefence = param1.phyDefence;
         _loc2_.magAttack = param1.magAttack;
         _loc2_.magDefence = param1.magDefence;
         _loc2_.forceHit = param1.forceHit;
         _loc2_.parry = param1.parry;
         _loc2_.sites;
         _loc2_.skillId = param1.skillId;
         return _loc2_;
      }
      
      private static function createStarBuffers(param1:Object) : Array
      {
         var i:int;
         var data:StarInfo;
         var str:String;
         var info:Object = param1;
         var createStarMem:* = function(param1:String):StarBufferMsg
         {
            var _loc2_:StarBufferMsg = new StarBufferMsg();
            var _loc3_:Array = param1.split(",");
            _loc2_.skillId = _loc3_[0];
            _loc2_.level = _loc3_.length > 1 ? _loc3_[1] : 1;
            return _loc2_;
         };
         var arr:Array = [];
         if(info.star1 != "")
         {
            arr.push(createStarMem(info.star1));
         }
         if(info.star2 != "")
         {
            arr.push(createStarMem(info.star2));
         }
         if(info.star3 != "")
         {
            arr.push(createStarMem(info.star3));
         }
         if(info.star4 != "")
         {
            arr.push(createStarMem(info.star4));
         }
         if(info.star5 != "")
         {
            arr.push(createStarMem(info.star5));
         }
         if(info.star6 != "")
         {
            arr.push(createStarMem(info.star6));
         }
         if(info.star7 != "")
         {
            arr.push(createStarMem(info.star7));
         }
         if(info.star8 != "")
         {
            arr.push(createStarMem(info.star8));
         }
         if(arr.length < 1)
         {
            i = 0;
            while(i < 8)
            {
               data = StarManager.instance.getStarInfoByBagTypeAndPos(2,i);
               if(data)
               {
                  str = data.template.TemplateId + "," + data.grade;
                  arr.push(createStarMem(str));
               }
               i = i + 1;
            }
         }
         return arr;
      }
      
      private static function addSelfItems(param1:Array) : void
      {
         var _loc4_:* = null;
         var _loc2_:BattleItemMsg = null;
         var _loc3_:SimpleDictionary = GoodsManager.instance.getBattleRunes();
         for each(_loc4_ in _loc3_)
         {
            _loc2_ = transformItem(_loc4_);
            param1[_loc2_.bagPos] = _loc2_;
         }
      }
      
      private static function transformItem(param1:GoodsInfo) : BattleItemMsg
      {
         var _loc2_:BattleItemMsg = new BattleItemMsg();
         _loc2_.userId = PlayerManager.instance.currentPlayerModel.userInfo.userId;
         _loc2_.battleId = "0";
         _loc2_.uItemId = param1.id;
         _loc2_.count = param1.count;
         _loc2_.tempId = param1.templateId;
         _loc2_.bagPos = param1.pos;
         _loc2_.skillTempId = param1.templateInfo.Property1;
         _loc2_.sonType = param1.templateInfo.SonType;
         return _loc2_;
      }
   }
}

