package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mediator.AuctionMessageHandler;
   import mvc.FrameController;
   import mvc.module.auction.AuctionModel;
   import yishi.keyboard.KeyBoardRegister;
   
   public class AuctionControl extends FrameController
   {
      
      private var _model:AuctionModel;
      
      private var _messageHandler:AuctionMessageHandler;
      
      public function AuctionControl()
      {
         super();
         _model = new AuctionModel();
      }
      
      override protected function showFrame() : void
      {
         _messageHandler = new AuctionMessageHandler();
         super.showFrame();
         _frame["show"]();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function get frameClassName() : String
      {
         return "auction.AuctionFrame";
      }
      
      override protected function exitFrame() : void
      {
         _messageHandler.dispose();
         _messageHandler = null;
         super.exitFrame();
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      public function get model() : AuctionModel
      {
         return _model;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

