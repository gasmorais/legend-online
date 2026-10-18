package poseidon
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import poseidon.view.PoseidonView;
   import yishi.datas.ComponentGroupType;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class PoseidonFrame extends Frame implements IManualSize
   {
      
      private var _view:PoseidonView;
      
      private var _helpbtn:BaseButton;
      
      public function PoseidonFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,760,528);
      }
      
      private function initView() : void
      {
         _view = ComponentFactory.Instance.creatCustomObject("ui.poseidonshop.view");
         _helpbtn = ComponentFactory.Instance.creatComponentByStylename("poseidonshop.HelpBtn");
         addToContent(_view);
         addToContent(_helpbtn);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpbtn.addEventListener("click",_clickHelpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpbtn.removeEventListener("click",_clickHelpHandler);
      }
      
      private function _clickHelpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("poseidon.poseidonHelpFrame");
         _loc2_.show();
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
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_helpbtn);
         _helpbtn = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("poseidon.shop.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

