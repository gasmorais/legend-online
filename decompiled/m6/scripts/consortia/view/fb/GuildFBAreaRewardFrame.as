package consortia.view.fb
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.guildfb.GuildFBAreaNode;
   import yishi.datas.ComponentGroupType;
   
   public class GuildFBAreaRewardFrame extends Frame
   {
      
      private var _ui:GuildFbAreaUIView;
      
      public function GuildFBAreaRewardFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show(param1:GuildFBAreaNode) : void
      {
         _ui.data = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("guildfb.areaRewardFrame.Title");
         _ui = new GuildFbAreaUIView();
         addToContent(_ui);
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
         ObjectUtils.disposeObject(_ui);
         _ui = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

