package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.guardpve.GuardPVEReqMsg;
   import com.road.yishi.proto.guardpve.GuardPVERspMsg;
   import com.road.yishi.proto.guardpve.GuardPosMsg;
   import com.road.yishi.proto.pet.PetInfoMsg;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import mvc.module.children.BossInfo;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildPveModel;
   import mvc.module.children.ChildPveOrderInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.cate.ChildPveBossTemplateCate;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildPveController extends FrameController
   {
      
      private static const OP_TYPE_BOSS_INFO:int = 1;
      
      private static const OP_TYPE_CHILD_POS:int = 2;
      
      private static const OP_TYPE_CHALLEGE:int = 3;
      
      public var refreshFunction:Function;
      
      private var playerInfo:PlayerInfo;
      
      public var loaders:Dictionary;
      
      public var classDefineDic:Dictionary = new Dictionary(true);
      
      public var armyPawnDefineDic:Dictionary = new Dictionary(true);
      
      public var childDefineDic:Dictionary = new Dictionary(true);
      
      public var shapePool:Dictionary = new Dictionary(true);
      
      private var _frameInfo:ModuleFrameInfo;
      
      private var _pveModel:ChildPveModel = new ChildPveModel();
      
      private var _info:ChildPatrolTowerInfo;
      
      public function ChildPveController()
      {
         playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         super();
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function preStart(param1:ModuleFrameInfo) : void
      {
         _frameInfo = param1;
         _info = param1.frameData as ChildPatrolTowerInfo;
         getBossAndSkillFromTemp();
         if(model.childList.length > 0)
         {
            sendReqChildPveInfo();
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("managers.ChildManager.pickChildTips"));
         }
      }
      
      public function getBossAndSkillFromTemp() : Vector.<SkillTempInfo>
      {
         var _loc2_:ChildPveBossTemplateCate = TempleteManager.instance.childPveBossTemplateCate;
         var _loc3_:Array = _loc2_.getAllSkillId();
         return TempleteManager.instance.getChildPveSkillById(_loc3_);
      }
      
      private function __refreshBossInfo(param1:SLGSocketEvent) : void
      {
         var _loc4_:ChildPveBossTemplateCate = null;
         var _loc15_:Array = null;
         var _loc6_:Array = null;
         var _loc12_:Array = null;
         var _loc10_:int = 0;
         var _loc2_:Array = null;
         var _loc7_:int = 0;
         var _loc3_:Array = null;
         var _loc13_:Array = null;
         var _loc8_:int = 0;
         var _loc5_:BossInfo = null;
         var _loc9_:int = 0;
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc14_:GuardPVERspMsg = new GuardPVERspMsg();
         _loc14_ = _loc11_.readBody(_loc14_) as GuardPVERspMsg;
         pveModel.rank = _loc14_.wantedOrder;
         pveModel.process = _loc14_.maxBossId;
         if(_loc14_.skills)
         {
            _loc15_ = _loc14_.skills.split(",");
            _loc4_ = TempleteManager.instance.childPveBossTemplateCate;
            _loc6_ = _loc4_.getAllSkillId();
            _loc12_ = [];
            _loc10_ = 0;
            while(_loc10_ < _loc6_.length)
            {
               if(_loc15_.indexOf(_loc6_[_loc10_] + "") > -1)
               {
                  _loc12_.push(_loc6_[_loc10_] + "");
               }
               _loc10_++;
            }
            pveModel.skillInfo = _loc12_;
         }
         else
         {
            pveModel.skillInfo = [];
         }
         if(_loc14_.guardPos)
         {
            _loc2_ = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
            _loc7_ = 0;
            while(_loc7_ < _loc14_.guardPos.length)
            {
               _loc2_[_loc14_.guardPos[_loc7_].param2] = _loc14_.guardPos[_loc7_].param1;
               _loc7_++;
            }
            _loc3_ = [_loc2_[1],_loc2_[4],_loc2_[7],_loc2_[10],_loc2_[3],_loc2_[6],_loc2_[9],_loc2_[12]];
            model.formationString = _loc3_.join(",");
         }
         if(_loc14_.bossInfo)
         {
            if(_loc14_.opType == 1)
            {
               _loc13_ = [];
               _loc4_ = TempleteManager.instance.childPveBossTemplateCate;
               _loc8_ = 0;
               while(_loc8_ < _loc14_.bossInfo.length)
               {
                  _loc5_ = new BossInfo();
                  _loc5_.tempId = _loc14_.bossInfo[_loc8_].bossOrder;
                  _loc5_.index = _loc14_.bossInfo[_loc8_].bossIndex;
                  _loc5_.isBeat = _loc14_.bossInfo[_loc8_].bossState == 1;
                  _loc5_.grade = _loc4_.getTemplateById(_loc14_.bossInfo[_loc8_].bossOrder).grade;
                  _loc13_.push(_loc5_);
                  _loc8_++;
               }
               _loc13_.sortOn("index");
               _pveModel.bossInfo = _loc13_;
            }
            else if(_loc14_.opType == 2)
            {
               _loc9_ = 0;
               while(_loc9_ < _pveModel.bossInfo.length)
               {
                  if(_pveModel.bossInfo[_loc9_].tempId == _loc14_.bossInfo[0].bossOrder)
                  {
                     _pveModel.bossInfo[_loc9_].isBeat = _loc14_.bossInfo[_loc8_].bossState == 1;
                  }
                  _loc9_++;
               }
            }
         }
         if(_loc14_.opType == 1)
         {
            start(_frameInfo);
         }
      }
      
      public function sendReqChildPveInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(9548);
         var _loc1_:GuardPVEReqMsg = new GuardPVEReqMsg();
         _loc1_.opType = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendChildFormation(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:GuardPosMsg = null;
         var _loc8_:PackageOut = new PackageOut(9548);
         var _loc2_:GuardPVEReqMsg = new GuardPVEReqMsg();
         _loc2_.opType = 2;
         var _loc3_:Array = [];
         var _loc4_:Array = param1.split(",");
         var _loc7_:Array = [1,4,7,10,3,6,9,12];
         _loc5_ = 0;
         while(_loc5_ < model.childList.length)
         {
            _loc6_ = _loc4_.indexOf("" + model.childList[_loc5_].childId);
            model.childList[_loc5_].pos = _loc6_ == -1 ? -1 : _loc7_[_loc6_];
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < model.childList.length)
         {
            _loc9_ = new GuardPosMsg();
            _loc9_.param1 = model.childList[_loc5_].childId;
            _loc9_.param2 = model.childList[_loc5_].pos;
            _loc9_.param2 = _loc9_.param2 == 0 ? -1 : _loc9_.param2;
            _loc3_.push(_loc9_);
            _loc5_++;
         }
         _loc2_.guardPos = _loc3_;
         SocketSendManager.instance.sendProtoBuffer(_loc8_,_loc2_);
      }
      
      public function sendFight(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9548);
         var _loc2_:GuardPVEReqMsg = new GuardPVEReqMsg();
         _loc2_.opType = 3;
         _loc2_.index = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendPetSkills(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8726);
         var _loc3_:PetInfoMsg = new PetInfoMsg();
         _loc3_.petId = param1;
         _loc3_.chaSkillIndexs = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function openFormationFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("childpve.ChildFormationFrame");
         _loc1_["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "childpve.ChildPatrolPointFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_frame.hasOwnProperty("data"))
         {
            _frame["data"] = _info;
         }
         _frame["show"]();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(_info == null)
         {
            FrameControllerManager.instance.openControllerByInfo("childpatrol",1);
            return;
         }
         if(param1)
         {
            super.start(param1);
         }
         else if(_frameInfo)
         {
            super.start(_frameInfo);
         }
      }
      
      public function getShape(param1:int) : Shape
      {
         var _loc3_:Shape = null;
         var _loc2_:Array = shapePool[param1] as Array;
         if(!_loc2_)
         {
            _loc2_ = [];
            shapePool[param1] = _loc2_;
         }
         if(_loc2_.length > 0)
         {
            _loc3_ = _loc2_.pop();
         }
         return _loc3_;
      }
      
      public function saveShape(param1:int, param2:Shape) : void
      {
         if(!param2)
         {
            return;
         }
         if(param2.parent)
         {
            param2.parent.removeChild(param2);
         }
         var _loc3_:Array = shapePool[param1] as Array;
         if(!_loc3_)
         {
            _loc3_ = [];
            shapePool[param1] = _loc3_;
         }
         if(_loc3_.indexOf(param2) < 0)
         {
            _loc3_.push(param2);
         }
      }
      
      public function loadChildPveOrderData() : void
      {
         var _loc1_:String = PathManager.getChildPveOrderPath();
         LoaderManagerII.instance.load(_loc1_,5,8,__OrderLoadCompleteHandler);
      }
      
      private function __OrderLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:ChildPveOrderInfo = null;
         if(!param2)
         {
            pveModel.orderTime = new Date();
            pveModel.orderList.length = 0;
            pveModel.updateOrderList();
            return;
         }
         var _loc6_:XMLList = XML(param2)..info;
         pveModel.orderTime = DateFormatter.parse(_loc6_[0].@createDate,"YYYY-MM-DD hh:mm:ss");
         pveModel.orderList.length = 0;
         var _loc7_:XMLList = XML(param2)..GuardPVEOrder;
         var _loc5_:int = 1;
         for each(var _loc3_:XML in _loc7_)
         {
            _loc4_ = new ChildPveOrderInfo();
            _loc4_.userId = int(_loc3_.@userId);
            _loc4_.process = int(_loc3_.@maxBossID);
            _loc4_.fight = _loc3_.@totalFightPower;
            _loc4_.nickName = _loc3_.@NickName;
            _loc4_.consortiaName = _loc3_.@ConsortiaName;
            _loc4_.grades = int(_loc3_.@Grades);
            _loc4_.rank = _loc5_++;
            _loc4_.fightingCapacity = int(_loc3_.@FightingCapacity);
            _loc4_.isVip = _loc3_.@IsVip == "true";
            pveModel.orderList.push(_loc4_);
         }
         pveModel.orderList.sort(sortOrder);
         pveModel.updateOrderList();
      }
      
      private function sortOrder(param1:ChildPveOrderInfo, param2:ChildPveOrderInfo) : int
      {
         if(param1.rank < param2.rank)
         {
            return -1;
         }
         if(param1.rank > param2.rank)
         {
            return 1;
         }
         return 0;
      }
      
      public function closeFrame() : void
      {
         _frame.dispose();
      }
      
      public function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      public function get pveModel() : ChildPveModel
      {
         return _pveModel;
      }
   }
}

