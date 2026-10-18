package task.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class TaskRewardItem extends Sprite implements Disposeable
   {
      
      private static var iconTips:Array = [LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips01"),LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips02"),LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips03"),LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips04"),LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips05"),LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips06"),LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips07")];
      
      private var _icon:ScaleFrameImage;
      
      private var _value:FilterFrameText;
      
      public function TaskRewardItem()
      {
         super();
         _icon = ComponentFactory.Instance.creatComponentByStylename("task.TaskRewardItemName");
         _value = ComponentFactory.Instance.creatComponentByStylename("task.TaskRewardItemValue");
         addChild(_icon);
         addChild(_value);
      }
      
      public function set propertyName(param1:int) : void
      {
         _icon.setFrame(param1);
         _icon.tipData = iconTips[param1 - 1];
      }
      
      public function set propertyValue(param1:String) : void
      {
         _value.text = param1;
      }
      
      public function dispose() : void
      {
         if(_icon)
         {
            _icon.dispose();
         }
         if(_value)
         {
            _value.dispose();
         }
         _icon = null;
         _value = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

