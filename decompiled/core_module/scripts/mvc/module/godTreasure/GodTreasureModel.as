package mvc.module.godTreasure
{
   import com.road.yishi.proto.active.GodTreasureRspMsg;
   import manager.LanguageMgr;
   import yishi.utils.SimpleAlertHelper;
   
   public class GodTreasureModel
   {
      
      private var _godTreasureInfo:GodTreasureInfo;
      
      public function GodTreasureModel()
      {
         super();
         _godTreasureInfo = new GodTreasureInfo();
      }
      
      public function updateInfo(param1:GodTreasureRspMsg) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         switch(param1.opType - 1)
         {
            case 0:
               _godTreasureInfo.op = param1.opType;
               _godTreasureInfo.grade = param1.grade;
               _godTreasureInfo.investDiamond = param1.diamond;
               _godTreasureInfo.level = param1.level;
               break;
            case 1:
               _godTreasureInfo.op = param1.opType;
               _godTreasureInfo.grade = param1.grade;
               _godTreasureInfo.investDiamond = param1.diamond;
               _godTreasureInfo.level = param1.level;
               break;
            case 2:
               _godTreasureInfo.op = param1.opType;
               _godTreasureInfo.grade = param1.grade;
               _godTreasureInfo.addInvestDiamond = param1.level;
               _godTreasureInfo.addEarnDiamond = param1.diamond;
               _loc2_ = LanguageMgr.GetTranslation("activity.godtreasure.TopToolsBar.str",_godTreasureInfo.addInvestDiamond,_godTreasureInfo.addEarnDiamond);
               SimpleAlertHelper.instance.data = [];
               _loc3_ = LanguageMgr.GetTranslation("public.confirm");
               _loc4_ = LanguageMgr.GetTranslation("public.prompt");
               SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc2_,_loc3_,"",false,true,true);
         }
      }
      
      public function get godTreasureInfo() : GodTreasureInfo
      {
         return _godTreasureInfo;
      }
      
      public function set sacrificeInfo(param1:GodTreasureInfo) : void
      {
         _godTreasureInfo = param1;
      }
   }
}

