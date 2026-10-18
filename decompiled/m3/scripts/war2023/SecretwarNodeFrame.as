package war2023
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.war2023.info.SecretWarNodeInfo;
   import war2023.view.SecretwarNodeView;
   import yishi.datas.ComponentGroupType;
   
   public class SecretwarNodeFrame extends Frame implements IManualSize
   {
      
      private var _view:SecretwarNodeView;
      
      public function SecretwarNodeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _view = new SecretwarNodeView();
         addToContent(_view);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function secretwarCloseNodeFrame(param1:Event) : void
      {
         dispose();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,473,475);
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
         super.dispose();
      }
      
      public function show(param1:SecretWarNodeInfo) : void
      {
         if(param1.type == 3 || param1.type == 4)
         {
            titleText = LanguageMgr.GetTranslation("secretwar.nodeBirth.title");
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("secretwar.nodeFrame.title");
         }
         _view.data = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

