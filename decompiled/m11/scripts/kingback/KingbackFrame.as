package kingback
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import kingback.view.KingbackDataView;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   
   public class KingbackFrame extends Frame implements IManualSize
   {
      
      public var _dataView:KingbackDataView;
      
      private var _dBg:Scale9CornerImage;
      
      public function KingbackFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,778,540);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("kingback.frame.title");
         _dBg = ComponentFactory.Instance.creatComponentByStylename("kingbck.Frame.back");
         _dataView = ComponentFactory.Instance.creatCustomObject("ui.kingback.dataView");
         addToContent(_dBg);
         addToContent(_dataView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
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
         ObjectUtils.disposeObject(_dBg);
         _dBg = null;
         ObjectUtils.disposeObject(_dataView);
         _dataView = null;
         super.dispose();
      }
      
      public function show(param1:Object = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

