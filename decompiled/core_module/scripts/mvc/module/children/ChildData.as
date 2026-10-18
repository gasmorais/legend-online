package mvc.module.children
{
   import com.road.yishi.proto.children.ChildrenInfoMsg;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class ChildData
   {
      
      public var childId:int;
      
      public var bornTime:String;
      
      public var userIdA:int;
      
      public var sex:int;
      
      public var job:int;
      
      public var name:String;
      
      public var templateId:int;
      
      public var state:int;
      
      public var pos:int;
      
      public var Hp:Number;
      
      public var fightValue:int;
      
      public var fightPos:int;
      
      private var _fightUserId:int;
      
      private var _fightSlaveUserId:int;
      
      public var isSlaveChild:Boolean;
      
      public var growthGrade:int;
      
      public var growthGp:int;
      
      public var growthCount:int;
      
      private var _skill:String;
      
      private var _fightSkill:String;
      
      public var isSelfData:Boolean = true;
      
      public var emblemLv:int;
      
      public var emblemGp:int;
      
      public var childAssistAwakeLevel:int;
      
      private var _enterPet:EnterChildPet;
      
      public var nursingSpiritInfo:NursingSpiritInfo;
      
      private var _childAttValueInfo:ChildAttValueInfo;
      
      private var _skillBooks:String;
      
      public var upgradeGrowthDic:Dictionary;
      
      private var _equipList:Array;
      
      private var _emblemList:Array;
      
      public function ChildData()
      {
         super();
         _equipList = [];
         upgradeGrowthDic = new Dictionary();
         upgradeGrowthDic["1"] = [0,0,0,0,0];
         upgradeGrowthDic["2"] = [4860,900,975,900,975];
         upgradeGrowthDic["3"] = [12960,2400,2600,2400,2600];
         upgradeGrowthDic["4"] = [24300,4500,4875,4500,4875];
         upgradeGrowthDic["5"] = [38880,7200,7800,7200,7800];
         upgradeGrowthDic["6"] = [56700,10500,11375,10500,11375];
         upgradeGrowthDic["7"] = [77760,14400,15600,14400,15600];
         upgradeGrowthDic["8"] = [102060,18900,20475,18900,20475];
         upgradeGrowthDic["9"] = [129600,24000,26000,24000,26000];
         upgradeGrowthDic["10"] = [162000,30000,32500,30000,32500];
         _emblemList = [];
      }
      
      public static function createChildWithXML(param1:XML) : ChildData
      {
         var _loc3_:GoodsInfo = null;
         var _loc4_:ChildData = new ChildData();
         _loc4_.childId = parseInt(param1.@ChildId);
         _loc4_.name = param1.@ChildName;
         _loc4_.job = param1.@job;
         _loc4_.sex = param1.@sex;
         _loc4_.state = param1.@state;
         _loc4_.growthCount = param1.@GrowthCount;
         _loc4_.growthGp = param1.@GrowthGp;
         _loc4_.growthGrade = param1.@GrowthGrade;
         _loc4_.fightValue = param1.@FightCapacity;
         _loc4_.isSelfData = false;
         for each(var _loc2_:XML in param1..ChildItemInfo)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.id = 1;
            _loc3_.templateId = _loc2_.@TemplateId;
            _loc3_.pos = _loc2_.@Pos;
            _loc3_.isBinds = _loc2_.@IsBinds;
            _loc3_.join1 = _loc2_.@Join1;
            _loc3_.join2 = _loc2_.@Join2;
            _loc3_.join3 = _loc2_.@Join3;
            _loc3_.join4 = _loc2_.@Join4;
            _loc3_.randomSkill1 = _loc2_.@RandomSkill1;
            _loc3_.randomSkill2 = _loc2_.@RandomSkill2;
            _loc3_.randomSkill3 = _loc2_.@RandomSkill3;
            _loc3_.randomSkill4 = _loc2_.@RandomSkill4;
            _loc3_.randomSkill5 = _loc2_.@RandomSkill5;
            _loc3_.mouldGrade = _loc2_.@MouldGrade;
            _loc3_.strengthenGrade = _loc2_.@StrengthenGrade;
            _loc4_.equipList.push(_loc3_);
         }
         return _loc4_;
      }
      
      public function get fightSlaveUserId() : int
      {
         return _fightSlaveUserId;
      }
      
      public function set fightSlaveUserId(param1:int) : void
      {
         if(_fightSlaveUserId == param1)
         {
            return;
         }
         _fightSlaveUserId = param1;
         MsgMan.notifyObserver("ChildEvent.SLAVED_ENTER_CHANGE");
      }
      
      public function get fightUserId() : int
      {
         return _fightUserId;
      }
      
      public function set fightUserId(param1:int) : void
      {
         if(_fightUserId == param1)
         {
            return;
         }
         _fightUserId = param1;
         MsgMan.notifyObserver("ChildEvent.ENTER_CHANGE");
      }
      
      public function get enterPet() : EnterChildPet
      {
         if(_enterPet == null)
         {
            _enterPet = new EnterChildPet();
         }
         return _enterPet;
      }
      
      public function get childAttInfo() : ChildAttValueInfo
      {
         if(_childAttValueInfo == null)
         {
            _childAttValueInfo = new ChildAttValueInfo();
         }
         return _childAttValueInfo;
      }
      
      public function set fightSkill(param1:String) : void
      {
         this._fightSkill = param1;
      }
      
      public function get fightSkill() : String
      {
         return _fightSkill;
      }
      
      public function set skill(param1:String) : void
      {
         this._skill = param1;
      }
      
      public function get skill() : String
      {
         return _skill;
      }
      
      public function get sexLanguage() : String
      {
         var _loc1_:String = "";
         if(sex == 0)
         {
            _loc1_ = LanguageMgr.GetTranslation("sns.SNSModel.sex02");
         }
         else if(sex == 1)
         {
            _loc1_ = LanguageMgr.GetTranslation("sns.SNSModel.sex01");
         }
         return _loc1_;
      }
      
      public function get jobLanguage() : String
      {
         var _loc1_:String = "";
         if(job == 1)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name02");
         }
         else if(job == 2)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name03");
         }
         else if(job == 3)
         {
            _loc1_ = LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name04");
         }
         return _loc1_;
      }
      
      public function set skillBooks(param1:String) : void
      {
         _skillBooks = param1;
      }
      
      public function get skillBooks() : String
      {
         return _skillBooks;
      }
      
      public function set emblemList(param1:Array) : void
      {
         _emblemList = param1;
      }
      
      public function get emblemList() : Array
      {
         return _emblemList;
      }
      
      public function createChildWithMsg(param1:ChildrenInfoMsg, param2:ChildData = null) : ChildData
      {
         if(!param2)
         {
            param2 = new ChildData();
         }
         if(param1.hasChildId)
         {
            param2.childId = param1.childId;
         }
         if(param1.hasName)
         {
            param2.name = param1.name;
         }
         if(param1.hasJob)
         {
            param2.job = param1.job;
         }
         if(param1.hasSex)
         {
            param2.sex = param1.sex;
         }
         if(param1.hasUserIdA)
         {
            param2.userIdA = param1.userIdA;
         }
         if(param1.hasGrowthGrade)
         {
            param2.growthGrade = param1.growthGrade;
         }
         if(param1.hasGrowthGp)
         {
            param2.growthGp = param1.growthGp;
         }
         if(param1.hasGrowthCount)
         {
            param2.growthCount = param1.growthCount;
         }
         if(param1.hasFightCapacity)
         {
            param2.fightValue = param1.fightCapacity;
         }
         if(param1.hasState)
         {
            param2.state = param1.state;
         }
         return param2;
      }
      
      public function get equipList() : Array
      {
         return _equipList;
      }
      
      public function get growthValue() : int
      {
         var _loc2_:int = 0;
         var _loc1_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(growthGrade,44);
         if(_loc1_)
         {
            _loc2_ = _loc1_.TemplateId;
         }
         return _loc2_;
      }
      
      public function get childPower() : Number
      {
         var _loc1_:Number = 100;
         var _loc2_:Number = 0;
         if(_loc1_ < 40)
         {
            _loc2_ = 80;
         }
         else if(_loc1_ >= 40 && _loc1_ < 90)
         {
            _loc2_ = 80 + Math.floor((_loc1_ - 40) / 5) * 3;
         }
         else if(_loc1_ >= 90 && _loc1_ <= 100)
         {
            _loc2_ = 110 + Math.floor((_loc1_ - 90) / 5) * 5;
         }
         return _loc2_;
      }
      
      public function get ResiValueArr() : Array
      {
         var _loc1_:int = 0;
         var _loc3_:EmblemInfo = null;
         var _loc4_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(job,growthGrade);
         var _loc2_:Array = [0,0,0,0,0,0,0];
         _loc1_ = 1;
         while(_loc1_ <= 6)
         {
            _loc3_ = emblemList[_loc1_] as EmblemInfo;
            if(_loc3_)
            {
               if(_loc1_ == 1)
               {
                  _loc2_[0] = _loc3_.getValueByIndex(1);
               }
               else
               {
                  var _loc5_:Number = _loc3_.resi1 - 1;
                  var _loc6_:* = _loc2_[_loc5_] + _loc3_.getValueByIndex(1);
                  _loc2_[_loc5_] = _loc6_;
                  _loc2_[_loc3_.resi2 - 1] += _loc3_.getValueByIndex(2);
                  _loc2_[_loc3_.resi3 - 1] += _loc3_.getValueByIndex(3);
               }
            }
            _loc1_++;
         }
         _loc6_ = 0;
         _loc5_ = _loc2_[_loc6_] + _loc4_.ReduceResi;
         _loc2_[_loc6_] = _loc5_;
         _loc2_[1] += _loc4_.FireResi + enterPet.resFire;
         _loc2_[2] += _loc4_.WaterResi + enterPet.resWater;
         _loc2_[3] += _loc4_.ElectResi + enterPet.resElect;
         _loc2_[4] += _loc4_.WindResi + enterPet.resWind;
         _loc2_[5] += _loc4_.DarkResi + enterPet.resDark;
         _loc2_[6] += _loc4_.LightResi + enterPet.resLight;
         return _loc2_;
      }
      
      public function get isNursingSpirit() : Boolean
      {
         var _loc1_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(job,growthGrade);
         if(_loc1_ && _loc1_.MasterType == 1)
         {
            return true;
         }
         return false;
      }
      
      public function get childTempInfo() : ChildTempInfo
      {
         return TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(job,growthGrade);
      }
   }
}

