package outyard.shuttle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.templates.OutyardShuttleRewardTemplateInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.OutyardManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardProgressChest extends Component
   {
      
      private var _chestBtn:ScaleFrameImage;
      
      private var _data:OutyardShuttleRewardTemplateInfo;
      
      private var _shuttleMsg:ShuttleInfoMsg;
      
      private var _numberAsset:BitmapData;
      
      private var _container1:Component;
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      public function OutyardProgressChest()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _chestBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.progress.chestBmp");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.outyard.shuttle.assetScoreBmp");
         _container1 = new Component();
         _container1.x = 14;
         _container1.y = -20;
         addChild(_container1);
         addChild(_chestBtn);
      }
      
      private function addEvent() : void
      {
         _chestBtn.addEventListener("rollOver",__overHandler);
         _chestBtn.addEventListener("rollOut",__outHandler);
         _chestBtn.addEventListener("click",__chestHandler);
      }
      
      private function removeEvent() : void
      {
         _chestBtn.removeEventListener("rollOver",__overHandler);
         _chestBtn.removeEventListener("rollOut",__outHandler);
         _chestBtn.removeEventListener("click",__chestHandler);
      }
      
      public function set data(param1:OutyardShuttleRewardTemplateInfo) : void
      {
         var _loc4_:int = 0;
         _data = param1;
         _shuttleMsg = OutyardManager.instance.shuttleModel.shuttleMsg;
         if(!_data.RewardState)
         {
            _chestBtn.setFrame(1);
         }
         else
         {
            _chestBtn.setFrame(2);
         }
         var _loc2_:Array = _data.RewardItem.split("|");
         var _loc3_:String = "2";
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ += "|1," + _loc2_[_loc4_].split(",")[0] + "," + _loc2_[_loc4_].split(",")[1];
            _loc4_++;
         }
         _chestBtn.tipData = _loc3_;
         NumberViewUtils.refreshValue(_data.ShuttleScore,_container1,_numberAsset,14,14,7,14,"0123456789");
      }
      
      public function get data() : OutyardShuttleRewardTemplateInfo
      {
         return _data;
      }
      
      private function __chestHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!scoreEnough)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardProgressChest.notScoreEnough"));
            return;
         }
         if(_data.RewardState)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardProgressChest.hasReceived"));
            return;
         }
         OutyardManager.instance.OperateShuttle(8,0,0,0,_data.Index);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         var _loc2_:ScaleFrameImage = param1.target as ScaleFrameImage;
         _filter.setGlowFilter(_loc2_);
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         var _loc2_:ScaleFrameImage = param1.target as ScaleFrameImage;
         _filter.setNormalFilter(_loc2_);
      }
      
      private function get scoreEnough() : Boolean
      {
         if(_shuttleMsg.shuttleScore >= _data.ShuttleScore)
         {
            return true;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_chestBtn);
         _chestBtn = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_container1);
         _container1 = null;
         _data = null;
         _shuttleMsg = null;
         _filter = null;
         super.dispose();
      }
   }
}

