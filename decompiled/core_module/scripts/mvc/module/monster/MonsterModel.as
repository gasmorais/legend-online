package mvc.module.monster
{
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.datas.templates.MonsterTempInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TalentEffectInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterModel
   {
      
      public static const OWN_MAX_COUNT:int = 12;
      
      public static const TRAIN_RATE_MAX_COUNT:int = 6;
      
      public static const MATERIAL_BAG_COUNT:int = 70;
      
      public static const CALL_BAG_COUNT:int = 10;
      
      public static const CALL_COOK_MAX_GRADE:int = 3;
      
      public var propStrAry:Array = ["Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live"];
      
      private var _selectMonster:MonsterInfo;
      
      public var ownMaxCount:int;
      
      public var monsterDic:SimpleDictionary;
      
      public var showMonsterList:Array;
      
      public var monsterTempAry:Array;
      
      public var monsterSkillTempDic:Dictionary;
      
      public var skillSontypeAry:Array;
      
      public var rateBagList:Array;
      
      public var trainBagDic:SimpleDictionary;
      
      public var callBagDic:SimpleDictionary;
      
      public var callMaterialList:Array;
      
      public var monsterBagDic:SimpleDictionary;
      
      public var monsterMaterialList:Array;
      
      public var upgradeTempAry:Array;
      
      public var stageUpgradeTempAry:Array;
      
      public var skillUpgradeTempAry:Array;
      
      public var magicCircleDic:SimpleDictionary;
      
      public var cookDic:SimpleDictionary;
      
      public var recipesList:Array;
      
      public var exploreMonsterIds:Array;
      
      public var accessoriesUpgradeTempAry:Array;
      
      public var isStrengethenPanel:Boolean = true;
      
      public var isAutoHammer:Boolean = false;
      
      public var contractIds:Array = [0,0,0];
      
      public function MonsterModel()
      {
         var _loc2_:int = 0;
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         super();
         monsterDic = new SimpleDictionary(true);
         monsterSkillTempDic = new Dictionary();
         monsterTempAry = [];
         skillSontypeAry = [];
         rateBagList = [];
         trainBagDic = new SimpleDictionary(true);
         callMaterialList = [];
         callBagDic = new SimpleDictionary(true);
         monsterMaterialList = [];
         monsterBagDic = new SimpleDictionary(true);
         magicCircleDic = new SimpleDictionary(true);
         cookDic = new SimpleDictionary(true);
         recipesList = [];
         showMonsterList = [];
         exploreMonsterIds = [];
         for each(var _loc6_:MonsterTempInfo in TempleteManager.instance.monsterTempCate.getTemplates())
         {
            _loc2_ = getMaxStarByType(_loc6_.Type);
            if(_loc6_.Star == _loc2_)
            {
               monsterTempAry.push(_loc6_);
               _loc5_ = _loc6_.SkillSonTypes.split(",");
               _loc5_ = _loc5_.concat(_loc6_.PassiveSkillSonTypes.split(","));
               _loc3_ = 0;
               while(_loc3_ < _loc5_.length)
               {
                  _loc1_ = int(_loc5_[_loc3_]);
                  if(skillSontypeAry.indexOf(_loc1_) == -1)
                  {
                     skillSontypeAry.push(_loc5_[_loc3_]);
                  }
                  _loc3_++;
               }
            }
         }
         monsterTempAry.sortOn("Type",16);
         for each(var _loc4_:SkillTempInfo in TempleteManager.instance.skillTemplateDic)
         {
            if(skillSontypeAry.indexOf(_loc4_.SonType.toString()) != -1)
            {
               if(!monsterSkillTempDic[_loc4_.SonType])
               {
                  monsterSkillTempDic[_loc4_.SonType] = [];
               }
               monsterSkillTempDic[_loc4_.SonType].push(_loc4_);
            }
         }
         upgradeTempAry = TempleteManager.instance.getTemplatesByType(147);
         stageUpgradeTempAry = TempleteManager.instance.getTemplatesByType(148);
         skillUpgradeTempAry = TempleteManager.instance.getTemplatesByType(149);
         accessoriesUpgradeTempAry = TempleteManager.instance.getTemplatesByType(151);
         ownMaxCount = ConfigInfoManager.instance.getMonsterOwnMaxCount();
      }
      
      public function get selectMonster() : MonsterInfo
      {
         if(_selectMonster)
         {
            return monsterDic[_selectMonster.monsterId];
         }
         return _selectMonster;
      }
      
      public function set selectMonster(param1:MonsterInfo) : void
      {
         if(selectMonster == param1)
         {
            return;
         }
         _selectMonster = param1;
         resetBagList();
         copyMonsterBagData();
         MsgMan.notifyObserver("MONSTER_ITEM_SELECT");
      }
      
      public function getShowSkillByMonster(param1:MonsterTempInfo) : Array
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:SkillTempInfo = null;
         if(!param1)
         {
            return [];
         }
         var _loc2_:Array = [];
         var _loc3_:Array = param1.SkillSonTypes.split(",");
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = int(_loc3_[_loc5_]);
            _loc6_ = getMonsterMaxSkillTemp(_loc4_);
            if(_loc6_.UseWay == 1)
            {
               _loc2_.push(_loc6_);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function getMonsterMaxSkillTemp(param1:int) : SkillTempInfo
      {
         var _loc2_:Array = monsterSkillTempDic[param1];
         if(_loc2_.length <= 0)
         {
            return null;
         }
         _loc2_.sortOn("Grades",0x10 | 2);
         return _loc2_[0];
      }
      
      public function getUpgradeSkillTemp(param1:SkillTempInfo, param2:int) : SkillTempInfo
      {
         var _loc4_:int = 0;
         var _loc3_:SkillTempInfo = null;
         var _loc5_:Array = monsterSkillTempDic[param1.SonType];
         if(_loc5_.length <= 0)
         {
            return null;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc4_];
            if(_loc3_.Grades == param2)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getSkillResolveGrade(param1:MonsterInfo, param2:SkillTempInfo) : int
      {
         var _loc5_:int = 0;
         var _loc3_:MonsterTempInfo = null;
         var _loc4_:Array = null;
         if(!param1 || !param2)
         {
            return 0;
         }
         var _loc6_:Array = TempleteManager.instance.monsterTempCate.getTemplateByType(param1.type);
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc3_ = _loc6_[_loc5_];
            _loc4_ = _loc3_.SkillSonTypes.split(",");
            if(_loc4_.indexOf(param2.SonType.toString()) != -1)
            {
               return _loc3_.Star;
            }
            _loc5_++;
         }
         return 0;
      }
      
      public function getMaxMonsterTempInfo(param1:MonsterInfo) : MonsterTempInfo
      {
         for each(var _loc2_:MonsterTempInfo in monsterTempAry)
         {
            if(_loc2_.Type == param1.type)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getSkillViewShowList(param1:MonsterInfo, param2:int = 1) : Array
      {
         var _loc6_:Array = null;
         var _loc8_:SkillTempInfo = null;
         if(!param1)
         {
            return [];
         }
         var _loc3_:Array = [];
         var _loc7_:MonsterTempInfo = getMaxMonsterTempInfo(param1);
         var _loc4_:Array = param2 == 1 ? _loc7_.SkillSonTypes.split(",") : _loc7_.PassiveSkillSonTypes.split(",");
         for each(var _loc5_:int in _loc4_)
         {
            _loc6_ = monsterSkillTempDic[_loc5_];
            _loc8_ = _loc6_[_loc6_.length - 1];
            if(_loc8_.UseWay == param2)
            {
               _loc3_.push(_loc6_[_loc6_.length - 1]);
            }
         }
         _loc3_.sortOn("SonType",16);
         return _loc3_;
      }
      
      public function getLearnSkillTemp(param1:SkillTempInfo, param2:MonsterInfo) : SkillTempInfo
      {
         if(!param1)
         {
            return null;
         }
         for each(var _loc3_:SkillTempInfo in param2.skillAry)
         {
            if(param1.SonType == _loc3_.SonType)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function moveBagToRate(param1:GoodsInfo) : void
      {
         if(rateBagList.length >= 6)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerEquipBagCellDropMediator.command01"));
            return;
         }
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1.templateId;
         _loc2_.count = 1;
         rateBagList.push(_loc2_);
         if(trainBagDic[param1.templateId])
         {
            trainBagDic[param1.templateId].count -= 1;
            if(trainBagDic[param1.templateId].count <= 0)
            {
               trainBagDic.del(param1.templateId);
            }
         }
      }
      
      public function moveRateToBag(param1:GoodsInfo, param2:Boolean) : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         if(trainBagDic[param1.templateId] == null)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = param1.templateId;
         }
         else
         {
            _loc3_ = trainBagDic[param1.templateId];
         }
         _loc3_.count += 1;
         trainBagDic.add(param1.templateId,_loc3_);
         if(param2)
         {
            _loc4_ = rateBagList.length - 1;
            while(_loc4_ >= 0)
            {
               _loc5_ = rateBagList[_loc4_];
               if(_loc5_.templateId == param1.templateId)
               {
                  rateBagList.splice(_loc4_,1);
                  break;
               }
               _loc4_--;
            }
         }
      }
      
      public function resetBagList() : void
      {
         for each(var _loc1_:GoodsInfo in rateBagList)
         {
            if(trainBagDic[_loc1_.templateId] == null && trainBagDic.getList().length >= 70)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerEquipBagCellDropMediator.command01"));
               return;
            }
            moveRateToBag(_loc1_,false);
         }
         rateBagList = [];
      }
      
      public function moveCallBagToMaterial(param1:GoodsInfo) : void
      {
         if(callMaterialList.length >= 6)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerEquipBagCellDropMediator.command01"));
            return;
         }
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1.templateId;
         _loc2_.count = 1;
         callMaterialList.push(_loc2_);
         if(callBagDic[param1.templateId])
         {
            callBagDic[param1.templateId].count -= 1;
            if(callBagDic[param1.templateId].count <= 0)
            {
               callBagDic.del(param1.templateId);
            }
         }
      }
      
      public function moveMaterialToCallBag(param1:GoodsInfo, param2:Boolean) : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         if(callBagDic[param1.templateId] == null)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = param1.templateId;
         }
         else
         {
            _loc3_ = callBagDic[param1.templateId];
         }
         _loc3_.count += 1;
         callBagDic.add(param1.templateId,_loc3_);
         if(param2)
         {
            _loc4_ = callMaterialList.length - 1;
            while(_loc4_ >= 0)
            {
               _loc5_ = callMaterialList[_loc4_];
               if(_loc5_.templateId == param1.templateId)
               {
                  callMaterialList.splice(_loc4_,1);
                  break;
               }
               _loc4_--;
            }
         }
      }
      
      public function resetCallBagList() : void
      {
         for each(var _loc1_:GoodsInfo in callMaterialList)
         {
            if(callBagDic[_loc1_.templateId] == null && callBagDic.getList().length >= 70)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerEquipBagCellDropMediator.command01"));
               return;
            }
            moveMaterialToCallBag(_loc1_,false);
         }
         callMaterialList = [];
      }
      
      public function trainTotalExp(param1:int, param2:Array) : Number
      {
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc3_:Number = param1;
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param2[_loc4_];
            _loc3_ += _loc5_.templateInfo.Property1;
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getTrainNeedGold(param1:Array) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc2_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc2_ += _loc4_.templateInfo.Property3;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getMaterialIds(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1[_loc3_].templateId);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getNextStageMonsterInfo(param1:MonsterInfo) : MonsterInfo
      {
         var _loc2_:MonsterInfo = new MonsterInfo();
         _loc2_.type = param1.type;
         _loc2_.star = param1.star;
         _loc2_.name = param1.name;
         _loc2_.stageGrade = Math.min(param1.stageGrade + 1,getMaxStarByType(_loc2_.type));
         return _loc2_;
      }
      
      public function getRateByMaterials(param1:Array) : int
      {
         var _loc2_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc3_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc4_ = param1[_loc2_];
            _loc3_ += _loc4_.templateInfo.Property2;
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function getNextGradeExp(param1:MonsterInfo) : int
      {
         var _loc2_:UpgradeTemplateInfo = upgradeTempAry[param1.grade - 1];
         return _loc2_ ? _loc2_.Data : 0;
      }
      
      public function getPropValueByIndex(param1:int, param2:MonsterInfo) : int
      {
         var _loc5_:String = propStrAry[param1];
         var _loc3_:SkillPropertyTempInfo = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(param2.tempInfo.PropertyId);
         var _loc4_:Number = int(int(_loc3_[_loc5_]) / 10 / param2.star) * (param2.grade - 1) + int(_loc3_[_loc5_]);
         var _loc6_:UpgradeTemplateInfo = stageUpgradeTempAry[param2.stageGrade];
         return int(_loc4_ * (_loc6_.ActiveObject + 100) / 100);
      }
      
      public function getMaxMonsterInfo(param1:MonsterInfo) : MonsterInfo
      {
         var _loc2_:MonsterInfo = new MonsterInfo();
         _loc2_.type = param1.type;
         _loc2_.name = param1.name;
         _loc2_.star = param1.star;
         _loc2_.stageGrade = param1.star;
         _loc2_.grade = param1.tempInfo.MaxLevel;
         return _loc2_;
      }
      
      public function moveMonsterBagToMaterial(param1:MonsterInfo) : void
      {
         if(monsterMaterialList.length >= 6)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerEquipBagCellDropMediator.command01"));
            return;
         }
         var _loc2_:MonsterInfo = copyMonsterInfo(param1);
         monsterMaterialList.push(_loc2_);
         if(monsterBagDic[param1.monsterId])
         {
            monsterBagDic.del(param1.monsterId);
         }
      }
      
      public function moveMaterialToMonsterBag(param1:MonsterInfo, param2:Boolean) : void
      {
         var _loc3_:MonsterInfo = null;
         var _loc4_:int = 0;
         var _loc5_:MonsterInfo = null;
         if(monsterBagDic[param1.monsterId] == null)
         {
            _loc3_ = copyMonsterInfo(param1);
            monsterBagDic.add(param1.monsterId,_loc3_);
         }
         if(param2)
         {
            _loc4_ = 0;
            while(_loc4_ < monsterMaterialList.length)
            {
               _loc5_ = monsterMaterialList[_loc4_];
               if(_loc5_.monsterId == param1.monsterId)
               {
                  monsterMaterialList.splice(_loc4_,1);
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      public function resetMonsterBagList() : void
      {
         for each(var _loc1_:MonsterInfo in monsterMaterialList)
         {
            if(monsterBagDic.getList().length >= 70)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.playerbag.PlayerEquipBagCellDropMediator.command01"));
               return;
            }
            moveMaterialToMonsterBag(_loc1_,false);
         }
         monsterMaterialList = [];
      }
      
      public function copyMonsterInfo(param1:MonsterInfo) : MonsterInfo
      {
         var _loc2_:MonsterInfo = new MonsterInfo();
         _loc2_.monsterId = param1.monsterId;
         _loc2_.name = param1.name;
         _loc2_.enterWar = param1.enterWar;
         _loc2_.firstValue = param1.firstValue;
         _loc2_.isLock = param1.isLock;
         _loc2_.fightPower = param1.fightPower;
         _loc2_.type = param1.type;
         _loc2_.star = param1.star;
         _loc2_.grade = param1.grade;
         _loc2_.stageGrade = param1.stageGrade;
         _loc2_.skillExpValue = param1.skillExpValue;
         _loc2_.setOtherData();
         return _loc2_;
      }
      
      public function copyMonsterBagData() : void
      {
         monsterMaterialList = [];
         monsterBagDic.clear();
         for each(var _loc1_:MonsterInfo in monsterDic)
         {
            if(!(selectMonster && selectMonster.monsterId == _loc1_.monsterId))
            {
               monsterBagDic.add(_loc1_.monsterId,_loc1_);
            }
         }
      }
      
      public function cleanItemBag() : void
      {
         trainBagDic = new SimpleDictionary(true);
         rateBagList = [];
         callBagDic = new SimpleDictionary(true);
         callMaterialList = [];
      }
      
      public function getSkillExp(param1:MonsterInfo, param2:int) : int
      {
         var _loc3_:int = param1.skillIds.indexOf(param2.toString());
         if(_loc3_ == -1)
         {
            return 0;
         }
         return param1.skillExps[_loc3_];
      }
      
      public function getSkillPracticeTotalExp(param1:int, param2:Array) : int
      {
         var _loc3_:int = param1;
         for each(var _loc4_:MonsterInfo in param2)
         {
            _loc3_ += int(Math.pow(_loc4_.star,2) * 100);
         }
         return _loc3_;
      }
      
      public function getSkillPracticeNeedGold(param1:Array) : Number
      {
         var _loc2_:Number = 0;
         for each(var _loc3_:MonsterInfo in param1)
         {
            _loc2_ += _loc3_.fightPower;
         }
         return _loc2_;
      }
      
      public function getMonsterIds(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1[_loc3_].monsterId);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get enterWarMonster() : MonsterInfo
      {
         for each(var _loc1_:MonsterInfo in monsterDic)
         {
            if(_loc1_.isExist && _loc1_.enterWar)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get getEmptyPos() : int
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         var _loc1_:* = -1;
         _loc2_ = 1;
         while(_loc2_ <= 5)
         {
            _loc3_ = GoodsManager.instance.getHideBagItemByPos(_loc2_);
            if(!_loc3_)
            {
               _loc1_ = _loc2_;
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getEffectTxt(param1:int, param2:Array) : String
      {
         var _loc8_:String = null;
         var _loc7_:Array = null;
         var _loc9_:int = 0;
         var _loc5_:String = null;
         var _loc4_:String = "";
         var _loc6_:SkillTempInfo = getSkillTempInfo(param1,0);
         if(_loc6_)
         {
            _loc8_ = _loc6_.BufferIds;
            _loc7_ = _loc8_.split(",");
            for each(var _loc3_:String in _loc7_)
            {
               _loc9_ = parseInt(_loc3_);
               _loc5_ = getDescStr(_loc9_,param1,param2);
               if(_loc5_ != "")
               {
                  _loc4_ += _loc5_;
               }
            }
         }
         return _loc4_;
      }
      
      private function getDescStr(param1:int, param2:int, param3:Array) : String
      {
         var _loc5_:int = 0;
         var _loc20_:int = 0;
         var _loc11_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc12_:int = 0;
         var _loc23_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:SkillTempInfo = null;
         var _loc26_:String = null;
         var _loc22_:Array = null;
         var _loc27_:int = 0;
         var _loc16_:BufferTemplateInfo = null;
         var _loc24_:String = null;
         var _loc8_:Array = null;
         var _loc21_:int = 0;
         var _loc18_:TalentEffectInfo = null;
         var _loc19_:BufferTemplateInfo = getBufferTempInfo(param1);
         for each(var _loc7_:int in param3)
         {
            _loc14_ = getSkillTempInfo(param2,_loc7_);
            if(_loc14_)
            {
               _loc26_ = _loc14_.BufferIds;
               _loc22_ = _loc26_.split(",");
               for each(var _loc15_:String in _loc22_)
               {
                  _loc27_ = parseInt(_loc15_);
                  _loc16_ = getBufferTempInfo(_loc27_);
                  if(_loc16_)
                  {
                     _loc24_ = _loc16_.TalentEffIds;
                     _loc8_ = _loc24_.split(",");
                     for each(var _loc25_:String in _loc8_)
                     {
                        _loc21_ = parseInt(_loc25_);
                        _loc18_ = getTalentEffectInfo(_loc21_);
                        if(_loc18_)
                        {
                           if(_loc18_.EffBufferType == param1)
                           {
                              _loc10_ += _loc18_.EffBuffPercent;
                              _loc4_ += _loc18_.EffBuffValue;
                              _loc6_ += _loc18_.EffRandPercent;
                              _loc12_ += _loc18_.EffRandValue;
                              _loc23_ += _loc18_.EffCountPercent;
                              _loc13_ += _loc18_.EffCountValue;
                           }
                        }
                     }
                  }
               }
            }
         }
         _loc5_ = _loc19_.AttackValue * (100 + _loc10_) / 100 + _loc4_;
         _loc20_ = _loc19_.ValuePercent * (100 + _loc10_) / 100 + _loc4_;
         _loc11_ = _loc19_.Random * (100 + _loc6_) / 100 + _loc12_;
         _loc9_ = _loc19_.ValidCount * (100 + _loc23_) / 100 + _loc13_;
         var _loc17_:String = _loc19_.Parm3;
         if(!_loc17_)
         {
            _loc17_ = "";
         }
         if(_loc5_ != 0)
         {
            _loc17_ = _loc17_.replace("{AttackValue}",Math.abs(_loc5_) - 1);
         }
         if(_loc20_ != 0)
         {
            _loc17_ = _loc17_.replace("{ValuePercent}",Math.abs(_loc20_) - 1);
         }
         if(_loc11_ > 0)
         {
            _loc17_ = _loc17_.replace("{Random}",_loc11_);
         }
         if(_loc9_ > 0)
         {
            _loc17_ = _loc17_.replace("{ValidCount}",_loc9_);
         }
         if(_loc17_.indexOf("{") != -1)
         {
            return "";
         }
         return _loc17_;
      }
      
      public function getEffectSonType(param1:GoodsInfo) : int
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:SkillTempInfo = null;
         var _loc4_:Object = null;
         var _loc3_:Object = null;
         if(!param1)
         {
            return 0;
         }
         var _loc2_:int = 0;
         var _loc8_:SimpleDictionary = new SimpleDictionary(true);
         _loc5_ = 1;
         while(_loc5_ <= 5)
         {
            _loc7_ = int(param1["randomSkill" + _loc5_]);
            if(_loc7_ > 0)
            {
               _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc7_);
               if(_loc8_[_loc6_.SonType])
               {
                  _loc4_ = _loc8_[_loc6_.SonType];
                  _loc4_.index = _loc5_;
                  _loc4_.grades += _loc6_.Grades;
                  _loc8_.add(_loc6_.SonType,_loc4_);
               }
               else
               {
                  _loc4_ = {};
                  _loc4_.index = _loc5_;
                  _loc4_.sonType = _loc6_.SonType;
                  _loc4_.grades = _loc6_.Grades;
                  _loc8_.add(_loc6_.SonType,_loc4_);
               }
            }
            _loc5_++;
         }
         for each(_loc4_ in _loc8_)
         {
            if(_loc3_)
            {
               if(_loc4_.grades > _loc3_.grades)
               {
                  _loc3_ = _loc4_;
               }
               else if(_loc4_.grades == _loc3_.grades)
               {
                  if(_loc4_.index > _loc3_.index)
                  {
                     _loc3_ = _loc4_;
                  }
               }
            }
            else
            {
               _loc3_ = _loc4_;
            }
         }
         if(_loc3_)
         {
            _loc2_ = int(_loc3_.sonType);
         }
         return _loc2_;
      }
      
      private function getSkillTempInfo(param1:int, param2:int) : SkillTempInfo
      {
         return TempleteManager.instance.getSkillTemplateInfoBySonTypeAndGrade(param1,param2);
      }
      
      private function getBufferTempInfo(param1:int) : BufferTemplateInfo
      {
         return TempleteManager.instance.bufferTemplateCate.getTemplateByID(param1);
      }
      
      private function getTalentEffectInfo(param1:int) : TalentEffectInfo
      {
         return TempleteManager.instance.talentTemplateCate.getTemplateById(param1);
      }
      
      public function checkCanEvolve(param1:MonsterInfo) : Boolean
      {
         if(param1.star >= getMaxStarByType(param1.type))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterTrainView.evolve.starFullAlert"));
            return false;
         }
         if(param1.stageGrade < param1.star)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonsterTrainView.evolve.noStageAlert"));
            return false;
         }
         if(param1.grade < param1.tempInfo.MaxLevel)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("worldmap.data.WorldMapHelper.command01"));
            return false;
         }
         return true;
      }
      
      public function getMonsterById(param1:int) : MonsterInfo
      {
         for each(var _loc2_:MonsterInfo in showMonsterList)
         {
            if(_loc2_.monsterId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMonsterBagShowList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:MonsterInfo in showMonsterList)
         {
            if(monsterBagDic[_loc2_.monsterId])
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getFollowMonster() : MonsterInfo
      {
         for each(var _loc1_:MonsterInfo in showMonsterList)
         {
            if(_loc1_.isFollow == true)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getMaxStarByType(param1:int) : int
      {
         var _loc3_:MonsterTempInfo = null;
         var _loc2_:Array = TempleteManager.instance.monsterTempCate.getTemplateByType(param1);
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc2_[_loc2_.length - 1];
         }
         if(_loc3_)
         {
            return _loc3_.Star;
         }
         return 0;
      }
      
      public function getContractSelectList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:MonsterInfo in monsterDic)
         {
            if(contractIds.indexOf(_loc2_.monsterId) == -1)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sort(sortContractList);
         return _loc1_;
      }
      
      private function sortContractList(param1:MonsterInfo, param2:MonsterInfo) : int
      {
         if(!param1 || !param2)
         {
            return -1;
         }
         if(param1.star > param2.star)
         {
            return -1;
         }
         if(param1.star < param2.star)
         {
            return 1;
         }
         if(param1.grade > param2.grade)
         {
            return -1;
         }
         if(param1.grade < param2.grade)
         {
            return 1;
         }
         return param1.type <= param2.type ? -1 : 1;
      }
      
      public function isShowContractAlert(param1:int) : Boolean
      {
         var _loc7_:int = 0;
         var _loc3_:MonsterInfo = null;
         var _loc8_:GoodsInfo = null;
         var _loc10_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:int = 0;
         var _loc5_:MonsterInfo = monsterDic[contractIds[param1]];
         if(!_loc5_)
         {
            return false;
         }
         var _loc12_:GoodsInfo = GoodsManager.instance.getMonsterBagGoodsInfo(_loc5_.monsterId);
         if(!_loc12_)
         {
            return false;
         }
         var _loc2_:int = getEffectSonType(_loc12_);
         var _loc6_:int = _loc5_.typeIndex;
         var _loc9_:int = getEffectMaxGrade(_loc12_);
         _loc7_ = 0;
         while(_loc7_ < contractIds.length)
         {
            if(_loc7_ != param1)
            {
               _loc3_ = monsterDic[contractIds[_loc7_]];
               if(_loc3_)
               {
                  _loc8_ = GoodsManager.instance.getMonsterBagGoodsInfo(_loc3_.monsterId);
                  if(_loc8_)
                  {
                     _loc10_ = getEffectSonType(_loc8_);
                     _loc4_ = _loc5_.typeIndex;
                     _loc11_ = getEffectMaxGrade(_loc8_);
                     if(_loc6_ == _loc4_ && _loc2_ == _loc10_)
                     {
                        if(_loc9_ < _loc11_)
                        {
                           return true;
                        }
                     }
                  }
               }
            }
            _loc7_++;
         }
         return false;
      }
      
      public function getEffectGradeAry(param1:GoodsInfo) : Array
      {
         var _loc5_:SkillTempInfo = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = getEffectSonType(param1);
         _loc4_ = 1;
         while(_loc4_ <= 5)
         {
            _loc6_ = int(param1["randomSkill" + _loc4_]);
            if(_loc6_ > 0)
            {
               _loc5_ = TempleteManager.instance.getSkillTemplateInfoById(_loc6_);
               if(_loc5_ && _loc5_.SonType == _loc3_)
               {
                  _loc2_.push(_loc5_.Grades);
               }
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getEffectMaxGrade(param1:GoodsInfo) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = getEffectGradeAry(param1);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ += _loc2_[_loc3_];
            _loc3_++;
         }
         return _loc4_;
      }
   }
}

