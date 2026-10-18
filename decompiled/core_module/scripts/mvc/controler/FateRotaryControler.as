package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.fate.FateEditMsg;
   import mvc.FrameController;
   import mvc.module.faterotary.FateRotaryModel;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   
   public class FateRotaryControler extends FrameController
   {
      
      public var model:FateRotaryModel;
      
      public function FateRotaryControler()
      {
         super();
         model = new FateRotaryModel();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         return "faterotary.FateRotaryFrame";
      }
      
      public function traintFateGuardSkill(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8626);
         var _loc3_:FateEditMsg = new FateEditMsg();
         _loc3_.skillSonType = param1;
         _loc3_.useItemCount = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function runFateRotary(param1:int, param2:Boolean, param3:int, param4:int = 1) : void
      {
         var _loc6_:PackageOut = new PackageOut(8627);
         var _loc5_:FateEditMsg = new FateEditMsg();
         _loc5_.turnNum = param1;
         _loc5_.isDisable = param2;
         _loc5_.index = param3;
         _loc5_.payType = param4;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function getPointByLeftTime(param1:int, param2:int, param3:int) : int
      {
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         if(param3 == 0)
         {
            _loc7_ = playerModel.faterotaryCount;
         }
         else if(param3 == 1)
         {
            _loc7_ = playerModel.faterotaryCount1;
         }
         else if(param3 == 2)
         {
            _loc7_ = playerModel.faterotaryCount2;
         }
         var _loc9_:int = int(TempleteManager.instance.getConfigInfoByConfigName("Fate_FreeCount").ConfigValue);
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 > 0)
         {
            _loc4_ = 1;
            _loc5_ = param2 - _loc9_;
         }
         else
         {
            _loc4_ = _loc7_ - _loc9_ + 1;
            _loc5_ = _loc7_ + param2 - _loc9_;
         }
         var _loc10_:int = 0;
         var _loc6_:Array = TempleteManager.instance.getConfigInfoByConfigName("Fate_Turn").ConfigValue.split(",");
         _loc8_ = _loc4_ - 1;
         while(_loc8_ <= _loc5_ - 1)
         {
            if(_loc8_ > _loc6_.length - 1)
            {
               _loc10_ += int(_loc6_[_loc6_.length - 1]);
            }
            else
            {
               _loc10_ += int(_loc6_[_loc8_]);
            }
            _loc8_++;
         }
         return _loc10_;
      }
   }
}

