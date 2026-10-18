package yishi.manager
{
   import com.road.yishi.proto.player.IconNumMsg;
   import com.road.yishi.proto.player.IconNumMsgList;
   import feedback.datas.FeedBackItemData;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import managers.FeedBackManager;
   import managers.FundManager;
   import managers.FundVeinManager;
   import managers.FunnyManager;
   import mvc.module.armyII.RuneInfo;
   import mvc.module.fund.GLogInfo;
   import mvc.module.fund.GetItemInfo;
   import mvc.module.infotips.InfoTipsModel;
   import mvc.module.star.StarInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class InfoTipsManager
   {
      
      private static var _instance:InfoTipsManager;
      
      private var model:InfoTipsModel;
      
      private var _canStudyRuneCount:int;
      
      public function InfoTipsManager()
      {
         super();
         model = new InfoTipsModel();
      }
      
      public static function get instance() : InfoTipsManager
      {
         if(!_instance)
         {
            _instance = new InfoTipsManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4980,onInfoTipsData);
      }
      
      private function onInfoTipsData(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:IconNumMsg = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:IconNumMsgList = new IconNumMsgList();
         _loc2_ = _loc5_.readBody(_loc2_) as IconNumMsgList;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.list.length)
         {
            _loc3_ = _loc2_.list[_loc4_];
            model.valueObj[_loc3_.type] = _loc3_.intValue1;
            _loc4_++;
         }
         dealData();
         if(FundManager.instance.getNewbieShowBtn())
         {
            FundManager.instance.fundNewbieOperate();
         }
      }
      
      public function getData() : void
      {
         var _loc1_:PackageOut = new PackageOut(9550);
         SocketSendManager.instance.sendProtoBuffer(_loc1_,new IconNumMsgList());
      }
      
      public function dealData(param1:int = 0) : void
      {
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:StarInfo = null;
         var _loc9_:Dictionary = null;
         var _loc4_:FeedBackItemData = null;
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         model.valueObj[15] = 1;
         model.valueObj[17] = 1;
         if(param1 == 0 || param1 == 5)
         {
            _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.reloginCount >= 7 ? 7 : PlayerManager.instance.currentPlayerModel.playerInfo.reloginCount);
            _loc7_ = 1;
            while(_loc7_ <= _loc5_)
            {
               if(!PlayerManager.instance.currentPlayerModel.playerInfo.checkIsReceived(_loc7_))
               {
                  _loc6_++;
               }
               _loc7_++;
            }
            model.valueObj[5] = _loc6_;
         }
         try
         {
            _loc3_ = int(TempleteManager.instance.getConfigInfoByConfigName("christmas_item").ConfigValue);
         }
         catch(e:Error)
         {
            _loc3_ = 2131106;
         }
         model.valueObj[6] = GoodsManager.instance.getGoodsNumByTempId(_loc3_);
         model.valueObj[7] = GoodsManager.instance.getGoodsNumByTempId(208022);
         model.valueObj[8] = GoodsManager.instance.getGoodsNumByTempId(208051);
         model.valueObj[9] = PlayerManager.instance.currentPlayerModel.playerInfo.warFieldCount;
         model.valueObj[10] = PlayerManager.instance.currentPlayerModel.playerInfo.JJCcount;
         model.valueObj[11] = GoodsManager.instance.getGoodsNumByTempId(208032);
         if(param1 == 0 || param1 == 13)
         {
            _loc6_ = 0;
            _loc7_ = 0;
            while(_loc7_ < 8)
            {
               _loc8_ = StarManager.instance.getStarInfoByBagTypeAndPos(2,_loc7_);
               if(_loc7_ < int(thane.grades / 10) && _loc8_ == null)
               {
                  _loc6_++;
               }
               _loc7_++;
            }
            if(TaskManage.instance.IsTaskFinish(1802) && ArmyManager.instance.thane.grades >= 60)
            {
               _loc8_ = StarManager.instance.getStarInfoByBagTypeAndPos(2,8);
               if(_loc8_ == null)
               {
                  _loc6_++;
               }
            }
            if(TaskManage.instance.IsTaskFinish(1802) && playerInfo.vocationLevel > 0)
            {
               _loc8_ = StarManager.instance.getStarInfoByBagTypeAndPos(2,9);
               if(_loc8_ == null)
               {
                  _loc6_++;
               }
            }
            model.valueObj[13] = _loc6_;
         }
         if(param1 == 0 || param1 == 14)
         {
            _loc6_ = 0;
            if(thane.skillCate.skillPoint > 0)
            {
               _loc6_++;
            }
            if(thane.talentData.talentPoint > 0 || thane.talentData.advTalentPoint > 0)
            {
               _loc6_++;
            }
            if(hasCanStudyRune)
            {
               _loc6_++;
            }
            model.valueObj[16] = _canStudyRuneCount;
            model.valueObj[14] = _loc6_;
         }
         if(param1 == 0 || param1 == 20)
         {
            _loc6_ = 0;
            _loc9_ = TempleteManager.instance.worldBossTemplateDict;
            for each(var _loc12_:CampaignTemplate in _loc9_)
            {
               if(_loc12_.Types == 1)
               {
                  if(_loc12_.state == 0)
                  {
                     _loc6_++;
                  }
               }
            }
            model.valueObj[20] = _loc6_;
         }
         if(param1 == 0 || param1 == 21)
         {
            _loc6_ = 0;
            _loc2_ = FeedBackManager.instance.list;
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               _loc4_ = _loc2_[_loc7_];
               if(FeedBackManager.instance.data.userPoint >= _loc4_.point && !_loc4_.state)
               {
                  _loc6_++;
               }
               _loc7_++;
            }
            model.valueObj[21] = _loc6_;
         }
         if(param1 == 0 || param1 == 23)
         {
            _loc6_ = 0;
            _loc2_ = FunnyManager.instance.model.currentTiroList;
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               _loc10_ = 0;
               while(_loc10_ < FunnyData(_loc2_[_loc7_]).bagList.length)
               {
                  if(FunnyBagData(FunnyData(_loc2_[_loc7_]).bagList[_loc10_]).status == 1)
                  {
                     _loc6_++;
                  }
                  _loc10_++;
               }
               _loc7_++;
            }
            model.valueObj[23] = _loc6_;
         }
         if(param1 == 0 || param1 == 28)
         {
            _loc6_ = 0;
            _loc6_ = RegistWelfareManager.instance.generalRewardNum;
            model.valueObj[28] = _loc6_;
         }
         if(param1 == 0 || param1 == 31)
         {
            _loc6_ = 0;
            _loc6_ = CultureActiveManager.instance.getCultureActiveCount();
            model.valueObj[31] = _loc6_;
         }
         try
         {
            if(param1 == 0 || param1 == 22)
            {
               _loc11_ = FundVeinManager.instance.info.rewardAmount;
               model.valueObj[22] = _loc11_;
            }
         }
         catch(e:Error)
         {
         }
         noticeView();
      }
      
      private function getBtnEnable(param1:GetItemInfo) : Boolean
      {
         var _loc2_:int = ArmyManager.instance.thane.grades;
         return _loc2_ >= param1.interval;
      }
      
      public function getIsGet(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:GLogInfo = null;
         var _loc2_:Array = FundManager.instance.newbieModel.getLogArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(param1 == _loc3_.type)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      private function setisGet(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc6_:GetItemInfo = null;
         var _loc8_:Array = null;
         var _loc3_:int = 0;
         var _loc7_:GLogInfo = null;
         var _loc5_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = param1[_loc4_] as GetItemInfo;
            _loc8_ = FundManager.instance.newbieModel.getLogArr;
            _loc3_ = int(_loc8_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc7_ = _loc8_[_loc5_] as GLogInfo;
               if(_loc7_.type == _loc6_.times)
               {
                  _loc6_._isGet = 1;
               }
               _loc5_++;
            }
            _loc2_.push(_loc6_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function get hasCanStudyRune() : Boolean
      {
         var _loc3_:int = 0;
         var _loc7_:RuneInfo = null;
         var _loc4_:* = null;
         var _loc1_:Array = null;
         _canStudyRuneCount = 0;
         var _loc6_:Array = thane.runeCate.allRuneList.getList();
         var _loc2_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         for(var _loc5_:String in _loc6_)
         {
            _loc3_ = int(_loc5_);
            _loc7_ = _loc6_[_loc3_];
            if(_loc7_)
            {
               if(_loc7_.nextTemplateInfo != null)
               {
                  if(_loc7_.nextTemplateInfo.Level < 1)
                  {
                     _loc1_ = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(302);
                     for each(_loc4_ in _loc1_)
                     {
                        if(_loc4_.Property1 == _loc7_.templateInfo.RuneType)
                        {
                           if(GoodsManager.instance.getGoodsNumByTempId(_loc4_.TemplateId) > 0)
                           {
                              _canStudyRuneCount = _canStudyRuneCount + 1;
                           }
                        }
                     }
                  }
               }
            }
         }
         return _canStudyRuneCount > 0;
      }
      
      private function canStudy(param1:RuneInfo) : Boolean
      {
         var _loc4_:GoodsInfo = null;
         var _loc5_:GoodsInfo = null;
         var _loc3_:int = 0;
         var _loc2_:Array = GoodsManager.instance.getGeneralBagGoodsBySonType(302);
         _loc2_.sortOn("pos",16);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_] as GoodsInfo;
            if(_loc4_.templateInfo.Property1 == param1.templateInfo.RuneType)
            {
               if(_loc4_.isBinds)
               {
                  _loc5_ = _loc4_;
                  return true;
               }
               if(!_loc5_)
               {
                  _loc5_ = _loc4_;
               }
            }
            _loc3_++;
         }
         if(_loc5_)
         {
            return true;
         }
         return false;
      }
      
      public function updateValue(param1:int, param2:int) : void
      {
         model.valueObj[param1] = param2;
         noticeView();
      }
      
      public function getValueByKey(param1:int) : int
      {
         return int(model.valueObj[param1]);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function noticeView() : void
      {
         NotificationManager.instance.dispatchEvent(new Event("INFO_TIPS_DATA_UPDATE"));
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

