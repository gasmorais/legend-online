package task.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class TaskTargetItem extends Sprite implements Disposeable
   {
      
      private var _taskIcon:Image;
      
      private var _conditionText:FilterFrameText;
      
      private var _conditionProgress:FilterFrameText;
      
      public function TaskTargetItem()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _taskIcon = ComponentFactory.Instance.creatComponentByStylename("task.TaskTargetIcon");
         _conditionText = ComponentFactory.Instance.creatComponentByStylename("task.TaskConditionText");
         _conditionProgress = ComponentFactory.Instance.creatComponentByStylename("task.TaskProgressText");
         addChild(_taskIcon);
         addChild(_conditionText);
         addChild(_conditionProgress);
      }
      
      public function setCondition(param1:String) : void
      {
         _conditionText.text = param1;
         _conditionText.width = _conditionText.textWidth + 5;
         _conditionProgress.x = _conditionText.x + _conditionText.width + 10;
      }
      
      public function setConditionProgress(param1:String) : void
      {
         var _loc2_:String = param1.substr(1,param1.length - 2);
         var _loc3_:int = _loc2_.indexOf("/");
         var _loc4_:String = _loc2_.substr(_loc3_,5);
         if(param1 == LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress"))
         {
            _conditionProgress.text = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
            _conditionProgress.setFrame(1);
         }
         else if(_loc4_ == "/ 200")
         {
            _conditionProgress.text = "(" + param1 + ")";
            _conditionProgress.setFrame(2);
         }
         else
         {
            if(param1 != " ")
            {
               _conditionProgress.text = "( " + param1.substr(1,param1.length - 2) + " )";
            }
            _conditionProgress.setFrame(2);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_taskIcon);
         _taskIcon = null;
         ObjectUtils.disposeObject(_conditionText);
         _conditionText = null;
         ObjectUtils.disposeObject(_conditionProgress);
         _conditionProgress = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

