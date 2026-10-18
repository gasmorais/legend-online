package consortia.view.myConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaTreasureFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _treasureView:ConsortiaTreasurePage;
      
      private var _isShow:Boolean = false;
      
      private var _openFromConsortiaFrame:int;
      
      public function ConsortiaTreasureFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,740,520);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTreasureFrame.border");
         _treasureView = ComponentFactory.Instance.creatCustomObject("ConsortiaTreasureFrame.treasureView");
         addToContent(_border);
         addToContent(_treasureView);
      }
      
      private function addEvent() : void
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
               _isShow = true;
               dispose();
         }
      }
      
      public function show(param1:int) : void
      {
         _openFromConsortiaFrame = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ConsortiaTreasureFrame.title.text");
         ConsortiaManager.instance.isOpenTreasreFrame = true;
      }
      
      public function get treasurePage() : ConsortiaTreasurePage
      {
         return _treasureView;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_treasureView);
         _treasureView = null;
         super.dispose();
         ConsortiaManager.instance.isOpenTreasreFrame = false;
         FrameControllerManager.instance.consortiaController.closeSkillFrame(_openFromConsortiaFrame,_isShow);
      }
   }
}

