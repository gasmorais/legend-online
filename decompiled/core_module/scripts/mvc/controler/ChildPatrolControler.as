package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   
   public class ChildPatrolControler extends FrameController
   {
      
      private var _info:ChildPatrolTowerInfo;
      
      public function ChildPatrolControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         _info = param1.frameData as ChildPatrolTowerInfo;
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["data"] = _info;
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "childpatrol.ChildPatrolHallFrame";
         }
         if(_data.openType == 2)
         {
            return "childpatrol.ChildPatrolHeadQuartersFrame";
         }
         if(_data.openType == 3)
         {
            return "childpatrol.ChildPatrolTowerFrame";
         }
         if(_data.openType == 4)
         {
            return "childpatrol.ChildPatrolRiotFrame";
         }
         return "childpatrol.ChildPatrolHallFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

