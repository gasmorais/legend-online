package mvc.controler
{
   import manager.LanguageMgr;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import yishi.datas.VersionSwitch;
   import yishi.view.tips.MessageTipManager;
   
   public class KingContractControler extends FrameController
   {
      
      public function KingContractControler()
      {
         super();
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         var _loc2_:String = null;
         if(!VersionSwitch.KING_CONTRACT)
         {
            _loc2_ = LanguageMgr.GetTranslation("mvc.controler.KingContractControler.ConfigTipTxt");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"]();
      }
      
      override public function get frameClassName() : String
      {
         if(_data.openType == 1)
         {
            return "kingcontract.KingContractPresentFrame";
         }
         return "kingcontract.KingContractFrame";
      }
   }
}

