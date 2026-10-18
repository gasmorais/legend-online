package yishi.datas.consant
{
   public class MsgEventType
   {
      
      public static const SHOW_MAP_NAME_MOVIE:String = "SHOW_MAP_NAME_MOVIE";
      
      public static const SHOW_CONDITIONS_FRAME:String = "SHOW_CONDITIONS_FRAME";
      
      public static const SESSION_OVER:String = "SESSION_OVER";
      
      public static const BIG_BUGLE_EVENT:String = "yishi.datas.consant.BIG_BUGLE_EVENT";
      
      public static const SHOW_NUMBER_ONE_EVENT:String = "yishi.datas.consant.SHOW_NUMBER_ONE_EVENT";
      
      public static const GET_QUESTION_EVENT:String = "yishi.datas.consant.QUIZ_ACTIVITY_GET_QUESTION_EVENT";
      
      public static const GET_QUESTION_IS_OPNE_EVENT:String = "yishi.datas.consant.GET_QUESTION_IS_OPNE_EVENT";
      
      public static const GET_RANK_MY_INFO_EVENT:String = "yishi.datas.consant.GET_RANK_MY_INFO_EVENT";
      
      public static const UPDATE_RANK_INFO_EVENT:String = "yishi.datas.consant.UPDATE_RANK_INFO_EVENT";
      
      public static const VICE_PASSWORD_OP_SUCCESS_EVENT:String = "yishi.datas.consant.VICE_PASSWORD_OP_SUCCESS_EVENT";
      
      public static const SINGLE_COUNT:String = "yishi.datas.consant.SINGLE_COUNT_EVENT";
      
      public function MsgEventType()
      {
         super();
      }
      
      public function createEventData(param1:String, param2:Array) : String
      {
         var _loc3_:String = "event:" + param1;
         for each(var _loc4_:String in param2)
         {
            _loc3_ += "|" + _loc4_;
         }
         return _loc3_;
      }
   }
}

