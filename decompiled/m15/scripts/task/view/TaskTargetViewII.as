package task.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.RingTaskManager;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskTemplate;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.manager.TempleteManager;
   
   public class TaskTargetViewII extends Sprite implements Disposeable
   {
      
      private var _targetTitle:Bitmap;
      
      private var _targetVBox:VBox;
      
      private var _ringTaskTxt:FilterFrameText;
      
      private var _data:Object;
      
      private var _ringTask:RingTask;
      
      public function TaskTargetViewII()
      {
         super();
         initView();
         refreshCondition();
      }
      
      private function initView() : void
      {
         _targetTitle = ComponentFactory.Instance.creatBitmap("asset.task.TaskTargetTitle");
         _targetVBox = ComponentFactory.Instance.creatComponentByStylename("task.TaskTargetVBox");
         _ringTaskTxt = ComponentFactory.Instance.creatComponentByStylename("task.ringTaskNum.text");
         addChild(_targetTitle);
         addChild(_targetVBox);
         addChild(_ringTaskTxt);
      }
      
      public function set data(param1:Object) : void
      {
         _ringTaskTxt.text = "";
         if(param1 is TaskTemplate)
         {
            _data = param1 as TaskTemplate;
         }
         else if(param1 is BaseOfferReward)
         {
            _data = (param1 as BaseOfferReward).rewardTemp;
         }
         else if(param1 is MarryTask)
         {
            _data = param1 as MarryTask;
         }
         else if(param1 is RingTask)
         {
            if(param1.ringTaskTemp.Type != 3)
            {
               _ringTaskTxt.text = LanguageMgr.GetTranslation("task.view.TaskTargetViewII.ringTaskNum",RingTaskManager.instance.model.rewardNum);
            }
            _ringTask = param1 as RingTask;
            _data = _ringTask;
         }
         clean();
         refreshCondition();
      }
      
      private function clean() : void
      {
         _targetVBox.disposeAllChildren();
         _targetVBox.refreshChildPos();
      }
      
      private function refreshCondition() : void
      {
         var _loc7_:int = 0;
         var _loc2_:Object = null;
         var _loc12_:TaskTargetItem = null;
         var _loc10_:String = null;
         var _loc5_:int = 0;
         var _loc1_:String = null;
         var _loc8_:OfferRewardConditionTemplate = null;
         var _loc11_:RingTask = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc3_:String = null;
         var _loc9_:CampaignTemplate = null;
         if(!_data)
         {
            return;
         }
         var _loc6_:Array = [];
         if(_data.hasOwnProperty("getProgress"))
         {
            _loc6_ = _data.getProgress();
         }
         _loc7_ = 0;
         while(_loc7_ < _data.conditionList.length)
         {
            _loc2_ = _data.conditionList[_loc7_];
            _loc12_ = new TaskTargetItem();
            _loc10_ = _loc2_.CondictionTitle;
            if(_data is TaskTemplate)
            {
               _loc12_.setConditionProgress(String(_loc6_[_loc7_]));
            }
            else if(_data is RingTask)
            {
               if(RingTaskManager.instance._isRingTask)
               {
                  if(_ringTask.ringTaskTemp.Type == 3)
                  {
                     _loc5_ = RingTaskManager.instance.model.rewardNum - 1;
                     _loc1_ = _loc5_ + " " + LanguageMgr.GetTranslation("ui.tasktracebar.view.ringTaskNum");
                     _loc12_.setConditionProgress(_loc1_);
                  }
                  else
                  {
                     _loc12_.setConditionProgress(String(_loc6_[_loc7_]));
                     _loc8_ = RingTaskManager.instance.getCurrCondition();
                     _loc11_ = RingTaskManager.instance.getRingTask();
                     switch(int(_loc8_.CondictionType) - 18)
                     {
                        case 0:
                           _loc9_ = TempleteManager.instance.getCampaignTemplateById(_loc11_.currTask.condition_2);
                           _loc10_ = _loc10_.replace("{0}",_loc9_.CampaignName);
                           break;
                        case 1:
                           _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc11_.currTask.condition_3);
                           _loc3_ = _loc4_.TemplateName;
                           _loc10_ = _loc10_.replace("{0}",_loc3_);
                     }
                  }
               }
               else if(_data is BaseOfferReward)
               {
                  _loc12_.setConditionProgress(String(_loc6_[_loc7_]));
               }
            }
            _loc12_.setCondition(_loc10_);
            _targetVBox.addChild(_loc12_);
            _loc7_++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_targetTitle);
         _targetTitle = null;
         ObjectUtils.disposeObject(_targetVBox);
         _targetVBox = null;
         ObjectUtils.disposeObject(_ringTaskTxt);
         _ringTaskTxt = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

