package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.datas.goods.GoodsInfo;
   
   public class TreasureMapFrameController extends FrameController
   {
      
      public function TreasureMapFrameController()
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
         if(_data && _data.openType == 2)
         {
            _frame["info"] = _data.frameData as GoodsInfo;
         }
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         if(_data && _data.openType == 1)
         {
            return "treasuremap.TreasureMapGetFrame";
         }
         if(_data && _data.openType == 2)
         {
            return "treasuremap.TreasureMapUseFrame";
         }
         return "treasuremap.TreasureMapGetFrame";
      }
      
      public function closeFrame() : void
      {
         if(_frame && _data.openType == 1)
         {
            _frame.dispose();
            _frame = null;
         }
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
      }
   }
}

