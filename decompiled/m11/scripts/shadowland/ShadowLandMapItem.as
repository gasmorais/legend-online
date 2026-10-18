package shadowland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.shadowland.ShadowLandChapterInfo;
   import mvc.module.shadowland.ShadowLandModel;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.ShadowLandManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ShadowLandMapItem extends Component
   {
      
      private var _mapMc:MovieClip;
      
      private var _lockImage:Bitmap;
      
      public var _mapId:int;
      
      private var _data:ShadowLandChapterInfo;
      
      private var starPosAry:Array = [[198,215],[265,195],[180,250],[185,165],[208,320]];
      
      public function ShadowLandMapItem(param1:int)
      {
         super();
         _mapId = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _mapMc = ComponentFactory.Instance.creatCustomObject("ShadowLandMapItem.mapMc" + _mapId);
         _lockImage = ComponentFactory.Instance.creatBitmap("asset.ShadowLandMapItem.lockImage");
         addChild(_mapMc);
         addChild(_lockImage);
         _mapMc["light"].visible = false;
         _lockImage.x = starPosAry[_mapId - 1][0];
         _lockImage.y = starPosAry[_mapId - 1][1];
         _lockImage.visible = false;
      }
      
      private function addEvent() : void
      {
         _mapMc.addEventListener("rollOver",__mouseOverHandler);
         _mapMc.addEventListener("rollOut",__mouseOutHandler);
         _mapMc.addEventListener("click",__mapNodeClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_mapMc)
         {
            _mapMc.removeEventListener("rollOver",__mouseOverHandler);
            _mapMc.removeEventListener("rollOut",__mouseOutHandler);
            _mapMc.removeEventListener("click",__mapNodeClickHandler);
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
         if(!data || _mapId > model.openMaxAreaId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ShadowLandMapItem.noOpenAlert"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("shadowland",2,[_mapId]);
      }
      
      public function get data() : ShadowLandChapterInfo
      {
         return _data;
      }
      
      public function set data(param1:ShadowLandChapterInfo) : void
      {
         _data = param1;
         if(!data || _mapId > model.openMaxAreaId)
         {
            this.filters = [UIFilter.getGrayFilter()];
            _lockImage.visible = true;
         }
         else
         {
            this.filters = [];
            _lockImage.visible = false;
         }
      }
      
      private function get model() : ShadowLandModel
      {
         return ShadowLandManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_mapMc);
         _mapMc = null;
         ObjectUtils.disposeObject(_lockImage);
         _lockImage = null;
         super.dispose();
      }
   }
}

