package mvc.controler
{
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.buildings.BuildInfo;
   
   public class BuildingControler extends FrameController
   {
      
      private var _info:BuildInfo;
      
      public function BuildingControler()
      {
         super();
      }
      
      public static function getModelNameByInfo(param1:BuildInfo) : String
      {
         switch(param1.templeteInfo.MasterType - 1)
         {
            case 0:
               return "crystal";
            case 3:
               return "casern";
            case 4:
            case 12:
               return "seminary";
            case 7:
               return "transferbuilding";
            case 8:
               return "politics";
            case 9:
               return "titan";
            case 10:
               return "market";
            case 11:
               return "residence";
            case 14:
               return "offerreward";
            case 15:
               return "magiccard";
            case 16:
               return "perkinlab";
            case 17:
               return "magiccard";
            default:
               return "";
         }
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         _info = param1.frameData as BuildInfo;
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         if(!_info)
         {
            return;
         }
         _frame["data"] = _info;
         _frame["show"]();
         super.showFrame();
      }
      
      public function getFrameBySontype(param1:int) : Frame
      {
         if(_frame && _frame["data"] && _frame["data"].sonType == param1)
         {
            return _frame;
         }
         return null;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         switch(_info.templeteInfo.MasterType - 1)
         {
            case 0:
               return "crystal.CrystalFrame";
            case 3:
               return "casern.CasernFrame";
            case 4:
               return "seminary.SeminaryFrame";
            case 7:
               return "transferbuilding.TransferBuildFrame";
            case 8:
               return "politics.PoliticsFrame";
            case 9:
               return "titan.TitanFrame";
            case 10:
               return "market.MarkertBuildFrame";
            case 11:
               return "residence.ResidenceFrame";
            case 14:
               return "offerReward.OfferRewardFrame";
            default:
               return "";
         }
      }
   }
}

