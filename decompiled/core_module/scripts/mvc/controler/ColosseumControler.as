package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.pet.ChallengeRequestMsg;
   import com.road.yishi.proto.player.ChallengeMsg;
   import com.road.yishi.proto.simple.AvaterMsg;
   import com.road.yishi.proto.simple.ChallengeInfoMsg;
   import com.road.yishi.proto.simple.ChallengeLogMsg;
   import com.road.yishi.proto.simple.SimplePlayerInfoMsg;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.FrameController;
   import mvc.module.colosseum.ColosseumEventData;
   import mvc.module.colosseum.ColosseumModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class ColosseumControler extends FrameController
   {
      
      private var _heroRankFrame:Frame;
      
      private var _eventFrame:Frame;
      
      private var _model:ColosseumModel;
      
      private var _intervalTime:Number = 0;
      
      public function ColosseumControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return "colosseum.ColosseumFrame";
      }
      
      override protected function createFrame() : void
      {
         _model = new ColosseumModel();
         initEvent();
         requestData();
      }
      
      override protected function exitFrame() : void
      {
         removeEvent();
         _model = null;
         closeRankFrame();
         super.exitFrame();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
         if(_data.frameData is Function)
         {
            _data.frameData();
            _data = null;
         }
      }
      
      public function closeFrame() : void
      {
         if(_frame)
         {
            _frame.dispose();
         }
      }
      
      private function requestData() : void
      {
         var _loc2_:PackageOut = new PackageOut(8256);
         var _loc1_:ChallengeRequestMsg = new ChallengeRequestMsg();
         _loc1_.type = 0;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4169,__initDataHandler);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4169,__initDataHandler);
      }
      
      private function __initDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:String = null;
         var _loc8_:Array = null;
         var _loc5_:int = 0;
         var _loc9_:String = null;
         var _loc13_:XML = null;
         var _loc16_:String = null;
         var _loc15_:ThaneInfo = null;
         var _loc14_:SimplePlayerInfoMsg = null;
         var _loc12_:AvaterMsg = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:ChallengeLogMsg = null;
         var _loc10_:ColosseumEventData = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChallengeInfoMsg = new ChallengeInfoMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ChallengeInfoMsg;
         model.totalFreeCount = _loc2_.totalCount;
         model.totalBuyCount = _loc2_.totalBuyCount;
         model.currentCount = _loc2_.challengeCount;
         model.currentRank = _loc2_.curRank;
         model.lastWinCount = _loc2_.lastWinCount;
         model.leftDay = _loc2_.leftDay;
         if(_loc2_.hasNoticMsg)
         {
            _loc7_ = _loc2_.noticMsg;
            _loc8_ = _loc7_.match(/\<([^>]*)>*/g);
            _loc5_ = 0;
            while(_loc5_ < _loc8_.length)
            {
               try
               {
                  _loc9_ = _loc8_[_loc5_];
                  _loc13_ = new XML(_loc9_);
                  _loc16_ = _loc13_.@name;
                  _loc7_ = _loc7_.replace(_loc9_,_loc16_);
               }
               catch(e:Error)
               {
                  _loc7_ = "";
               }
               _loc5_++;
            }
            model.noticMsg = _loc7_;
         }
         else
         {
            model.noticMsg = "";
         }
         model.heroList.length = 0;
         model.eventsList.length = 0;
         var _loc11_:int = int(_loc2_.simplePlayer.length);
         _loc5_ = 0;
         while(_loc5_ < _loc11_)
         {
            _loc14_ = _loc2_.simplePlayer[_loc5_];
            _loc15_ = new ThaneInfo();
            _loc15_.userId = _loc14_.userId;
            _loc15_.nickName = _loc14_.nickName;
            _loc15_.templateId = _loc14_.job;
            _loc15_.sexs = _loc14_.sexs;
            _loc15_.pics = _loc14_.pics;
            _loc15_.consortiaName = _loc14_.consortiaName;
            _loc15_.consortiaID = _loc14_.consortiaID;
            _loc15_.grades = _loc14_.grades;
            _loc15_.fightingCapacity = _loc14_.fightingCapacity;
            _loc15_.challengeRank = _loc14_.challengeRank;
            _loc15_.jewelGrades = _loc14_.storeGrade;
            if(_loc15_.challengeRank == 0)
            {
               model.heroList.unshift(_loc15_);
            }
            else
            {
               model.heroList.push(_loc15_);
            }
            _loc5_++;
         }
         _loc11_ = int(_loc2_.avater.length);
         _loc5_ = 0;
         while(_loc5_ < _loc11_)
         {
            _loc12_ = _loc2_.avater[_loc5_] as AvaterMsg;
            _loc15_ = model.getThaneInfoById(_loc12_.userId);
            if(_loc15_)
            {
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_.clothTempId);
               if(_loc3_)
               {
                  _loc15_.bodyEquipAvata = _loc3_.Avata;
               }
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_.armTempId);
               if(_loc3_)
               {
                  _loc15_.armsEquipAvata = _loc3_.Avata;
               }
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_.fashionWingTempId);
               if(_loc3_)
               {
                  _loc15_.wingAvata = _loc3_.Avata;
               }
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_.fashionArmTempId);
               if(_loc3_)
               {
                  _loc15_.armsFashionAvata = _loc3_.Avata;
               }
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_.fashionClothTempId);
               if(_loc3_)
               {
                  _loc15_.bodyFashionAvata = _loc3_.Avata;
               }
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_.fashionHeadTempId);
               if(_loc3_)
               {
                  _loc15_.hairFashionAvata = _loc3_.Avata;
               }
            }
            _loc5_++;
         }
         _loc11_ = int(_loc2_.challengeLog.length);
         _loc5_ = 0;
         while(_loc5_ < _loc11_)
         {
            _loc4_ = _loc2_.challengeLog[_loc5_];
            _loc10_ = new ColosseumEventData();
            _loc10_.userId = _loc4_.userId;
            _loc10_.tarUserId = _loc4_.tarUserId;
            _loc10_.tarNickName = _loc4_.tarNickName;
            _loc10_.tarGrade = _loc4_.grades;
            _loc10_.tarGp = _loc4_.gp;
            _loc10_.tarOrder = _loc4_.gpOrder;
            _loc10_.tarTemplateId = _loc4_.job;
            _loc10_.isAttack = _loc4_.isAttack;
            _loc10_.forward = _loc4_.forward;
            _loc10_.logDate = DateFormatter.parse(_loc4_.logDate,"YYYY-MM-DD hh:mm:ss");
            _loc10_.restult = _loc4_.result;
            _loc10_.curRankResult = _loc4_.curRankResult;
            model.eventsList.push(_loc10_);
            if(model.eventsList.length > 10)
            {
               model.eventsList.splice(9,1);
            }
            _loc5_++;
         }
         super.createFrame();
      }
      
      public function showRankFrame() : void
      {
         if(_heroRankFrame)
         {
            closeRankFrame();
            return;
         }
         _heroRankFrame = ComponentFactory.Instance.creatComponentByStylename("colosseum.HeroRankFrame");
         _heroRankFrame["show"]();
      }
      
      public function closeRankFrame() : void
      {
         if(_heroRankFrame)
         {
            _heroRankFrame.dispose();
            _heroRankFrame = null;
         }
      }
      
      public function showEventFrame() : void
      {
         if(_eventFrame)
         {
            closeEventFrame();
            return;
         }
         _eventFrame = ComponentFactory.Instance.creatComponentByStylename("colosseum.ColossumEventFrame");
         _eventFrame["show"]();
      }
      
      public function closeEventFrame() : void
      {
         if(_eventFrame)
         {
            _eventFrame.dispose();
            _eventFrame = null;
         }
      }
      
      public function sendChallengeById(param1:int, param2:int = 0) : void
      {
         if(getTimer() - _intervalTime < 5000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _intervalTime = getTimer();
         var _loc4_:PackageOut = new PackageOut(8253);
         var _loc3_:ChallengeMsg = new ChallengeMsg();
         _loc3_.tarUserId = param1;
         _loc3_.payType = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function get model() : ColosseumModel
      {
         return _model;
      }
      
      public function set model(param1:ColosseumModel) : void
      {
         if(!param1)
         {
            return;
         }
         _model = param1;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

