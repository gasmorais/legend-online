package mvc.controler
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.module.card.MagicCardModel;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class MagicCardControler extends FrameController
   {
      
      public static const CARDCHECK:int = 1;
      
      private var _model:MagicCardModel;
      
      public function MagicCardControler()
      {
         super();
         _model = new MagicCardModel();
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.frameData)
         {
            _frame["data"] = _data.frameData;
         }
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:Object = _data.openType;
         if(1 !== _loc1_)
         {
            return "magicCard.MagicCardFrame";
         }
         return "magicCard.MagicCardCheckFrame";
      }
      
      public function get model() : MagicCardModel
      {
         return _model;
      }
      
      public function openCardHelpFrame() : void
      {
         var _loc1_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("magicCard.HelpFrame");
         _loc1_.show();
      }
   }
}

