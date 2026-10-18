package mvc.controler
{
   import mvc.FrameController;
   
   public class TheseusPvpController extends FrameController
   {
      
      public static const SORT:String = "SORT";
      
      public static const GLORY:String = "GLORY";
      
      public static const REWARD:String = "REWARD";
      
      public static const REPORT:String = "REPORT";
      
      public static const BACK_REPORT:String = "BACK_REPORT";
      
      public static const PRIVATE:String = "PRIVATE";
      
      public static const BATTLE_RESULT:String = "BATTLE_RESULT";
      
      public static const BUY_TIME:String = "BUY_TIME";
      
      public static const SORTDOUBLE:String = "SORTDOUBLE";
      
      public static const GLORYDOUBLE:String = "GLORYDOUBLE";
      
      public static const REWARDDOUBLE:String = "REWARDDOUBLE";
      
      public static const REPORTDOUBLE:String = "REPORTDOUBLE";
      
      public static const BACK_REPORTDOUBLE:String = "BACK_REPORTDOUBLE";
      
      public static const PRIVATE_DOUBLE:String = "PRIVATE_DOUBLE";
      
      public static const BATTLE_RESULTDOUBLE:String = "BATTLE_RESULTDOUBLE";
      
      public static const BUY_TIMEDOUBLE:String = "BUY_TIMEDOUBLE";
      
      private var _lockPreName:String;
      
      public function TheseusPvpController()
      {
         super();
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         if(_data.openType == "BATTLE_RESULT" || _data.openType == "BACK_REPORT" || _data.openType == "BACK_REPORTDOUBLE" || _data.openType == "BATTLE_RESULTDOUBLE")
         {
            _frame["show"](_data.frameData);
         }
         else
         {
            _frame["show"]();
         }
      }
      
      public function setLockPreFrame(param1:String, param2:String = null, param3:Object = null, param4:String = null) : void
      {
         _preModule = param1;
         _preOpenType = param2;
         _preData = param3;
         _lockPreName = param4;
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "";
         switch(_data.openType)
         {
            case "SORT":
               _loc1_ = "theseuspvp.TheseusPvpServerSortFrame";
               break;
            case "GLORY":
               _loc1_ = "theseuspvp.TheseusPvpGloryFrame";
               break;
            case "REWARD":
               _loc1_ = "theseuspvp.TheseusPvpRewardFrame";
               break;
            case "REPORT":
               _loc1_ = "theseuspvp.TheseusPvpReportFrame";
               break;
            case "BACK_REPORT":
               _loc1_ = "theseuspvp.TheseuspvpBackReportFrame";
               break;
            case "PRIVATE":
               _loc1_ = "theseuspvp.TheseusGloryRewardFrame";
               break;
            case "BATTLE_RESULT":
               _loc1_ = "theseuspvp.TheseusPvpResultFrame";
               break;
            case "BUY_TIME":
               _loc1_ = "theseuspvp.TheseusPvpBuyTimeFrame";
               break;
            case "SORTDOUBLE":
               _loc1_ = "theseusdoublepvp.TheseusDoublePvpServerSortFrame";
               break;
            case "REWARDDOUBLE":
               _loc1_ = "theseusdoublepvp.TheseusDoublePvpRewardFrame";
               break;
            case "REPORTDOUBLE":
               _preModule = "theseusroomlist";
               _lockPreName = "theseusdoublepvproom.TheseusDoubleRoomListFrame";
               _loc1_ = "theseusdoublepvp.TheseusDoublePvpReportFrame";
               break;
            case "BACK_REPORTDOUBLE":
               _loc1_ = "theseusdoublepvp.TheseuspvpDoubleBackReportFrame";
               break;
            case "BATTLE_RESULTDOUBLE":
               _loc1_ = "theseusdoublepvp.TheseusDoublePvpResultFrame";
               break;
            case "BUY_TIMEDOUBLE":
               _loc1_ = "theseusdoublepvp.TheseusDoublePvpBuyTimeFrame";
               break;
            case "PRIVATE_DOUBLE":
               _loc1_ = "theseusdoublepvp.TheseusDoubleGloryRewardFrame";
         }
         return _loc1_;
      }
   }
}

