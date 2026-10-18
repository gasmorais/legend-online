package mvc.controler
{
   import mvc.FrameController;
   import yishi.manager.PlayerManager;
   
   public class MinosController extends FrameController
   {
      
      public static const Map:String = "Map";
      
      public static const GJ:String = "GJ";
      
      public static const SEASON:String = "SEASON";
      
      public function MinosController()
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
         var _loc1_:String = "consortia.view.minos.MinosEnterFrame";
         switch(_data.openType)
         {
            case "Map":
               _loc1_ = "consortia.view.minos.MinousmapFrame";
               break;
            case "GJ":
               _loc1_ = "consortia.view.minos.MinosGJRewardFrame";
               break;
            case "SEASON":
               _loc1_ = "consortia.view.minos.MinosSeaonRewardFrame";
         }
         return _loc1_;
      }
      
      override protected function exitFrame() : void
      {
         _frame = null;
         var _loc1_:int = PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID;
         if(_preModule && _loc1_ > 0)
         {
            openPreFrame();
         }
         _preModule = null;
         _preOpenType = null;
         _preData = null;
         _exitFrameName = null;
      }
   }
}

