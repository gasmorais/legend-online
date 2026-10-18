package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class PvpMapControler extends FrameController
   {
      
      private var _frameClassName:String;
      
      private var _openType:int;
      
      public function PvpMapControler()
      {
         super();
      }
      
      override public function get frameClassName() : String
      {
         return _frameClassName;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_frameClassName == "flameTemple.gameOverView")
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["type"] = _openType;
            _frame["show"]();
         }
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(param1 && param1.openType == 4101)
         {
            _frameClassName = "flameTemple.gameOverView";
         }
         else
         {
            _frameClassName = "map.campaign.pvp.PvpMapFrame";
         }
         if(param1)
         {
            _openType = int(param1.openType);
         }
         super.start(param1);
      }
   }
}

