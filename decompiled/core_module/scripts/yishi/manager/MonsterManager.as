package yishi.manager
{
   import com.road.yishi.proto.campaign.MonsterAccessoryHammerMsg;
   import com.road.yishi.proto.monster.CallInfoMsg;
   import com.road.yishi.proto.monster.CookInfoMsg;
   import com.road.yishi.proto.monster.ItemCountMsg;
   import com.road.yishi.proto.monster.MonsterClientOpMsg;
   import com.road.yishi.proto.monster.MonsterListMsg;
   import com.road.yishi.proto.monster.MonsterMsg;
   import com.road.yishi.proto.monster.MonsterUserMsg;
   import com.road.yishi.proto.store.StoreReqMsg;
   import mvc.module.monster.MonsterCallInfo;
   import mvc.module.monster.MonsterCookInfo;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   
   public class MonsterManager
   {
      
      private static var _instance:MonsterManager;
      
      private var _model:MonsterModel;
      
      public function MonsterManager()
      {
         super();
      }
      
      public static function get instance() : MonsterManager
      {
         if(!_instance)
         {
            _instance = new MonsterManager();
         }
         return _instance;
      }
      
      public function get model() : MonsterModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new MonsterModel();
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4574,__monsterListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4575,__monsterUserInfoHandler);
      }
      
      private function __monsterListHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:MonsterInfo = null;
         var _loc5_:MonsterInfo = null;
         var _loc6_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonsterListMsg = new MonsterListMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as MonsterListMsg;
         var _loc3_:ThaneInfo = thane;
         _loc3_.beginChanges();
         for each(var _loc4_:MonsterMsg in _loc2_.monsters)
         {
            _loc5_ = model.getMonsterById(_loc4_.monsterId);
            if(!_loc4_.isExist)
            {
               model.monsterDic.del(_loc4_.monsterId);
               if(_loc5_)
               {
                  _loc6_ = model.showMonsterList.indexOf(_loc5_);
                  if(_loc6_ != -1)
                  {
                     model.showMonsterList.splice(_loc6_,1);
                  }
               }
            }
            else
            {
               _loc8_ = model.monsterDic[_loc4_.monsterId];
               if(_loc8_ == null)
               {
                  _loc8_ = new MonsterInfo();
                  model.monsterDic.add(_loc4_.monsterId,_loc8_);
                  if(!_loc5_)
                  {
                     model.showMonsterList.push(_loc8_);
                  }
               }
               _loc8_.monsterId = _loc4_.monsterId;
               _loc8_.isExist = _loc4_.isExist;
               _loc8_.firstValue = _loc4_.first;
               _loc8_.enterWar = _loc4_.isFight;
               _loc8_.isLock = _loc4_.isLock;
               _loc8_.name = _loc4_.name;
               _loc8_.fightPower = _loc4_.fightPower;
               _loc8_.type = _loc4_.type;
               _loc8_.star = _loc4_.star;
               _loc8_.grade = _loc4_.level;
               _loc8_.curExp = _loc4_.exp;
               _loc8_.stageGrade = _loc4_.stageLevel;
               _loc8_.stageExp = _loc4_.stateExp;
               _loc8_.skillExpValue = _loc4_.skills;
               _loc8_.isFollow = _loc4_.isFollow;
               _loc8_.setOtherData();
            }
         }
         if(_model.getFollowMonster())
         {
            _loc3_.monsterTempteId = _model.getFollowMonster().tempInfo.TemplateId;
         }
         else
         {
            _loc3_.monsterTempteId = 0;
         }
         _loc3_.commit();
         model.copyMonsterBagData();
         model.showMonsterList.sortOn("firstValue",0x10 | 2);
         MsgMan.notifyObserver("MONSTER_INFO_CHANGE",_loc2_.opType);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __monsterUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:MonsterCallInfo = null;
         var _loc5_:MonsterCookInfo = null;
         var _loc8_:GoodsInfo = null;
         var _loc7_:GoodsTemplateInfo = null;
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:MonsterUserMsg = new MonsterUserMsg();
         _loc2_ = _loc10_.readBody(_loc2_) as MonsterUserMsg;
         for each(var _loc6_:CallInfoMsg in _loc2_.calls)
         {
            _loc4_ = model.magicCircleDic[_loc6_.index];
            if(_loc4_ == null)
            {
               _loc4_ = new MonsterCallInfo();
               model.magicCircleDic.add(_loc6_.index,_loc4_);
            }
            _loc4_.index = _loc6_.index;
            _loc4_.level = _loc6_.level;
            _loc4_.state = _loc6_.state;
            _loc4_.stopDate = DateFormatter.parse(_loc6_.stopTime,"YYYY-MM-DD hh:mm:ss");
         }
         for each(var _loc3_:CookInfoMsg in _loc2_.cooks)
         {
            _loc5_ = model.cookDic[_loc3_.index];
            if(_loc5_ == null)
            {
               _loc5_ = new MonsterCookInfo();
               model.cookDic.add(_loc3_.index,_loc5_);
            }
            _loc5_.index = _loc3_.index;
            _loc5_.level = _loc3_.level;
            _loc5_.state = _loc3_.state;
            _loc5_.stopDate = DateFormatter.parse(_loc3_.stopTime,"YYYY-MM-DD hh:mm:ss");
         }
         if(_loc2_.opType == 4 || _loc2_.opType == 0)
         {
            model.cleanItemBag();
         }
         for each(var _loc9_:ItemCountMsg in _loc2_.items)
         {
            _loc8_ = new GoodsInfo();
            _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc9_.templateId);
            _loc8_.templateId = _loc9_.templateId;
            _loc8_.count = _loc9_.count;
            if(_loc7_.SonType == 231)
            {
               model.callBagDic.add(_loc9_.templateId,_loc8_);
            }
            else if(_loc7_.SonType == 230)
            {
               model.trainBagDic.add(_loc9_.templateId,_loc8_);
            }
         }
         if(_loc2_.recipes.length > 0)
         {
            model.recipesList = _loc2_.recipes;
         }
         if(_loc2_.contracts.length > 0)
         {
            model.contractIds = _loc2_.contracts;
         }
         if(_loc2_.opType == 0 || _loc2_.opType == 6)
         {
            model.exploreMonsterIds = _loc2_.exploreFights;
         }
         if(_loc2_.opType == 0)
         {
            MsgMan.notifyObserver("MONSTER_USER_INFO_CHANGE");
         }
         else if(_loc2_.opType == 2)
         {
            MsgMan.notifyObserver("MONSTER_CALL_CHANGE");
         }
         else if(_loc2_.opType == 3)
         {
            MsgMan.notifyObserver("MONSTER_COOK_CHANGE");
         }
         else if(_loc2_.opType == 4)
         {
            MsgMan.notifyObserver("MONSTER_ITEMMSG_CHANGE");
         }
         else if(_loc2_.opType == 5)
         {
            MsgMan.notifyObserver("MONSTER_RECIPE_CHANGE");
         }
         else if(_loc2_.opType == 6)
         {
            MsgMan.notifyObserver("MONSTER_EXPLORE_IDLIST");
         }
         else if(_loc2_.opType == 8)
         {
            MsgMan.notifyObserver("CONTRACT_INFO_CHANGE");
         }
      }
      
      public function sendMonsterInfoRequest() : void
      {
         var _loc2_:PackageOut = new PackageOut(8652);
         var _loc1_:MonsterClientOpMsg = new MonsterClientOpMsg();
         _loc1_.opType = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public function sendMonsterOperate(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8652);
         var _loc3_:MonsterClientOpMsg = new MonsterClientOpMsg();
         _loc3_.opType = param1;
         _loc3_.monsterId = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendMonsterCallAndCookRequest(param1:int, param2:int = -1) : void
      {
         var _loc4_:PackageOut = new PackageOut(8652);
         var _loc3_:MonsterClientOpMsg = new MonsterClientOpMsg();
         _loc3_.opType = param1;
         if(param2 != -1)
         {
            _loc3_.index = param2;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendMonsterCall(param1:int, param2:Array) : void
      {
         var _loc4_:PackageOut = new PackageOut(8652);
         var _loc3_:MonsterClientOpMsg = new MonsterClientOpMsg();
         _loc3_.opType = 2;
         _loc3_.index = param1;
         _loc3_.items = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendMonsterTrain(param1:int, param2:Array) : void
      {
         var _loc4_:PackageOut = new PackageOut(8652);
         var _loc3_:MonsterClientOpMsg = new MonsterClientOpMsg();
         _loc3_.opType = 15;
         _loc3_.monsterId = param1;
         _loc3_.items = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendMonsterSkillPractice(param1:int, param2:int, param3:Array) : void
      {
         var _loc5_:PackageOut = new PackageOut(8652);
         var _loc4_:MonsterClientOpMsg = new MonsterClientOpMsg();
         _loc4_.opType = 14;
         _loc4_.monsterId = param1;
         _loc4_.skillId = param2;
         _loc4_.items = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function sendMonsterEvolve(param1:int, param2:Array) : void
      {
         var _loc4_:PackageOut = new PackageOut(8652);
         var _loc3_:MonsterClientOpMsg = new MonsterClientOpMsg();
         _loc3_.opType = 16;
         _loc3_.monsterId = param1;
         _loc3_.items = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendMonsterIntensify(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(5150);
         var _loc2_:StoreReqMsg = new StoreReqMsg();
         _loc2_.opType = 2;
         _loc2_.count = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendMonsterBreakthrough() : void
      {
         var _loc1_:PackageOut = new PackageOut(5441);
         SocketManager.instance.socket.send(_loc1_);
      }
      
      public function sendMonsterHammer(param1:int, param2:Array, param3:int = 1, param4:int = 1, param5:Boolean = false) : void
      {
         var _loc7_:PackageOut = new PackageOut(5440);
         var _loc6_:MonsterAccessoryHammerMsg = new MonsterAccessoryHammerMsg();
         _loc6_.skillIndex = param1;
         _loc6_.materialTempIdList = param2;
         _loc6_.hammerCount = param3;
         _loc6_.aimSkillGrade = param4;
         _loc6_.isAuto = param5;
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc6_);
      }
      
      public function sendSelectContract(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8652);
         var _loc3_:MonsterClientOpMsg = new MonsterClientOpMsg();
         _loc3_.opType = 21;
         _loc3_.index = param1;
         _loc3_.monsterId = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

