package mvc.controler
{
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   
   public class AncientArtifactControler extends FrameController
   {
      
      public function AncientArtifactControler()
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
         if(_data.openType == 1)
         {
            _frame["show"](_data.frameData);
         }
         else if(_data.openType == 2)
         {
            _frame["show"](_data.frameData);
         }
         else if(_data.openType == 3)
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
            return "ancientartifact.AncientAdvanceFrame";
         }
         if(_data.openType == 2)
         {
            return "ancientartifact.AncientEquipView";
         }
         if(_data.openType == 3)
         {
            return "ancientartifact.AncientResonateUpGradeFrame";
         }
         return "ancientartifact.AncientArtifactFrame";
      }
   }
}

