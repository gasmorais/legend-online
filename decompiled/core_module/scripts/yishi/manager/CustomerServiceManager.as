package yishi.manager
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.road.pb.helper.PkgHelper;
   import com.road.yishi.proto.customer.QuestionReplayMsg;
   import com.road.yishi.proto.customer.ReplayListMsg;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.customerService.CustomerServiceModel;
   import mvc.module.customerService.ServiceReplyInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.UserInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.resolve.QuestionReplyInfoResolve;
   import yishi.service.managers.SocketManager;
   import yishi.utils.GUID;
   import yishi.view.tips.MessageTipManager;
   
   public class CustomerServiceManager extends EventDispatcher
   {
      
      public static const NEW_REPLY:String = "new_reply";
      
      private static var _instance:CustomerServiceManager;
      
      private var _model:CustomerServiceModel;
      
      private var _uploadFile:FileReference;
      
      private var path:String;
      
      private var replyPath:String;
      
      private var submitEvulatePath:String;
      
      private var submitImagePath:String;
      
      public function CustomerServiceManager(param1:IEventDispatcher = null)
      {
         super(param1);
         path = PathManager.customerPath;
         replyPath = PathManager.customerReplyPath;
         submitEvulatePath = PathManager.customerSubmitEvaluatePath;
         submitImagePath = PathManager.customerSubmitImagePath;
      }
      
      public static function get instance() : CustomerServiceManager
      {
         if(!_instance)
         {
            _instance = new CustomerServiceManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         init();
         getReplyList();
         addEvent();
      }
      
      private function init() : void
      {
         _model = new CustomerServiceModel();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4376,_messageHandler);
      }
      
      public function uploadJpg() : void
      {
         _uploadFile = new FileReference();
         _uploadFile.addEventListener("select",_selectedHandler);
         try
         {
            _uploadFile.browse([new FileFilter("图片","*.jpg;*.gif;*.png;*jpeg;*bmp")]);
         }
         catch(error:Error)
         {
         }
      }
      
      private function _selectedHandler(param1:Event) : void
      {
         _uploadFile.removeEventListener("select",_selectedHandler);
         var _loc3_:UserInfo = PlayerManager.instance.currentPlayerModel.userInfo;
         var _loc4_:GUID = new GUID();
         var _loc2_:String = _loc4_.create();
         model.fileName = _loc3_.site + "_" + _loc3_.userId + "_" + _loc2_ + _uploadFile.type;
         model.data.pic_url = "/fileupload/pic/" + model.fileName;
      }
      
      private function sendImg() : void
      {
         if(!model.fileName)
         {
            return;
         }
         _uploadFile.addEventListener("uploadCompleteData",__completeDataHandler);
         _uploadFile.addEventListener("ioError",__ioErrorHandler);
         var _loc1_:URLRequest = new URLRequest(submitImagePath);
         _loc1_.method = "POST";
         _uploadFile.upload(_loc1_,model.fileName);
      }
      
      private function __completeDataHandler(param1:DataEvent) : void
      {
         model.fileName = null;
      }
      
      private function __ioErrorHandler(param1:IOErrorEvent) : void
      {
      }
      
      public function sendRead() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.user_id = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _loc1_.type = 1;
         _loc1_.question_id = _model.currentMessageId;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener("complete",__sendSuccessHandler);
         _loc3_.addEventListener("ioError",__sendSuccessHandler);
         var _loc2_:URLRequest = new URLRequest(replyPath);
         _loc2_.method = "POST";
         _loc2_.data = _loc1_;
         _loc3_.load(_loc2_);
      }
      
      private function __sendSuccessHandler(param1:Event) : void
      {
         var _loc2_:URLLoader = param1.currentTarget as URLLoader;
         _loc2_.removeEventListener("complete",__sendSuccessHandler);
         _loc2_.removeEventListener("ioError",__sendSuccessHandler);
      }
      
      public function getReplyList() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.user_id = PlayerManager.instance.currentPlayerModel.playerInfo.userId;
         _loc1_.type = 0;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.dataFormat = "binary";
         _loc3_.addEventListener("complete",_getReplyListHandler);
         _loc3_.addEventListener("ioError",_getReplyListHandler);
         var _loc2_:URLRequest = new URLRequest(replyPath);
         _loc2_.method = "POST";
         _loc2_.data = _loc1_;
         _loc3_.load(_loc2_);
      }
      
      private function _getReplyListHandler(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:XML = null;
         var _loc4_:URLLoader = param1.currentTarget as URLLoader;
         _loc4_.removeEventListener("complete",_getReplyListHandler);
         _loc4_.removeEventListener("ioError",_getReplyListHandler);
         var _loc5_:ByteArray = _loc4_.data as ByteArray;
         if(_loc5_)
         {
            _loc5_.uncompress();
            _loc5_.position = 0;
            _loc3_ = _loc5_.readUTFBytes(_loc5_.bytesAvailable);
            _loc5_.clear();
         }
         if(_loc3_)
         {
            _loc2_ = new XML(_loc3_);
            new QuestionReplyInfoResolve(_loc2_..Info,questionResolveBack).imediatyly();
         }
      }
      
      private function questionResolveBack(param1:Dictionary) : void
      {
         model.addReceiveMessage(param1);
         if(_model.receiveMessageList.length)
         {
            this.dispatchEvent(new Event("new_reply"));
         }
      }
      
      private function _messageHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ByteArray = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ReplayListMsg = new ReplayListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ReplayListMsg;
         var _loc5_:ServiceReplyInfo = new ServiceReplyInfo();
         for each(var _loc3_:QuestionReplayMsg in _loc2_.questionInfos)
         {
            _loc5_.questionId = _loc3_.questionId.toString();
            _loc5_.content = _loc3_.content;
            _loc5_.employ = _loc3_.employ.toString();
            _loc4_ = new ByteArray();
            _loc3_.commitTime.readBytes(_loc4_);
            _loc5_.date = PkgHelper.readDate(_loc4_);
            _loc5_.title = _loc3_.title;
            _loc5_.stopReply = _loc3_.stopReply.toString();
            _loc5_.replayUserName = _loc3_.replayUserName;
            _loc5_.replayContent = _loc3_.replayContent;
            _loc5_.type = _loc3_.type;
            _loc4_.clear();
            _loc4_ = null;
            _model.receiveMessageList.push(_loc5_);
         }
         dispatchNewReplyEvent();
      }
      
      public function dispatchNewReplyEvent() : void
      {
         model.lashReplyTime = 0;
         this.dispatchEvent(new Event("new_reply"));
      }
      
      public function sendHttpRequest() : void
      {
         if(checkBlank())
         {
            return;
         }
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener("complete",_onResultCompleted);
         _loc2_.addEventListener("ioError",_onResultCompleted);
         var _loc1_:URLRequest = new URLRequest(path);
         _loc1_.method = "POST";
         _loc1_.data = model.data;
         _loc2_.load(_loc1_);
         if(_uploadFile)
         {
            sendImg();
         }
         dispatchEvent(new Event("complete"));
      }
      
      public function sendServiceReply() : void
      {
         model.data.question_title = model.currentReplyInfo.title;
         model.data.nick_name = ArmyManager.instance.thane.nickName;
         if(checkBlank())
         {
            return;
         }
         model.data.question_id = model.currentMessageId;
         model.data.type = 2;
         model.data.reply_content = model.data.question_content;
         model.data.question_content = "";
         LoaderManagerII.instance.load(replyPath,7,8,_onResultCompleted,null,null,null,model.data,"POST");
         if(_uploadFile)
         {
            sendImg();
         }
         dispatchEvent(new Event("complete"));
      }
      
      private function _onResultCompleted(param1:Event) : void
      {
         var _loc3_:URLLoader = param1.currentTarget as URLLoader;
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:int = _loc3_.data;
         _loc3_.removeEventListener("complete",_onResultCompleted);
         _loc3_.removeEventListener("ioError",_onResultCompleted);
         switch(_loc2_ - -3)
         {
            case 0:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.CustomerServiceManger.content04"));
               break;
            case 1:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.CustomerServiceManger.content03"));
               break;
            case 3:
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.CustomerServiceManger.content02"));
               break;
            case 4:
               _model.hasSubmit = true;
               model.lashReplyTime = model.today.time;
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.CustomerServiceManger.content01"));
         }
      }
      
      public function sendEvaluate() : void
      {
         model.data.question_title = model.currentReplyInfo.title;
         model.data.question_id = _model.currentMessageId;
         if(checkBlank())
         {
            return;
         }
         model.data.appraisal_content = model.data.question_content;
         model.data.question_content = "";
         LoaderManagerII.instance.load(submitEvulatePath,7,8,_onResultCompleted,null,null,null,model.data,"POST");
         if(_uploadFile)
         {
            sendImg();
         }
         dispatchEvent(new Event("complete"));
      }
      
      private function checkBlank() : Boolean
      {
         if(!model.data.question_title)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.CustomerServiceManger.content05"));
            return true;
         }
         if(!model.data.question_content)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.CustomerServiceManger.content06"));
            return true;
         }
         if(String(model.data.question_content).length < 8)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.manager.CustomerServiceManger.content07"));
            return true;
         }
         return false;
      }
      
      public function get model() : CustomerServiceModel
      {
         return _model;
      }
   }
}

