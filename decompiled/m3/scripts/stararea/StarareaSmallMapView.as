package stararea
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.StarareaModel;
   import mvc.module.stararea.event.StarareaEvent;
   
   public class StarareaSmallMapView extends Component
   {
      
      private var _bit0:Bitmap;
      
      private var _txtMapTitle:FilterFrameText;
      
      private var _spMap:Sprite;
      
      public function StarareaSmallMapView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         StarareaManager.instance.addEventListener("UPDATE_NODES",updateNodes);
         StarareaManager.instance.addEventListener("UPDATE_ROADS",updateNodes);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         StarareaManager.instance.removeEventListener("UPDATE_NODES",updateNodes);
         StarareaManager.instance.removeEventListener("UPDATE_ROADS",updateNodes);
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.stararea.bg5");
         _txtMapTitle = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtMapTitle");
         addChild(_bit0);
         addChild(_txtMapTitle);
         _txtMapTitle.text = LanguageMgr.GetTranslation("stararea.str4");
         _spMap = ComponentFactory.Instance.creatCustomObject("asset.stararea.mc.smallmap");
         addChild(_spMap);
         _spMap.x = 51;
         _spMap.y = 37;
         LayerManager.Instance.addToLayer(this,4);
         resizeHandler();
         updateNodes();
      }
      
      private function updateNodes(param1:StarareaEvent = null) : void
      {
         var _loc4_:MovieClip = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < model.nodes.length)
         {
            _loc3_ = int(model.nodes[_loc2_]);
            _loc4_ = _spMap.getChildByName("star" + (int(_loc2_ + 1))) as MovieClip;
            if(_loc3_ == -1)
            {
               _loc4_.visible = true;
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc2_++;
         }
         _loc4_ = _spMap.getChildByName("star" + model.myPointId) as MovieClip;
         _spMap.getChildByName("me").x = _loc4_.x;
         _spMap.getChildByName("me").y = _loc4_.y;
      }
      
      private function get model() : StarareaModel
      {
         return StarareaManager.instance.model;
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         this.x = StageReferance.stage.stageWidth - 215;
         this.y = 0;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_txtMapTitle);
         _txtMapTitle = null;
         ObjectUtils.disposeObject(_spMap);
         _spMap = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

