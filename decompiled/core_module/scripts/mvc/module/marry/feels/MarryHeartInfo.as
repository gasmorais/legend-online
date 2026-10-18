package mvc.module.marry.feels
{
   public class MarryHeartInfo
   {
      
      public var curQuestion:MarryQuestionInfo;
      
      private var _answeredList:Vector.<MarryQuestionInfo>;
      
      public var maxOrder:int;
      
      public var syncRate:int;
      
      public function MarryHeartInfo()
      {
         super();
      }
      
      public function get answeredList() : Vector.<MarryQuestionInfo>
      {
         if(_answeredList == null)
         {
            _answeredList = new Vector.<MarryQuestionInfo>();
         }
         return _answeredList;
      }
      
      public function set answeredList(param1:Vector.<MarryQuestionInfo>) : void
      {
         if(param1 == null)
         {
            return;
         }
         _answeredList = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:MarryQuestionInfo = null;
         if(curQuestion && curQuestion.options)
         {
            curQuestion.options.splice(0);
         }
         if(_answeredList)
         {
            while(_answeredList.length > 0)
            {
               _loc1_ = _answeredList.pop();
               if(_loc1_.options)
               {
                  _loc1_.options.splice(0);
               }
            }
         }
         curQuestion = null;
         _answeredList = null;
      }
   }
}

