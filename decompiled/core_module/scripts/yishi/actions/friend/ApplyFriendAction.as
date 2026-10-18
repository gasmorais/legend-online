package yishi.actions.friend
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.events.Event;
   import yishi.actions.map.MapBaseAction;
   import yishi.manager.FriendManager;
   import yishi.scene.SceneManager;
   import yishi.view.frame.ApplyFriendFrame;
   
   public class ApplyFriendAction extends MapBaseAction
   {
      
      private var _isPop:Boolean;
      
      private var _name:String;
      
      private var _msg:String;
      
      private var _frame:ApplyFriendFrame;
      
      public function ApplyFriendAction(param1:String, param2:String)
      {
         _name = param1;
         _msg = param2;
         super();
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(!_isPop)
         {
            createApplyFriendFrame(_name,_msg);
            _isPop = true;
         }
      }
      
      private function createApplyFriendFrame(param1:String, param2:String) : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("friends.ApplyFriendFrame");
         _frame.nameText = param1;
         _frame.psText = param2;
         _frame.show();
         _frame.addEventListener("close",__requestFrameCloseHandler);
         FriendManager.getInstance().noteApplyPopFrame(param1);
      }
      
      private function __requestFrameCloseHandler(param1:Event) : void
      {
         _frame.removeEventListener("close",__requestFrameCloseHandler);
         FriendManager.getInstance().removeNoteApplyPopFrame(_frame.nameString);
         _frame = null;
         dispose();
      }
   }
}

