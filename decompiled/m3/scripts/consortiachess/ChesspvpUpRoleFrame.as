package consortiachess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.ui.ChesspvpRoleUpUI;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   
   public class ChesspvpUpRoleFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var roleUpUI:ChesspvpRoleUpUI;
      
      public function ChesspvpUpRoleFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.roleUp.FrameBack1");
         roleUpUI = new ChesspvpRoleUpUI();
         roleUpUI.callFun = dispose;
         addToContent(_bg);
         addToContent(roleUpUI);
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
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(roleUpUI);
         roleUpUI = null;
         super.dispose();
      }
      
      public function show() : void
      {
         _closeButton.visible = false;
         titleText = LanguageMgr.GetTranslation("chesspvp.roleUp.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

