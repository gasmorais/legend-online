package mvc.controler
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.controls.Frame;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.selectcampaign.SelectCampaignModel;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.view.community.LoadingSceneView;
   
   public class SelectCampaignController extends FrameController
   {
      
      private var _model:SelectCampaignModel;
      
      private var _isPreLoadOver:Boolean = false;
      
      public function SelectCampaignController()
      {
         super();
      }
      
      public function get model() : SelectCampaignModel
      {
         return _model;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         if(!_model)
         {
            _model = new SelectCampaignModel();
         }
         if(param1 && param1.frameData)
         {
            _model.taskCampaignTem = param1.frameData as CampaignTemplate;
         }
         _extraProgress = 20;
         super.start(param1);
      }
      
      override protected function createFrame() : void
      {
         super.createFrame();
         _isPreLoadOver = false;
      }
      
      override protected function showFrame() : void
      {
         NotificationManager.instance.sendNotification("STOP_EFFECT",false);
         super.showFrame();
         _frame["show"]();
      }
      
      override protected function get preLoad() : Boolean
      {
         if(_isPreLoadOver)
         {
            return !_isPreLoadOver;
         }
         model.getRecentCanSelectChapter();
         var _loc1_:String = "swf/singlecampaign1/" + model.recentChapter.chapterId + "/map/" + model.recentChapter.chapterId + ".swf";
         return !LoaderSavingManager.checkIsCached(PathManager.resourcePath + _loc1_);
      }
      
      override protected function startPreLoad() : void
      {
         var _loc1_:String = PathManager.resourcePath + "swf/singlecampaign1/" + model.recentChapter.chapterId + "/map/" + model.recentChapter.chapterId + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,8,__onComplete,__loadMapProgressHandler,null);
      }
      
      private function __loadMapProgressHandler(param1:LoaderInfo) : void
      {
         var _loc2_:Number = param1.bytesLoaded / param1.bytesTotal;
         LoadingSceneView.instance.update(int(_loc2_ * 100));
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         _isPreLoadOver = true;
         start(_data);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      override public function get frameClassName() : String
      {
         return "selectCP.SelectCampaignFrame";
      }
      
      override protected function exitFrame() : void
      {
         _frame = null;
         model.selectedChapter = null;
         model.selectedLand = null;
         model.selectedArea = null;
         _model = null;
         NotificationManager.instance.sendNotification("STOP_EFFECT",true);
         super.exitFrame();
      }
   }
}

