package armyII.viewII.allocate
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.armyII.UserArmy;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class RecruitPawnFrame extends Frame
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _pawnTileList:RecruitPawnTileList;
      
      private var _info:UserArmy;
      
      public function RecruitPawnFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function initView() : void
      {
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("armyII.viewII.allocate.RecruitPawnFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("army.RecruitListBackground");
         addToContent(_bg);
         _pawnTileList = ComponentFactory.Instance.creatCustomObject("army.PawnTitleList");
         addToContent(_pawnTileList);
      }
      
      private function initEvents() : void
      {
         addEventListener("response",_respose);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",_respose);
      }
      
      private function _respose(param1:FrameEvent) : void
      {
         FrameControllerManager.instance.armyController.autoAllocate();
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
         _pawnTileList = null;
         _bg = null;
         _info = null;
      }
   }
}

