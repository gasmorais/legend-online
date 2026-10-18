package funny.activity
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.ActivityManager;
   import mvc.module.funny.ActiveInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.SharedManager;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ActivityItem2 extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _button:IconButton;
      
      private var _icon:BaseIconView;
      
      private var _clickBoo:Boolean;
      
      private var _clickTiemCount:int;
      
      private var _activeInfo:ActiveInfo;
      
      private var _hasGet:Bitmap;
      
      public function ActivityItem2()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.funny.ItemBack");
         _name = ComponentFactory.Instance.creatComponentByStylename("funny.activity.ItemName2");
         _content = ComponentFactory.Instance.creatComponentByStylename("funny.activity.ItemContent2");
         _button = ComponentFactory.Instance.creatComponentByStylename("funnyRewardItem.getBtn");
         _icon = ComponentFactory.Instance.creatCustomObject("funny.activity.ItemIcon");
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.core.ReceivedImg");
         addChild(_back);
         addChild(_name);
         addChild(_content);
         addChild(_button);
         addChild(_icon);
         addChild(_hasGet);
         _hasGet.x = 415;
         _hasGet.y = 41;
         _hasGet.visible = false;
      }
      
      private function initEvent() : void
      {
         _button.addEventListener("click",__buttonHandler);
      }
      
      private function removeEvent() : void
      {
         clearTimeout(_clickTiemCount);
         _button.removeEventListener("click",__buttonHandler);
      }
      
      public function set activityTemplate(param1:ActiveInfo) : void
      {
         _activeInfo = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         _name.text = _activeInfo.title;
         _content.text = _activeInfo.description;
         if(_activeInfo.status == 1)
         {
            _hasGet.visible = true;
            _button.visible = false;
         }
      }
      
      private function __buttonHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SharedManager.instance.activeDic[_activeInfo.activeId] = 1;
         SharedManager.instance.saveActiveDic();
         var _loc2_:String = "";
         if(_clickBoo)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _clickBoo = true;
         _clickTiemCount = setTimeout(clickTime,5000);
         if(_activeInfo.grades > ArmyManager.instance.thane.grades)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_activeInfo.consortia > ConsortiaManager.instance.model.consortiaInfo.levels)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         ActivityManager.Instance.senActivityCode("-1",_activeInfo.activeId);
      }
      
      private function clickTime() : void
      {
         clearTimeout(_clickTiemCount);
         _clickBoo = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

