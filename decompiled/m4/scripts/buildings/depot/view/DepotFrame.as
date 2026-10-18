package buildings.depot.view
{
   import buildings.BaseBuildFrame;
   
   public class DepotFrame extends BaseBuildFrame
   {
      
      public function DepotFrame()
      {
         super();
         resetSize(630);
      }
      
      override protected function initView() : void
      {
         super.initView();
         if(_lineBg.parent)
         {
            _lineBg.parent.removeChild(_lineBg);
         }
      }
   }
}

