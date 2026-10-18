package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import mvc.FrameController;
   import mvc.module.timestory.TimeStoryInfo;
   import mvc.module.timestory.TimeStoryModel;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PathManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.community.LoadingSceneView;
   
   public class TimeStoryControler extends FrameController
   {
      
      private var _model:TimeStoryModel;
      
      private var _needUpdate:Boolean;
      
      public function TimeStoryControler()
      {
         super();
         initEvent();
      }
      
      public function get model() : TimeStoryModel
      {
         return _model;
      }
      
      public function set model(param1:TimeStoryModel) : void
      {
         if(!_model)
         {
            _model = param1;
         }
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4492,__updateHandler);
      }
      
      private function __updateHandler(param1:SLGSocketEvent) : void
      {
         _needUpdate = true;
      }
      
      override protected function get preLoad() : Boolean
      {
         if(!_model || _needUpdate)
         {
            return true;
         }
         return false;
      }
      
      override protected function startPreLoad() : void
      {
         var _loc1_:String = PathManager.timeStoryPath;
         LoaderManagerII.instance.load(_loc1_,7,8,__completeHandler);
      }
      
      private function __completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc8_:TimeStoryInfo = null;
         var _loc6_:XMLList = null;
         _model = new TimeStoryModel();
         var _loc4_:XML = XML(param2);
         _model.time = _loc4_.@Time;
         _model.title = _loc4_.@Title;
         _model.id = _loc4_.@Id;
         _model.isActive = _loc4_.@IsActive;
         _model.opUser = _loc4_.@OpUser;
         _model.activeDate = _loc4_.@ActiveDate;
         _model.remark = _loc4_.@Remark;
         _model.nextDate = _loc4_.@NextDate;
         _model.music = ComponentSetting.RESOURCE_PATH + "ui/" + ComponentSetting.LANGUAGE + "/104.flv";
         var _loc5_:XMLList = _loc4_..Module;
         for each(var _loc7_:XML in _loc5_)
         {
            _loc8_ = new TimeStoryInfo();
            _loc8_.type = int(_loc7_.@modulename);
            _loc8_.count = _loc7_.@totalpage;
            _loc6_ = _loc7_..page;
            for each(var _loc3_:XML in _loc6_)
            {
               _loc8_.resList.push(_loc3_.@res.toString());
            }
            _model.addInfo(_loc8_);
         }
         _loc8_ = _model.getInfoByType(1);
         if(_loc8_)
         {
            _loc8_.count += 1;
            _loc8_.resList = [0].concat(_loc8_.resList);
         }
         _model.initTotalPage();
         _needUpdate = false;
         if(model.totalPage < 3)
         {
            exitFrame();
            if(_isLoadingLock)
            {
               LoadingSceneView.instance.hide();
            }
            _isLoadingLock = false;
            return;
         }
         super.start(_data);
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         _frame["show"](_data.openType);
      }
      
      override public function get frameClassName() : String
      {
         return "timestory.TimeStoryFrame";
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
         if(_data.frameData && _data.frameData is Function)
         {
            _data.frameData();
            _data.frameData = null;
         }
      }
   }
}

