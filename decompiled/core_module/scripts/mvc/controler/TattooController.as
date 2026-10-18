package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.tattoo.TattooEnhanceReqMsg;
   import com.road.yishi.proto.tattoo.TattooHoleReqMsg;
   import mvc.FrameController;
   import mvc.module.tattoo.TattooModel;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketSendManager;
   
   public class TattooController extends FrameController
   {
      
      private static const OP_INFO:int = 1;
      
      private static const OP_WASH:int = 2;
      
      private static const OP_REPLACE:int = 3;
      
      private var _tattooModel:TattooModel = new TattooModel();
      
      public function TattooController()
      {
         super();
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function sendReqTattooInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(9568);
         var _loc1_:TattooHoleReqMsg = new TattooHoleReqMsg();
         _loc1_.opType = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendRefresh(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:Boolean, param7:Boolean) : void
      {
         var _loc9_:PackageOut = new PackageOut(9568);
         var _loc8_:TattooHoleReqMsg = new TattooHoleReqMsg();
         _loc8_.opType = 2;
         _loc8_.param1 = param1;
         _loc8_.param2 = param2 + 1;
         _loc8_.lockPayType = param3;
         _loc8_.materialPayType = param4;
         _loc8_.refreshLockAdd = param5;
         _loc8_.refreshLockMinus = param6;
         _loc8_.autoBuy = param7;
         SocketSendManager.instance.sendProtoBuffer(_loc9_,_loc8_);
      }
      
      public function sendReplace(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9568);
         var _loc2_:TattooHoleReqMsg = new TattooHoleReqMsg();
         _loc2_.opType = 3;
         _loc2_.param2 = param1 + 1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function openPopFrame() : void
      {
         var _loc1_:Frame = ComponentFactory.Instance.creatComponentByStylename("tattoo.TattooPopFrame");
         _loc1_["show"]();
      }
      
      override public function get frameClassName() : String
      {
         return "tattoo.TattooFrame";
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      public function closeFrame() : void
      {
         _frame.dispose();
      }
      
      public function get tattooModel() : TattooModel
      {
         return _tattooModel;
      }
      
      public function sendTattooImprint(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(9603);
         var _loc3_:TattooEnhanceReqMsg = new TattooEnhanceReqMsg();
         _loc3_.holeId = param1;
         _loc3_.wish = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

