package mvc.controler
{
   import mvc.FrameController;
   
   public class SqMemoryController extends FrameController
   {
      
      private var _isGetData:Boolean = true;
      
      public function SqMemoryController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == 2)
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
         switch(_data.openType)
         {
            case 1:
               return "sqmemory.SqmemoryShareFrame";
            case 2:
               return "sqmemory.SqmemoryLabelFrame";
            case 3:
               return "sqmemory.SqmemoryRewardFrame";
            default:
               return "sqmemory.SqmemoryMainFrame";
         }
      }
   }
}

