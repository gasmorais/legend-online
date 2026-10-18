package mvc.controler
{
   import mvc.FrameController;
   
   public class RevengeRoadController extends FrameController
   {
      
      public function RevengeRoadController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData)
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      override public function get frameClassName() : String
      {
         var _loc2_:String = String(_data.openType);
         var _loc1_:String = "revenge.RevengeRoadFrame";
         switch(_loc2_)
         {
            case "node":
               _loc1_ = "revenge.RevengeNodeFrame";
               break;
            case "fight":
               _loc1_ = "revenge.RevengeFightFrame";
         }
         return _loc1_;
      }
   }
}

