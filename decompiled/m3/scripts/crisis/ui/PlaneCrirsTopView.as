package crisis.ui
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ObjectUtils;
   import crisis.ui.item.PlaneCrisisEventItem;
   import crisis.ui.item.PlaneCrisisTopInfoItem;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.crisis.PlaneCrisisCountInfo;
   import mvc.module.crisis.PlaneCrisisModel;
   import yishi.manager.PlaneCrisisManager;
   
   public class PlaneCrirsTopView extends Sprite
   {
      
      private var _back:Bitmap;
      
      private var _hbox:HBox;
      
      private var _itemDic:Dictionary;
      
      private var _leftInfoView:PlaneCrisisTopInfoItem;
      
      public function PlaneCrirsTopView()
      {
         super();
         initView();
         initEvent();
         resizeHandler();
      }
      
      private function initView() : void
      {
         var _loc1_:PlaneCrisisEventItem = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _back = ComponentFactory.Instance.creatBitmap("asset.planecrisis.topBack");
         _hbox = ComponentFactory.Instance.creatCustomObject("planecrisis.TopBox");
         addChild(_back);
         addChild(_hbox);
         _itemDic = new Dictionary();
         var _loc2_:Array = [1,3,4,5,6,7,8];
         _hbox.beginChanges();
         var _loc3_:int = int(_loc2_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc1_ = new PlaneCrisisEventItem();
            _loc5_ = int(_loc2_[_loc6_]);
            _loc1_.eventType = _loc5_;
            _itemDic[_loc5_] = _loc1_;
            _hbox.addChild(_loc1_);
            _loc6_++;
         }
         _hbox.commitChanges();
         _leftInfoView = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.topLeftInfoItem");
         addChild(_leftInfoView);
         var _loc4_:int = int(model.attackEndBossNeedNum);
         _leftInfoView.tipData = LanguageMgr.GetTranslation("planeCrisis.bossTaget","#ff0000",_loc4_);
         updateViewHandler();
         LayerManager.Instance.addToLayer(this,4);
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         model.addEventListener("PlaneCrisisEventType.updateEventCount",updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         model.removeEventListener("PlaneCrisisEventType.updateEventCount",updateViewHandler);
      }
      
      private function updateViewHandler(param1:Event = null) : void
      {
         var _loc2_:PlaneCrisisEventItem = null;
         var _loc3_:Dictionary = model.eventProgessDic;
         for each(var _loc4_:PlaneCrisisCountInfo in _loc3_)
         {
            if(_loc4_ != null)
            {
               _loc2_ = _itemDic[_loc4_.eventType];
               if(_loc2_ != null)
               {
                  _loc2_.data = _loc4_;
               }
            }
         }
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         this.x = (StageReferance.stage.stageWidth - this.width) * 0.5;
      }
      
      private function get model() : PlaneCrisisModel
      {
         return PlaneCrisisManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_leftInfoView);
         _leftInfoView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _itemDic = null;
      }
   }
}

