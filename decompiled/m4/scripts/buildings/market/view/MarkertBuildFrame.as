package buildings.market.view
{
   import buildings.BaseBuildFrame;
   
   public class MarkertBuildFrame extends BaseBuildFrame
   {
      
      public function MarkertBuildFrame()
      {
         super();
         defaultView();
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

