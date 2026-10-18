package remotepet
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RemotePetManager;
   import remotepet.views.RemotePetFormationView;
   import remotepet.views.RemotePetInfoView;
   import remotepet.views.RemotePetListView;
   import remotepet.views.RemoteSkillView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class RemotePetReadyFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _line01:Bitmap;
      
      private var _line02:Bitmap;
      
      private var _formationView:RemotePetFormationView;
      
      private var _skillView:RemoteSkillView;
      
      private var _petListView:RemotePetListView;
      
      private var _infoView:RemotePetInfoView;
      
      private var _helpBtn:BaseButton;
      
      public function RemotePetReadyFrame()
      {
         if(RemotePetManager.instance.model.fristRst)
         {
            RemotePetManager.instance.model.fristRst = false;
            RemotePetManager.sendRemotePetInfo();
         }
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("remotepet.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("remotepet.bg");
         _line01 = ComponentFactory.Instance.creatBitmap("asset.remote.line01");
         _line02 = ComponentFactory.Instance.creatBitmap("asset.remote.line02");
         _formationView = ComponentFactory.Instance.creatCustomObject("remotepet.formationView");
         _skillView = ComponentFactory.Instance.creatCustomObject("remotepet.skillView");
         _petListView = ComponentFactory.Instance.creatCustomObject("remotepet.petListView");
         _infoView = ComponentFactory.Instance.creatCustomObject("remotepet.infoView");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("remotepet.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         addToContent(_bg);
         addToContent(_line01);
         addToContent(_formationView);
         addToContent(_skillView);
         addToContent(_petListView);
         addToContent(_infoView);
         addToContent(_line02);
         addToContent(_helpBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _helpBtn.addEventListener("click",__helpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _helpBtn.removeEventListener("click",__helpHandler);
      }
      
      private function __helpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("remotepet.helpFrame");
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_line01);
         _line01 = null;
         ObjectUtils.disposeObject(_line02);
         _line02 = null;
         ObjectUtils.disposeObject(_formationView);
         _formationView = null;
         ObjectUtils.disposeObject(_skillView);
         _skillView = null;
         ObjectUtils.disposeObject(_petListView);
         _petListView = null;
         ObjectUtils.disposeObject(_infoView);
         _infoView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         RemotePetManager.instance.saveRemotePetInfo();
      }
   }
}

