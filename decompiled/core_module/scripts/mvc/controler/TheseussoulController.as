package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import yishi.manager.FrameControllerManager;
   
   public class TheseussoulController extends FrameController
   {
      
      public var backTheseFrame:String;
      
      public function TheseussoulController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == 3 || _data.openType == 4 || _data.openType == 6 || _data.openType == 7)
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
         if(_data.openType == 1)
         {
            return "theseus.TheseusSuitFrame";
         }
         if(_data.openType == 2)
         {
            return "theseus.TheseusYiAllFrame";
         }
         if(_data.openType == 3)
         {
            return "playerInfo.TheseusOtherFrame";
         }
         if(_data.openType == 4)
         {
            return "theseus.TheseuswarFuhuCFrame";
         }
         if(_data.openType == 5)
         {
            return "theseus.TheseuswarIntensifyFrame";
         }
         if(_data.openType == 6)
         {
            return "theseus.war.TheseuswarGZMFrame";
         }
         if(_data.openType == 7)
         {
            return "theseus.war.TheseusWarStarChooseFrame";
         }
         if(_data.openType == 8)
         {
            return "theseus.warFrame.WarframeEnhancementFrame";
         }
         if(_data.openType == 9)
         {
            return "theseusCollention.TheseusCollenseFrame";
         }
         if(_data.openType == 10)
         {
            return "theseusgodhead.TheseusgodAllFrame";
         }
         if(_data.openType == 11)
         {
            return "theseusgodhead.TheseusGodheadFrame";
         }
         return "theseus.TheseussoulFrame";
      }
      
      override protected function exitFrame() : void
      {
         if(backTheseFrame && (_exitFrameName == "theseus.TheseuswarIntensifyFrame" || _exitFrameName == "theseus.warFrame.WarframeEnhancementFrame" || _exitFrameName == "theseusCollention.TheseusCollenseFrame"))
         {
            FrameControllerManager.instance.openControllerByInfo(backTheseFrame);
            backTheseFrame = null;
            _exitFrameName = null;
            _frame = null;
         }
         else
         {
            super.exitFrame();
         }
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
   }
}

