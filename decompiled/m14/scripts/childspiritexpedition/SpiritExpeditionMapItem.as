package childspiritexpedition
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SpiritExpeditionManager;
   import mvc.module.childspiritexpedition.SpiritExpeditionChapterInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.tips.MessageTipManager;
   
   public class SpiritExpeditionMapItem extends Component
   {
      
      private var _hitContiner:Component;
      
      private var _mapMc:MovieClip;
      
      private var _starItem:TokenAmountItem;
      
      private var _lockImage:Bitmap;
      
      public var mapId:int;
      
      private var _data:SpiritExpeditionChapterInfo;
      
      private var starPosAry:Array = [[150,148],[270,240],[155,160],[180,245],[365,260],[335,248]];
      
      public function SpiritExpeditionMapItem(param1:int)
      {
         super();
         mapId = param1;
         initView();
         initMapMc();
         addEvent();
      }
      
      private function initView() : void
      {
         _hitContiner = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionMapItem.hitContiner");
         _mapMc = ComponentFactory.Instance.creatCustomObject("SpiritExpeditionMapItem.mapMc" + mapId);
         _starItem = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionMapItem.starItem");
         _lockImage = ComponentFactory.Instance.creatBitmap("asset.SpiritExpeditionMapItem.lockImage");
         addChild(_hitContiner);
         addChild(_starItem);
         addChild(_lockImage);
         _hitContiner.addChild(_mapMc);
         _mapMc["light"].visible = false;
         _starItem.x = _lockImage.x = starPosAry[mapId - 1][0];
         _starItem.y = _lockImage.y = starPosAry[mapId - 1][1];
         _starItem.visible = false;
         _lockImage.visible = false;
      }
      
      private function initMapMc() : void
      {
      }
      
      private function addEvent() : void
      {
         _hitContiner.addEventListener("rollOver",__mouseOverHandler);
         _hitContiner.addEventListener("rollOut",__mouseOutHandler);
         _hitContiner.addEventListener("click",__mapNodeClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_hitContiner)
         {
            _hitContiner.removeEventListener("rollOver",__mouseOverHandler);
            _hitContiner.removeEventListener("rollOut",__mouseOutHandler);
            _hitContiner.removeEventListener("click",__mapNodeClickHandler);
         }
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         _mapMc["light"].visible = true;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         _mapMc["light"].visible = false;
      }
      
      private function __mapNodeClickHandler(param1:MouseEvent) : void
      {
         if(!data || mapId > model.openMaxAreaId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("spiritExpedition.mapItem.noOpenAlert"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("spiritexpedition",2,mapId);
      }
      
      public function get data() : SpiritExpeditionChapterInfo
      {
         return _data;
      }
      
      public function set data(param1:SpiritExpeditionChapterInfo) : void
      {
         _data = param1;
         if(!data || mapId > model.openMaxAreaId)
         {
            this.filters = [UIFilter.getGrayFilter()];
            _lockImage.visible = true;
            _starItem.visible = false;
         }
         else
         {
            this.filters = [];
            _lockImage.visible = false;
            _starItem.visible = true;
            _starItem.firstText = model.getPassTotalStarByArea(data.areaId) + "";
         }
      }
      
      private function get model() : SpiritExpeditionModel
      {
         return SpiritExpeditionManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_mapMc);
         _mapMc = null;
         ObjectUtils.disposeObject(_starItem);
         _starItem = null;
         ObjectUtils.disposeObject(_hitContiner);
         _hitContiner = null;
         ObjectUtils.disposeObject(_lockImage);
         _lockImage = null;
         super.dispose();
      }
   }
}

