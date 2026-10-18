package spacetime
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import spacetime.view.SpaceTimeFloorItem;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class SpaceTimeFaultRewardFrame extends Frame
   {
      
      private var _seflBack:MutipleImage;
      
      private var _getRewardBtn:IconButton;
      
      private var _rewardBox:HBox;
      
      private var _rewardList:Vector.<BaseItemView> = new Vector.<BaseItemView>();
      
      private var _listBox:VBox;
      
      private var _list:Vector.<SpaceTimeFloorItem> = new Vector.<SpaceTimeFloorItem>();
      
      private var _passFloorTxt:GradientText;
      
      private var _tipTxt:FilterFrameText;
      
      private var _shareTxt:FilterFrameText;
      
      private var _hasGet:DisplayObject;
      
      private var _playInfo:PlayerInfo;
      
      private var _passHistory:String;
      
      public function SpaceTimeFaultRewardFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _playInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         _seflBack = ComponentFactory.Instance.creatComponentByStylename("xmlui.spacetimefault.fla.seflBack");
         _getRewardBtn = ComponentFactory.Instance.creatComponentByStylename("xmlui.spacetimefault.fla.getRewardBtn");
         _listBox = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.itemVbox");
         _passFloorTxt = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.passfloorTxt");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.tipTxt");
         _shareTxt = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.shareTxt");
         _rewardBox = ComponentFactory.Instance.creatComponentByStylename("spacetimefalut.get.RewardHbox");
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.spacetimefault.getFla");
         _tipTxt.text = LanguageMgr.GetTranslation("spacetimefault.desTip");
         _shareTxt.htmlText = LanguageMgr.GetTranslation("spacetimefault.share");
         addChild(_seflBack);
         addChild(_rewardBox);
         addChild(_passFloorTxt);
         addChild(_tipTxt);
         addChild(_shareTxt);
         addChild(_listBox);
         refreshState();
         initRewards();
      }
      
      private function refreshState() : void
      {
         var _loc1_:Array = null;
         if(_playInfo.hasSpaceTimeReward)
         {
            if(_getRewardBtn.parent)
            {
               _getRewardBtn.parent.removeChild(_getRewardBtn);
            }
            addChild(_hasGet);
         }
         else
         {
            if(_hasGet.parent)
            {
               _hasGet.parent.removeChild(_hasGet);
            }
            addChild(_getRewardBtn);
            if(_playInfo.spacetimePassHistory != "")
            {
               _loc1_ = _playInfo.spacetimePassHistory.split("|");
               if(_loc1_[1] != null && _loc1_[1] != "")
               {
                  _getRewardBtn.enable = true;
               }
               else
               {
                  _getRewardBtn.enable = false;
               }
            }
            else
            {
               _getRewardBtn.enable = false;
            }
         }
      }
      
      private function initRewards() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc1_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         _rewardBox.beginChanges();
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("SpaceTimeFaultRewards");
         var _loc4_:Array = [];
         if(_loc3_)
         {
            _loc4_ = _loc3_.ConfigValue.split("|");
         }
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _rewardList[_loc5_] = _loc2_;
            _loc6_ = int(_loc4_[_loc5_]);
            if(_loc6_ != 0)
            {
               _loc1_ = new GoodsInfo();
               _loc1_.templateId = _loc6_;
               _loc1_.count = 0;
               _loc2_.data = _loc1_;
            }
            else
            {
               _loc2_.data = null;
            }
            _rewardBox.addChild(_loc2_);
            _loc5_++;
         }
         _rewardBox.commitChanges();
      }
      
      private function refreshRewards(param1:String) : void
      {
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:GoodsInfo = null;
         var _loc9_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(param1 != "" && param1 != null)
         {
            _loc4_ = param1.split(",");
            _loc2_ = int(_loc4_.length);
            _loc5_ = 0;
            while(_loc5_ < 3)
            {
               _loc9_ = false;
               _loc8_ = _rewardList[_loc5_].data;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc6_ = _loc4_[_loc3_];
                  _loc7_ = _loc6_.split(":");
                  if(_loc8_ != null && int(_loc7_[0]) == _loc8_.templateId)
                  {
                     _loc8_.count = int(_loc7_[1]);
                     _loc9_ = true;
                     break;
                  }
                  _loc3_++;
               }
               if(!_loc9_)
               {
                  if(_loc8_)
                  {
                     _loc8_.count = 0;
                  }
               }
               _rewardList[_loc5_].data = _loc8_;
               _loc5_++;
            }
         }
      }
      
      private function getRearyDiff(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1 - 9998)
         {
            case 0:
               _loc2_ = 1;
               break;
            case 1:
               _loc2_ = 2;
         }
         return _loc2_;
      }
      
      private function refreshSelfHistory() : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc2_:Array = null;
         var _loc1_:int = 0;
         var _loc3_:String = null;
         if(_passHistory == _playInfo.spacetimePassHistory)
         {
            return;
         }
         _passHistory = _playInfo.spacetimePassHistory;
         if(_passHistory != "")
         {
            _loc4_ = _passHistory.split("|");
            _loc5_ = getRearyDiff(int(_loc4_[0]));
            _loc6_ = _loc4_[1];
            _loc7_ = _loc4_[2];
            _loc2_ = [];
            _loc1_ = 0;
            if(_loc7_ != null && _loc7_ != "")
            {
               _loc2_ = _loc7_.split(",");
               _loc1_ = int(_loc2_.length);
               _loc3_ = getDiffName(_loc5_);
               _passFloorTxt.text = LanguageMgr.GetTranslation("spacetimefault.passFloor",_loc3_,_loc1_);
               initFloorView(_loc5_);
               refreshRewards(_loc6_);
               refreshFloorView(_loc2_);
            }
         }
      }
      
      private function getDiffName(param1:int) : String
      {
         var _loc2_:String = "";
         if(param1 == 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("kingtower.difficulty.common");
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("kingtower.difficulty.nightmare");
         }
         return _loc2_;
      }
      
      private function initFloorView(param1:int) : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc5_:Array = null;
         var _loc7_:Array = null;
         var _loc6_:int = 0;
         var _loc3_:SpaceTimeFloorItem = null;
         var _loc8_:int = 0;
         if(param1 == 1)
         {
            _loc4_ = TempleteManager.instance.getSpaceTimeBoxConfigValue(1);
            _loc2_ = TempleteManager.instance.getSpaceTimeBoxCountConfigValue(1);
         }
         else if(param1 == 2)
         {
            _loc4_ = TempleteManager.instance.getSpaceTimeBoxConfigValue(2);
            _loc2_ = TempleteManager.instance.getSpaceTimeBoxCountConfigValue(2);
         }
         if(_loc4_ != null)
         {
            _loc5_ = _loc4_.split("|");
            _loc7_ = _loc2_.split("|");
            _loc6_ = int(_loc5_.length);
            _listBox.beginChanges();
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc3_ = new SpaceTimeFloorItem(_loc8_);
               _loc3_.setInitConfigBox(_loc5_[_loc8_],_loc7_[_loc8_]);
               _loc3_.refreshBoxData(99999);
               _list[_loc8_] = _loc3_;
               _listBox.addChild(_loc3_);
               _loc8_++;
            }
            _listBox.commitChanges();
         }
      }
      
      private function refreshFloorView(param1:Array) : void
      {
         var _loc2_:SpaceTimeFloorItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < 7)
         {
            _loc2_ = _list[_loc4_];
            if(_loc4_ < _loc3_)
            {
               _loc2_.refreshBoxData(int(param1[_loc4_]));
            }
            else
            {
               _loc2_.refreshBoxData(99999);
            }
            _loc4_++;
         }
      }
      
      public function show() : void
      {
         refreshSelfHistory();
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _getRewardBtn.addEventListener("click",clickgetRewardBtnHandler);
         _shareTxt.addEventListener("link",linkHandler);
         NotificationManager.instance.addEventListener("REFRESH_SPACE_TIME_RESTNUM",_refreshGetTimeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _getRewardBtn.removeEventListener("click",clickgetRewardBtnHandler);
         _shareTxt.removeEventListener("link",linkHandler);
         NotificationManager.instance.removeEventListener("REFRESH_SPACE_TIME_RESTNUM",_refreshGetTimeHandler);
      }
      
      private function _refreshGetTimeHandler(param1:Event) : void
      {
         refreshState();
      }
      
      private function linkHandler(param1:TextEvent) : void
      {
         if(_passHistory == null)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("spacetimefault.shareMsg",_passHistory);
         NotificationManager.instance.sendNotification("SEND_SPACETIME_SHARE",_loc2_);
      }
      
      private function clickgetRewardBtnHandler(param1:MouseEvent) : void
      {
         RoomManager.instance.requestSpacetimeInfo(2);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_seflBack);
         _seflBack = null;
         ObjectUtils.disposeObject(_getRewardBtn);
         _getRewardBtn = null;
         ObjectUtils.disposeObject(_passFloorTxt);
         _passFloorTxt = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         ObjectUtils.disposeObject(_shareTxt);
         _shareTxt = null;
         for each(var _loc1_:SpaceTimeFloorItem in _list)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _list = null;
         for each(var _loc2_:BaseItemView in _rewardList)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _rewardList = null;
         ObjectUtils.disposeObject(_listBox);
         _listBox = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         _playInfo = null;
         super.dispose();
      }
   }
}

