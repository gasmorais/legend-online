package mvc.module.customerService
{
   import events.CustomerServiceEvent;
   import flash.events.EventDispatcher;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.manager.CustomerServiceManager;
   import yishi.manager.PlayerManager;
   
   public class CustomerServiceModel extends EventDispatcher
   {
      
      public var problemList:Vector.<Object> = new Vector.<Object>();
      
      private var _viewType:String = "ConsultingGameView";
      
      public var data:URLVariables;
      
      public var receiveMessageList:Array = [];
      
      private var _lastReplyTime:Number = 0;
      
      private var _hasSubmit:Boolean = false;
      
      private var _currentReplyInfo:ServiceReplyInfo;
      
      private var _fileName:String;
      
      public function CustomerServiceModel()
      {
         super();
         init();
      }
      
      public function get currentMessageId() : String
      {
         if(_currentReplyInfo)
         {
            return _currentReplyInfo.questionId;
         }
         return "0";
      }
      
      public function get currentQuestionType() : int
      {
         if(_currentReplyInfo)
         {
            return _currentReplyInfo.type;
         }
         return 0;
      }
      
      public function get stopReply() : int
      {
         if(_currentReplyInfo)
         {
            return parseInt(_currentReplyInfo.stopReply);
         }
         return 0;
      }
      
      public function get currentReplyInfo() : ServiceReplyInfo
      {
         return _currentReplyInfo;
      }
      
      public function get viewType() : String
      {
         return _viewType;
      }
      
      public function set viewType(param1:String) : void
      {
         if(param1.length <= 2)
         {
            data.question_type = parseInt(param1);
            switch(param1)
            {
               case "0":
                  _viewType = "CustomerServiceSelectedView";
                  break;
               case "4":
                  _viewType = "HanckingView_1";
                  break;
               case "5":
                  _viewType = "ChargeView";
                  break;
               case "7":
                  _viewType = "BugReportView";
                  break;
               case "6":
                  _viewType = "ProposalView";
                  break;
               case "3":
                  _viewType = "GoodsMissView";
                  break;
               case "1":
                  _viewType = "ConsultingGameView";
                  break;
               case "2":
                  _viewType = "ActivityView";
                  break;
               case "8":
                  _viewType = "ReportIllegalView";
                  break;
               case "9":
                  _viewType = "ComplainView";
                  break;
               case "10":
                  _viewType = "OtherView";
            }
         }
         else
         {
            _viewType = param1;
            data.question_type = getViewIdByType(_viewType);
         }
      }
      
      private function init() : void
      {
         problemList.push({
            "id":1,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content02")
         },{
            "id":2,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content03")
         },{
            "id":3,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content04")
         },{
            "id":4,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content05")
         },{
            "id":5,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content06")
         },{
            "id":6,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content07")
         },{
            "id":7,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content08")
         },{
            "id":8,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content09")
         },{
            "id":9,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content10")
         },{
            "id":10,
            "name":LanguageMgr.GetTranslation("customerservice.CustomerServiceModel.content11")
         });
         refreshData();
      }
      
      public function refreshData() : void
      {
         data = new URLVariables();
         data.user_id = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         data.question_type = getViewIdByType(_viewType);
         _currentReplyInfo = null;
         if(receiveMessageList.length)
         {
            CustomerServiceManager.instance.dispatchNewReplyEvent();
         }
      }
      
      public function get today() : Date
      {
         return PlayerManager.instance.currentPlayerModel.sysCurtime;
      }
      
      public function getViewIdByType(param1:String) : int
      {
         switch(param1)
         {
            case "CustomerServiceSelectedView":
               return 0;
            case "HanckingView_1":
            case "HanckingView_2":
               break;
            case "ProposalView":
               return 6;
            case "ReportIllegalView":
               return 8;
            case "BugReportView":
               return 7;
            case "GoodsMissView":
               return 3;
            case "ConsultingGameView":
               return 1;
            case "ActivityView":
               return 2;
            case "OtherView":
               return 10;
            case "ChargeView":
               return 5;
            case "ComplainView":
               return 9;
            default:
               return currentQuestionType;
         }
         return 4;
      }
      
      public function viewIdToString(param1:String) : String
      {
         var _loc2_:String = null;
         switch(param1)
         {
            case "0":
               _loc2_ = "CustomerServiceSelectedView";
               break;
            case "4":
               _loc2_ = "HanckingView_1";
               break;
            case "5":
               _loc2_ = "ChargeView";
               break;
            case "7":
               _loc2_ = "BugReportView";
               break;
            case "6":
               _loc2_ = "ProposalView";
               break;
            case "3":
               _loc2_ = "GoodsMissView";
               break;
            case "1":
               _loc2_ = "ConsultingGameView";
               break;
            case "2":
               _loc2_ = "ActivityView";
               break;
            case "8":
               _loc2_ = "ReportIllegalView";
               break;
            case "9":
               _loc2_ = "ComplainView";
               break;
            case "10":
               _loc2_ = "OtherView";
         }
         return _loc2_;
      }
      
      public function getMessage() : ServiceReplyInfo
      {
         if(receiveMessageList.length)
         {
            _currentReplyInfo = receiveMessageList.pop() as ServiceReplyInfo;
            return _currentReplyInfo;
         }
         return null;
      }
      
      public function addReceiveMessage(param1:Dictionary) : void
      {
         for each(var _loc2_:ServiceReplyInfo in param1)
         {
            receiveMessageList.push(_loc2_);
         }
      }
      
      public function get canOpen() : Boolean
      {
         if(!_lastReplyTime)
         {
            return true;
         }
         if(today.time - _lastReplyTime > 1800000)
         {
            return true;
         }
         return false;
      }
      
      public function set lashReplyTime(param1:Number) : void
      {
         _lastReplyTime = param1;
         _hasSubmit = false;
      }
      
      public function set hasSubmit(param1:Boolean) : void
      {
         _hasSubmit = param1;
      }
      
      public function get fileName() : String
      {
         return _fileName;
      }
      
      public function set fileName(param1:String) : void
      {
         _fileName = param1;
         dispatchEvent(new CustomerServiceEvent("UPLOAD_SUCCESS"));
      }
   }
}

