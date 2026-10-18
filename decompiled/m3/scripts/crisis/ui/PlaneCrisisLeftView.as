package crisis.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import crisis.ui.item.PlaneCrisisPlayerInfoItem;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import mvc.module.crisis.PlaneCrisisModel;
   import mvc.module.crisis.PlaneCrisisPlayerInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlayerManager;
   
   public class PlaneCrisisLeftView extends Sprite
   {
      
      public static const EVENT_REFRESH_TOP:String = "PlaneCrisisLeftView.EVENT_REFRESH_TOP";
      
      private const MAX_LEN:int = 3;
      
      private var _back:MutipleImage;
      
      private var _box:VBox;
      
      private var _itemList:Array;
      
      private var _selfColor:Bitmap;
      
      private var _selfErgmentTxt:FilterFrameText;
      
      public function PlaneCrisisLeftView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:PlaneCrisisPlayerInfoItem = null;
         var _loc2_:int = 0;
         _back = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.LeftBack");
         _box = ComponentFactory.Instance.creatCustomObject("planecrisis.playerInfoBox");
         _selfErgmentTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.left.selfelargmentTxt");
         _selfColor = new Bitmap();
         _selfColor.x = 16;
         _selfColor.y = 1;
         addChild(_back);
         addChild(_box);
         addChild(_selfErgmentTxt);
         addChild(_selfColor);
         _itemList = [];
         _box.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new PlaneCrisisPlayerInfoItem();
            _box.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _box.commitChanges();
         updateViewHandler();
         this.y = 260;
         LayerManager.Instance.addToLayer(this,4);
      }
      
      private function get model() : PlaneCrisisModel
      {
         return PlaneCrisisManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         model.addEventListener("PlaneCrisisEventType.updatePlayerInfo",updateViewHandler);
         model.addEventListener("PlaneCrisisEventType.addArmy",updateViewHandler);
         model.addEventListener("PlaneCrisisEventType.removeArmy",updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("PlaneCrisisEventType.updatePlayerInfo",updateViewHandler);
         model.removeEventListener("PlaneCrisisEventType.addArmy",updateViewHandler);
         model.removeEventListener("PlaneCrisisEventType.removeArmy",updateViewHandler);
      }
      
      private function updateViewHandler(param1:Event = null) : void
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:Dictionary = model.planeCrisisInfoDic;
         var _loc6_:Array = [];
         var _loc5_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         for each(var _loc10_:PlaneCrisisPlayerInfo in _loc9_)
         {
            if(!_loc10_.isOffline)
            {
               _loc7_ += _loc10_.fragment;
            }
            if(_loc10_.armyData.userId != _loc5_)
            {
               _loc6_.push(_loc10_);
            }
            else
            {
               _loc2_ = int(_loc10_.actionNum);
               _selfErgmentTxt.text = "" + _loc10_.fragment;
               if(_selfColor.bitmapData == null)
               {
                  _selfColor.bitmapData = ComponentFactory.Instance.creatBitmap("asset.planecrisis.RColor" + _loc10_.color).bitmapData;
               }
            }
         }
         _loc6_.sortOn(["color"],[16]);
         var _loc11_:int = int(_loc6_.length);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            if(_loc4_ <= _loc11_ - 1)
            {
               _itemList[_loc4_].data = _loc6_[_loc4_];
            }
            else
            {
               _itemList[_loc4_].data = null;
            }
            _loc4_++;
         }
         var _loc3_:int = int(model.attackEndBossNeedNum);
         var _loc8_:int = model.difficulty == 1 ? 2200 : 3315;
         NotificationManager.instance.sendNotification("PlaneCrisisLeftView.EVENT_REFRESH_TOP",[_loc2_,_loc7_,_loc3_,_loc8_]);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeObject(_selfErgmentTxt);
         _selfErgmentTxt = null;
         ObjectUtils.disposeObject(_selfColor);
         _selfColor = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _itemList = null;
      }
   }
}

