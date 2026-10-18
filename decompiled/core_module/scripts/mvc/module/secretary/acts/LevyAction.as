package mvc.module.secretary.acts
{
   import yishi.manager.PlayerManager;
   
   public class LevyAction extends ILitteAction
   {
      
      public function LevyAction()
      {
         super();
      }
      
      override public function exc() : void
      {
         PlayerManager.instance.sendLevy(2);
         isFinish = true;
      }
   }
}

