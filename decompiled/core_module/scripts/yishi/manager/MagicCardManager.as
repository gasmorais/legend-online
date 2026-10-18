package yishi.manager
{
   import com.road.yishi.proto.magiccard.MagicCardInfoListMsg;
   import com.road.yishi.proto.magiccard.MagicCardInfoMsg;
   import com.road.yishi.proto.powcard.PowCardBufListMsg;
   import com.road.yishi.proto.powcard.PowCardBufMsg;
   import com.road.yishi.proto.powcard.PowCardReqMsg;
   import com.road.yishi.proto.powcard.PowcardFightAddMsg;
   import com.road.yishi.proto.powcard.Singlefightadd;
   import events.MagicCardEvent;
   import flash.events.EventDispatcher;
   import mvc.module.card.MagicCardBuffInfo;
   import mvc.module.card.MagicCardFightInfo;
   import mvc.module.card.MagicCardInfo;
   import mvc.module.card.MagicCardModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class MagicCardManager extends EventDispatcher
   {
      
      private static var _instance:MagicCardManager;
      
      private var _cardModel:MagicCardModel;
      
      public function MagicCardManager()
      {
         super();
         if(!_cardModel)
         {
            _cardModel = new MagicCardModel();
         }
      }
      
      public static function get Instance() : MagicCardManager
      {
         if(!_instance)
         {
            _instance = new MagicCardManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4903,__cardCampaignBuffHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4905,__cardAllHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4902,__cardFightAddHandler);
      }
      
      private function __cardFightAddHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:MagicCardFightInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PowcardFightAddMsg = new PowcardFightAddMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PowcardFightAddMsg;
         var _loc3_:Vector.<MagicCardFightInfo> = new Vector.<MagicCardFightInfo>();
         for each(var _loc4_:Singlefightadd in _loc2_.singlefightadd)
         {
            _loc6_ = new MagicCardFightInfo();
            _loc6_.op = _loc4_.op;
            _loc6_.userId = _loc4_.userid;
            _loc6_.campType = _loc4_.campType;
            _loc6_.add = _loc4_.add;
            _loc3_.push(_loc6_);
         }
         cardModel.cardFightInfoList = _loc3_;
      }
      
      private function __cardCampaignBuffHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:MagicCardBuffInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PowCardBufListMsg = new PowCardBufListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PowCardBufListMsg;
         var _loc3_:Array = [];
         for each(var _loc4_:PowCardBufMsg in _loc2_.bufInfos)
         {
            _loc6_ = new MagicCardBuffInfo();
            _loc6_.bufId = _loc4_.bufId;
            _loc6_.sonType = _loc4_.sonType;
            _loc6_.fixvalue = _loc4_.fixValue;
            _loc6_.percent = _loc4_.percent;
            _loc3_.push(_loc6_);
         }
         cardModel.updateCampaignBuff(_loc3_);
         sendDispatchEvent("MAGICCARD_CAMPAIGN_BUFF");
      }
      
      private function __cardAllHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:MagicCardInfoMsg = null;
         var _loc4_:MagicCardInfo = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:MagicCardInfoListMsg = new MagicCardInfoListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as MagicCardInfoListMsg;
         _cardModel.allActivatedCard = [];
         _cardModel.activatedPosByType = {};
         _loc5_ = 0;
         while(_loc5_ < _loc2_.cardInfos.length)
         {
            _loc3_ = _loc2_.cardInfos[_loc5_];
            _loc4_ = new MagicCardInfo();
            _loc4_.templateId = _loc3_.templateId;
            _loc4_.gp = _loc3_.gp;
            _loc4_.grades = _loc3_.grades;
            _loc4_.pos = TempleteManager.instance.magicCardTemplateCate.getInfoByIdAndGardes(_loc3_.templateId,_loc3_.grades).Pos;
            _loc4_.skillTempIds = _loc3_.skillTempIds;
            _loc4_.templateName = _loc3_.templateName;
            _loc4_.types = _loc3_.types;
            if(_loc3_.hasIsActive)
            {
               _loc4_.isActive = _loc3_.isActive;
            }
            _cardModel.addActivatedCard(_loc4_);
            _loc5_++;
         }
         sendDispatchEvent("MAGICCARD_UPDATE");
      }
      
      public function get cardModel() : MagicCardModel
      {
         return _cardModel;
      }
      
      public function updateMagicCard(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9505);
         var _loc3_:PowCardReqMsg = new PowCardReqMsg();
         _loc3_.op = param1;
         _loc3_.cardId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendDispatchEvent(param1:String, param2:* = null) : void
      {
         dispatchEvent(new MagicCardEvent(param1,param2));
      }
   }
}

