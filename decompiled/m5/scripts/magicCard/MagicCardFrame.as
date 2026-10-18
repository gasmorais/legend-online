package magicCard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import magicCard.view.MagicCardSlotView;
   import magicCard.view.MagicCardSuitView;
   import manager.LanguageMgr;
   
   public class MagicCardFrame extends Frame implements IManualSize
   {
      
      private var _magicCardSuitView:MagicCardSuitView;
      
      private var _magicCardSlotView:MagicCardSlotView;
      
      public function MagicCardFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,790,620);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("card.CardFrame.title");
         _magicCardSlotView = ComponentFactory.Instance.creatCustomObject("magicCard.view.MagicCardSlotView");
         _magicCardSuitView = ComponentFactory.Instance.creatCustomObject("magicCard.view.MagicCardSuitView");
         addToContent(_magicCardSlotView);
         addToContent(_magicCardSuitView);
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
      
      public function get magicCardSlotView() : MagicCardSlotView
      {
         return _magicCardSlotView;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_magicCardSuitView);
         _magicCardSuitView = null;
         ObjectUtils.disposeObject(_magicCardSlotView);
         _magicCardSlotView = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

