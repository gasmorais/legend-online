package funny.activity
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.ActivityManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ActivityCodeView extends Sprite implements Disposeable
   {
      
      private var _clickBoo:Boolean;
      
      private var _clickTiemCount:int;
      
      private var _content:FilterFrameText;
      
      private var _button:IconButton;
      
      private var _codeText:FilterFrameText;
      
      private var _back:MutipleImage;
      
      private const SIGN:String = "SQ-";
      
      public function ActivityCodeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("funny.activityCodeBack");
         _content = ComponentFactory.Instance.creatComponentByStylename("funny.activity.ItemContent");
         _button = ComponentFactory.Instance.creatComponentByStylename("funny.activity.ItemButtonMc1");
         _codeText = ComponentFactory.Instance.creatComponentByStylename("funny.activity.ItemInput");
         addChild(_back);
         addChild(_content);
         addChild(_codeText);
         addChild(_button);
         _content.text = LanguageMgr.GetTranslation("activity.view.ActivityItem.content");
         _codeText.text = LanguageMgr.GetTranslation("activity.view.ActivityItem.input");
      }
      
      private function initEvent() : void
      {
         _button.addEventListener("click",__onClick);
         _codeText.addEventListener("keyDown",__keyDownHandler);
         _codeText.addEventListener("click",__InputClick);
      }
      
      private function __InputClick(param1:MouseEvent) : void
      {
         if(_codeText.text == LanguageMgr.GetTranslation("activity.view.ActivityItem.input"))
         {
            _codeText.text = "";
         }
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __onClick(null);
         }
         param1.stopPropagation();
      }
      
      private function removeEvent() : void
      {
         clearTimeout(_clickTiemCount);
         _button.removeEventListener("click",__onClick);
         _codeText.removeEventListener("keyDown",__keyDownHandler);
         _codeText.removeEventListener("click",__InputClick);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = "";
         var _loc3_:String = _codeText.text;
         _loc3_ = _loc3_.replace(/^\s*/g,"");
         _loc3_ = _loc3_.replace(/\s*$/g,"");
         if(_loc3_ == "" || _loc3_ == LanguageMgr.GetTranslation("activity.view.ActivityItem.content"))
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.content");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_clickBoo)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _clickBoo = true;
         _clickTiemCount = setTimeout(clickTime,5000);
         if(_loc3_.substr(0,3) == "SQ-")
         {
            ActivityManager.Instance.senActivityCodeServlet(_loc3_);
         }
         else
         {
            ActivityManager.Instance.senActivityCode(_loc3_,"0");
         }
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

