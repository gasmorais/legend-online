package buildings.titan.view
{
   import buildings.BaseBuildFrame;
   
   public class TitanFrame extends BaseBuildFrame
   {
      
      public function TitanFrame()
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

