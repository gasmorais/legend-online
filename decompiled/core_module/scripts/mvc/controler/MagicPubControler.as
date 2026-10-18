package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class MagicPubControler extends FrameController
   {
      
      public static var needRefresh:Boolean;
      
      public function MagicPubControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
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
            setPreFrame("magiccard");
         }
      }
      
      override public function get frameClassName() : String
      {
         return "magicpub.MagicPubFrame";
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

