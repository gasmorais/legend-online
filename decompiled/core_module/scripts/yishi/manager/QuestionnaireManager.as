package yishi.manager
{
   import com.road.yishi.proto.questionnarie.QuestionDataRspMsg;
   import com.road.yishi.proto.questionnarie.QuestionnarieInfoMsg;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import mvc.module.questionnaire.QuestionnaireModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class QuestionnaireManager extends EventDispatcher
   {
      
      private static const GOODS_ID:String = "GOODS_ID";
      
      private static const GOODS_COUNT:String = "GOODS_COUNT";
      
      private static var _instance:QuestionnaireManager;
      
      private var _model:QuestionnaireModel;
      
      public function QuestionnaireManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : QuestionnaireManager
      {
         if(!_instance)
         {
            _instance = new QuestionnaireManager();
         }
         return _instance;
      }
      
      public function get model() : QuestionnaireModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new QuestionnaireModel();
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4428,__getQuestionnaireHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4429,__getAnswerHandler);
      }
      
      private function __getQuestionnaireHandler(param1:SLGSocketEvent) : void
      {
         model.questionnaireVisible = true;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:QuestionnarieInfoMsg = new QuestionnarieInfoMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as QuestionnarieInfoMsg;
         model.questionId = _loc2_.id;
         if(_loc2_.id)
         {
            model.questionnaireVisible = true;
         }
         else
         {
            model.questionnaireVisible = false;
         }
         var _loc5_:Object = {
            "itemId":_loc2_.itemId1,
            "itemCount":_loc2_.count1
         };
         var _loc6_:Object = {
            "itemId":_loc2_.itemId2,
            "itemCount":_loc2_.count2
         };
         var _loc3_:Object = {
            "itemId":_loc2_.itemId3,
            "itemCount":_loc2_.count3
         };
         var _loc4_:Object = {
            "itemId":_loc2_.itemId4,
            "itemCount":_loc2_.count4
         };
         model.questionGoodList = [];
         model.questionList = _loc2_.questiones;
         model.questionContent = _loc2_.content;
         model.questionGoodList.push(_loc5_,_loc6_,_loc3_,_loc4_);
      }
      
      private function __getAnswerHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:QuestionDataRspMsg = new QuestionDataRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as QuestionDataRspMsg;
         model.answerList = _loc2_.infolist;
      }
      
      public function sendQuestionAnswer(param1:int, param2:int = 0, param3:Array = null) : void
      {
         var _loc5_:PackageOut = new PackageOut(8534);
         var _loc4_:QuestionDataRspMsg = new QuestionDataRspMsg();
         _loc4_.isFirst = param1;
         _loc4_.id = param2;
         _loc4_.infolist = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
   }
}

