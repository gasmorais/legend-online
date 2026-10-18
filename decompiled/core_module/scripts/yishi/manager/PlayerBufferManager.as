package yishi.manager
{
   import com.road.yishi.proto.army.BaseCastleMsg;
   import com.road.yishi.proto.campaign.BufferInfoMsg;
   import com.road.yishi.proto.campaign.CampaignBufferMsg;
   import com.road.yishi.proto.item.BufferDataMsg;
   import com.road.yishi.proto.item.ItemBufferRspMsg;
   import com.road.yishi.proto.player.AdditionMsg;
   import com.road.yishi.proto.player.EffectRemoveReqMsg;
   import com.road.yishi.proto.player.RateUpdate;
   import com.road.yishi.proto.player.RateUpdateReqMsg;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import map.internals.data.BaseCastle;
   import yishi.actions.base.AlertTipAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.events.PlayerBufferEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.SimpleDictionary;
   
   public class PlayerBufferManager extends EventDispatcher
   {
      
      private static var _instance:PlayerBufferManager;
      
      private var _itemBufferList:SimpleDictionary;
      
      private var _campaignBufferList:Vector.<PlayerBufferInfo>;
      
      private var _basePropertyBufferList:SimpleDictionary;
      
      public var basePropertyBuffer:PlayerBufferInfo;
      
      public function PlayerBufferManager()
      {
         super();
         _itemBufferList = new SimpleDictionary();
         _campaignBufferList = new Vector.<PlayerBufferInfo>();
         _basePropertyBufferList = new SimpleDictionary();
      }
      
      public static function get instance() : PlayerBufferManager
      {
         if(!_instance)
         {
            _instance = new PlayerBufferManager();
         }
         return _instance;
      }
      
      public function get itemBufferList() : SimpleDictionary
      {
         return _itemBufferList;
      }
      
      public function get campaignBufferList() : Vector.<PlayerBufferInfo>
      {
         return _campaignBufferList;
      }
      
      public function get basePropertyBufferList() : SimpleDictionary
      {
         return _basePropertyBufferList;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4165,__refreshCampaignBufferHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4188,__refreshItemBufferHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4247,__douleExpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4618,__updatePlayerBasePropertyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4452,__updateDefenceTimeHandler);
      }
      
      private function __updateDefenceTimeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:BaseCastle = PlayerManager.instance.currentPlayerModel.mapNodeInfo;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:BaseCastleMsg = new BaseCastleMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as BaseCastleMsg;
         _loc3_.defenceLeftTime = _loc2_.defenceLefttime;
         var _loc4_:PlayerBufferInfo = _itemBufferList[2001] as PlayerBufferInfo;
         if(_loc4_)
         {
            _loc4_.templateId = 2001;
            _loc4_.bufferType = 2;
            _loc4_.grade = 1;
            _loc4_.goodsTemplateId = 208006;
            if(_loc3_.defenceLeftTime <= 0)
            {
               _itemBufferList.del(_loc4_.templateId);
               TaskTraceTipManager.instance.addBufferDisapearTip(_loc4_);
            }
         }
         else
         {
            _loc4_ = new PlayerBufferInfo();
            _loc4_.templateId = 2001;
            _loc4_.bufferType = 2;
            _loc4_.grade = 1;
            _loc4_.goodsTemplateId = 208006;
            if(_loc4_.goodsTemplateId != 0 && _loc3_.defenceLeftTime > 0)
            {
               _itemBufferList.add(_loc4_.templateId,_loc4_);
            }
         }
         _loc4_.leftTime = _loc3_.defenceLeftTime;
         dispatchEvent(new PlayerBufferEvent("ITEM_BUFFER_UPDATE"));
      }
      
      private function __updatePlayerBasePropertyHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PlayerBufferInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:AdditionMsg = new AdditionMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as AdditionMsg;
         if(_loc2_.isExist)
         {
            if(_basePropertyBufferList[_loc2_.masterType])
            {
               _loc3_ = _basePropertyBufferList[_loc2_.masterType] as PlayerBufferInfo;
               _loc3_.templateId = 2001;
               _loc3_.masterType = _loc2_.masterType;
               _loc3_.description = _loc2_.description;
               _loc3_.bufferType = -4;
               if(_loc2_.masterType == 1000)
               {
                  _loc3_.leftTime = calcLeftTime(_loc2_.expirtDate);
               }
            }
            else
            {
               _loc3_ = new PlayerBufferInfo();
               _loc3_.templateId = 2001;
               _loc3_.masterType = _loc2_.masterType;
               _loc3_.description = _loc2_.description;
               _loc3_.bufferType = -4;
               if(_loc2_.masterType == 1000)
               {
                  _loc3_.leftTime = calcLeftTime(_loc2_.expirtDate);
               }
               _basePropertyBufferList.add(_loc3_.masterType,_loc3_);
            }
         }
         else if(_basePropertyBufferList[_loc2_.masterType])
         {
            _basePropertyBufferList.del(_loc2_.masterType);
         }
         dispatchEvent(new PlayerBufferEvent("ITEM_BUFFER_UPDATE"));
      }
      
      private function calcLeftTime(param1:String) : int
      {
         var _loc3_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         var _loc4_:Number = DateFormatter.parse(param1,"YYYY-MM-DD hh:mm:ss").time / 1000;
         var _loc2_:int = _loc4_ - _loc3_;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      private function getExpRateBufferByServerBufferType(param1:int) : int
      {
         if(param1 == 10000)
         {
            return -3;
         }
         if(param1 == 20000)
         {
            return 20000;
         }
         if(param1 == 30000)
         {
            return -5;
         }
         if(param1 == 40005)
         {
            return 40005;
         }
         if(param1 == 40006)
         {
            return 40006;
         }
         return -1;
      }
      
      private function __douleExpHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc15_:PlayerBufferInfo = null;
         var _loc7_:Boolean = false;
         var _loc13_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc11_:Date = null;
         var _loc10_:Date = null;
         var _loc6_:Date = null;
         var _loc14_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Date = null;
         var _loc16_:Function = null;
         var _loc17_:String = null;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:RateUpdateReqMsg = new RateUpdateReqMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as RateUpdateReqMsg;
         for each(_loc5_ in _loc2_.rateInfo)
         {
            _loc8_ = getExpRateBufferByServerBufferType(_loc5_.bufferType);
            if(_loc5_.rate <= 0)
            {
               _itemBufferList.del(_loc8_);
            }
            else
            {
               _loc15_ = _itemBufferList[_loc8_];
               if(_loc15_)
               {
                  _loc15_.bufferType = _loc8_;
                  _loc15_.rateCount = _loc5_.rate;
                  _loc7_ = false;
               }
               else
               {
                  _loc15_ = new PlayerBufferInfo();
                  _loc15_.templateId = _loc8_;
                  _loc15_.bufferType = _loc8_;
                  _loc15_.name = _loc5_.rateName;
                  _loc15_.description = _loc5_.rateDesc;
                  _loc15_.rateCount = _loc5_.rate;
                  _itemBufferList.add(_loc15_.templateId,_loc15_);
                  _loc7_ = true;
               }
               _loc13_ = DateFormatter.parse(_loc5_.endDay,"YYYY-MM-DD hh:mm:ss").time;
               _loc12_ = DateFormatter.parse(_loc5_.beginDay,"YYYY-MM-DD hh:mm:ss").time;
               _loc11_ = PlayerManager.instance.currentPlayerModel.sysCurtime;
               _loc10_ = new Date();
               _loc6_ = new Date();
               _loc10_.setTime(_loc12_ + _loc5_.beginTime);
               if(_loc5_.beginTime == 0 && _loc5_.endTime == 86399 || _loc15_.bufferType == 20000)
               {
                  _loc6_.setTime(_loc13_ + _loc5_.endTime * 1000);
               }
               else
               {
                  _loc4_ = new Date();
                  _loc4_.setFullYear(_loc11_.fullYear);
                  _loc4_.setMonth(_loc11_.month);
                  _loc4_.setDate(_loc11_.date);
                  _loc4_.setHours(0);
                  _loc4_.setMinutes(0);
                  _loc4_.setSeconds(0);
                  _loc6_.setTime(_loc4_.getTime() + _loc5_.endTime * 1000);
               }
               _loc3_ = (_loc11_.getTime() - _loc10_.getTime()) / 1000;
               _loc14_ = (_loc6_.getTime() - _loc10_.getTime()) / 1000 - _loc3_;
               _loc15_.leftTime = _loc14_;
               if(_loc15_.bufferType == -3 || _loc15_.bufferType == -5 || _loc15_.bufferType == 40005 || _loc15_.bufferType == 40006)
               {
                  _loc15_.leftTime = 0;
               }
               else if(_loc15_.bufferType == 20000)
               {
                  _loc15_.leftTime = 0;
                  _loc15_.description = LanguageMgr.GetTranslation("playerBufferInfo.fashionAdditionDesc",_loc15_.rateCount,DateFormatter.format(_loc6_,"DD/MM/YYYY hh:mm:ss"));
                  if(_loc7_)
                  {
                     _loc16_ = TaskTraceTipManager.instance.alertFashionIndentityBufferTipView;
                     _loc17_ = LanguageMgr.GetTranslation("playerBufferInfo.fashionAdditionDesc2",_loc15_.rateCount);
                     DelayActionsUtils.instance.addAction(new AlertTipAction(_loc17_,_loc16_,"",-1000));
                  }
               }
            }
         }
         dispatchEvent(new PlayerBufferEvent("ITEM_BUFFER_UPDATE"));
      }
      
      private function __refreshCampaignBufferHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PlayerBufferInfo = null;
         _campaignBufferList.splice(0,_campaignBufferList.length);
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignBufferMsg = new CampaignBufferMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as CampaignBufferMsg;
         for each(var _loc3_:BufferInfoMsg in _loc2_.bufferInfo)
         {
            _loc4_ = new PlayerBufferInfo();
            _loc4_.templateId = _loc3_.bufferTempId;
            _loc4_.leftTime = _loc3_.leftTime / 1000;
            _loc4_.bufferType = 0;
            _loc4_.addCount = _loc3_.addCount;
            _campaignBufferList.push(_loc4_);
         }
         dispatchEvent(new PlayerBufferEvent("CAMPAIGN_BUFFER_UPDATE"));
      }
      
      private function __refreshItemBufferHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PlayerBufferInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ItemBufferRspMsg = new ItemBufferRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ItemBufferRspMsg;
         for each(var _loc3_:BufferDataMsg in _loc2_.bufferData)
         {
            if(_loc3_.type != 5)
            {
               if(_itemBufferList[_loc3_.templateId])
               {
                  _loc4_ = _itemBufferList[_loc3_.templateId] as PlayerBufferInfo;
                  _loc4_.templateId = _loc3_.templateId;
                  _loc4_.bufferType = _loc3_.type;
                  _loc4_.grade = _loc3_.grade;
                  _loc4_.goodsTemplateId = _loc3_.typeTemplateid;
                  if(_loc3_.validityDate <= 0)
                  {
                     _itemBufferList.del(_loc4_.templateId);
                     TaskTraceTipManager.instance.addBufferDisapearTip(_loc4_);
                  }
               }
               else
               {
                  _loc4_ = new PlayerBufferInfo();
                  _loc4_.addEventListener("complete",__removeBuffHandler);
                  _loc4_.templateId = _loc3_.templateId;
                  _loc4_.bufferType = _loc3_.type;
                  _loc4_.grade = _loc3_.grade;
                  _loc4_.goodsTemplateId = _loc3_.typeTemplateid;
                  if(_loc3_.typeTemplateid != 0)
                  {
                     _itemBufferList.add(_loc4_.templateId,_loc4_);
                  }
                  if(_loc3_.type == 4 || _loc3_.type == 7)
                  {
                     _itemBufferList.add(_loc4_.templateId,_loc4_);
                  }
               }
               _loc4_.leftTime = _loc3_.validityDate * 60;
            }
         }
         dispatchEvent(new PlayerBufferEvent("ITEM_BUFFER_UPDATE"));
      }
      
      private function __removeBuffHandler(param1:Event) : void
      {
         var _loc2_:PlayerBufferInfo = param1.currentTarget as PlayerBufferInfo;
         _loc2_.removeEventListener("complete",__removeBuffHandler);
         removeBuffer(_loc2_);
      }
      
      public function removeBuffer(param1:PlayerBufferInfo) : void
      {
         var _loc3_:PackageOut = null;
         var _loc2_:EffectRemoveReqMsg = null;
         if(!param1)
         {
            return;
         }
         if(param1.templateId == 2001)
         {
            _loc3_ = new PackageOut(8562);
         }
         else
         {
            _loc3_ = new PackageOut(8283);
            _loc2_ = new EffectRemoveReqMsg();
            _loc2_.templateId = param1.templateId;
            _loc2_.ownType = param1.bufferType;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function getItemBufferInfo(param1:int) : PlayerBufferInfo
      {
         return _itemBufferList[param1];
      }
      
      public function getItemBufferInfoByType(param1:int) : PlayerBufferInfo
      {
         for each(var _loc2_:PlayerBufferInfo in PlayerBufferManager.instance.itemBufferList)
         {
            if(_loc2_.bufferType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function exist(param1:int) : Boolean
      {
         return _itemBufferList[param1];
      }
   }
}

