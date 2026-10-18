package views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.keyboard.KeyBoardRegister;
   
   public class GameStartPlayView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _startBtn:BaseButton;
      
      private var _callback:Function;
      
      public function GameStartPlayView()
      {
         super();
         initView();
         addEvent();
      }
      
      public function set callback(param1:Function) : void
      {
         _callback = param1;
      }
      
      private function initView() : void
      {
         if(ComponentSetting.isZhanQu)
         {
            _bg = ComponentFactory.Instance.creatComponentByStylename("novice.StartPlayBg3");
         }
         else if(ComponentSetting.is7road)
         {
            _bg = ComponentFactory.Instance.creatComponentByStylename("novice.StartPlayBg1");
         }
         else
         {
            _bg = ComponentFactory.Instance.creatComponentByStylename("novice.StartPlayBg2");
         }
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("novice.StartPlayStartBtn");
         addChild(_bg);
         addChild(_startBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__onStartPlayClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onStartPlayClick);
      }
      
      private function __onStartPlayClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,0,true,true,1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_callback != null)
         {
            _callback();
         }
         _callback = null;
      }
   }
}

