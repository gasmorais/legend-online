package secretadventure.map
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.datas.templates.SecretMapDataTemplate;
   import yishi.manager.TempleteManager;
   
   public class SecretAdMapRightView extends Sprite
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _taskBg:Bitmap;
      
      private var _task:Bitmap;
      
      private var _desTxt:FilterFrameText;
      
      public function SecretAdMapRightView()
      {
         super();
         initView();
         initEvent();
         __onResize();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ui.secret.mapright.Back");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secret.mapright.desTxt");
         _taskBg = ComponentFactory.Instance.creatBitmap("asset.secretad.taskTBg");
         _task = ComponentFactory.Instance.creatBitmap("asset.secretad.task");
         addChild(_back);
         addChild(_desTxt);
         addChild(_taskBg);
         addChild(_task);
      }
      
      public function refreshView(param1:int) : void
      {
         var _loc2_:SecretMapDataTemplate = TempleteManager.instance.secretSonDataCate.getTempInfo(param1);
         if(_loc2_)
         {
            _desTxt.text = _loc2_.Introduction;
         }
      }
      
      private function initEvent() : void
      {
         StageReferance.addEventListener("resize",__onResize);
      }
      
      private function removeEvent() : void
      {
         StageReferance.removeEventListener("resize",__onResize);
      }
      
      private function __onResize(param1:Event = null) : void
      {
         x = StageReferance.gameStageWidth - width;
         y = 259;
         var _loc2_:int = 987 - width;
         if(x < _loc2_)
         {
            x = _loc2_;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_task);
         _task = null;
         ObjectUtils.disposeObject(_taskBg);
         _taskBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

