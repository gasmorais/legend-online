package childarena
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildArenaModel;
   import mvc.module.children.ChildSender;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildArenaMainFrame extends Frame
   {
      
      private var titleImage:ScaleFrameImage;
      
      private var leftView:ChildArenaLeftView;
      
      private var rightView:ChildArenaRightView;
      
      public function ChildArenaMainFrame()
      {
         super();
         initView();
         addEvent();
         arenaModel.isInChildArena = true;
         ChildSender.requestChildArenaOp(1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleImage = ComponentFactory.Instance.creatComponentByStylename("ChildArenaMainFrame.titleImage");
         leftView = ComponentFactory.Instance.creatCustomObject("ChildArenaMainFrame.leftView");
         rightView = ComponentFactory.Instance.creatCustomObject("ChildArenaMainFrame.rightView");
         addToContent(titleImage);
         titleImage.setFrame(arenaModel.arenaType);
         addToContent(leftView);
         addToContent(rightView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("ChildEvent.CHILD_ARENA_UPDATE_MAIN",this,__updateChildArenaStateHandler);
         MsgMan.addObserver("ChildEvent.CHILD_ARENA_ISGROUPING",this,__childArenaIsgroupingHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("ChildEvent.CHILD_ARENA_UPDATE_MAIN",this,__updateChildArenaStateHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_ARENA_ISGROUPING",this,__childArenaIsgroupingHandler);
      }
      
      private function __updateChildArenaStateHandler(param1:String, param2:Object) : void
      {
         titleImage.setFrame(arenaModel.arenaType);
         leftView.refreshView();
         rightView.refreshView();
      }
      
      private function __childArenaIsgroupingHandler(param1:String, param2:Object) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("childpvp.state.isgroupingAlert"));
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               arenaModel.isInChildArena = false;
               ChildSender.requestChildArenaOp(8);
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get arenaModel() : ChildArenaModel
      {
         return ChildManager.instance.arenaModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(titleImage);
         titleImage = null;
         ObjectUtils.disposeObject(leftView);
         leftView = null;
         ObjectUtils.disposeObject(rightView);
         rightView = null;
         super.dispose();
      }
   }
}

