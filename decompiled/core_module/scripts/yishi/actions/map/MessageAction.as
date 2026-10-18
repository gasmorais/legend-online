package yishi.actions.map
{
   import yishi.comm.PackageIn;
   import yishi.manager.ServerFrameManager;
   import yishi.scene.SceneManager;
   
   public class MessageAction extends MapBaseAction
   {
      
      private var _pkg:PackageIn;
      
      private var _count:int;
      
      public function MessageAction(param1:PackageIn)
      {
         super();
         _pkg = param1;
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(_count == 1)
         {
            ServerFrameManager.instance.createFrame(_pkg,dispose);
         }
         else if(_count > 750)
         {
            dispose();
         }
         _count = _count + 1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

