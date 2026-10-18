package theseus
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import theseus.war.view.TheseusWarFuHuaView;
   import yishi.datas.ComponentGroupType;
   
   public class TheseuswarFuhuCFrame extends Frame implements IManualSize
   {
      
      private var _view:TheseusWarFuHuaView;
      
      public function TheseuswarFuhuCFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,420,390);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("theseus.war.fuhuaTitle");
         _view = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.war.TheseusWarFuHuaView");
         addToContent(_view);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _view.fuhuBtn2.addEventListener("click",fuhuBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _view.fuhuBtn2.removeEventListener("click",fuhuBtnClickHandler);
      }
      
      private function fuhuBtnClickHandler(param1:MouseEvent) : void
      {
         TheseussoulManager.Instance.doWarsoulParam(7,_view.idx);
         dispose();
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
      
      public function show(param1:int) : void
      {
         _view.idx = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

