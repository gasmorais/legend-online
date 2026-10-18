package mainBar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import ui.toptoolbar.TopToolsBar;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.view.community.TimeDownView;
   
   public class ForbidConsortiaView extends Sprite implements Disposeable
   {
      
      private var _timeTextBack:Bitmap;
      
      private var _image:Image;
      
      private var _lastOutConsortia:Number;
      
      private var _time:TimeDownView;
      
      public function ForbidConsortiaView(param1:Number)
      {
         super();
         _lastOutConsortia = param1;
         initView();
         initEvent();
      }
      
      private function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function initView() : void
      {
         _timeTextBack = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.buffer.TimeBack");
         _time = ComponentFactory.Instance.creatComponentByStylename("ForbidConsortiaView.buffer.TimeDownView");
         _image = ComponentFactory.Instance.creatComponentByStylename("ForbidConsortiaView.buffer.Image");
         _image.tipData = LanguageMgr.GetTranslation("mainBar.view.ForbidConsortiaView.Tips");
         _time.countStyle = "1";
         _time.timeCount = 86400 - (model.sysCurTimeBySecond - _lastOutConsortia);
         addChild(_timeTextBack);
         addChild(_image);
         addChild(_time);
      }
      
      private function initEvent() : void
      {
         if(_time)
         {
            _time.addEventListener("timerDown_complete",__timeCompleteHandler);
         }
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         TopToolsBar.instance.disposeForbidConsortiaView();
      }
      
      private function removeEvent() : void
      {
         if(_time)
         {
            _time.removeEventListener("timerDown_complete",__timeCompleteHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_image);
         _image = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         if(_timeTextBack)
         {
            removeChild(_timeTextBack);
         }
         _timeTextBack = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

